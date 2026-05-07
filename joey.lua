-- ── INITIALIZATION ────────────────────────────────────────────────
-- Find the speaker
local speakers = { peripheral.find("speaker") }
if #speakers == 0 then
    print("ERROR: No speaker attached!")
    return
end

-- ── CONFIG ────────────────────────────────────────────────────────
local SERVER = "https://9ffff80e212eac.lhr.life"
local VOLUME = 3.0 -- Max radius, zero distortion

-- ── HELPERS ───────────────────────────────────────────────────────
local function getTracks()
    local r = http.get(SERVER .. "/tracks")
    if not r then return {} end
    
    local raw = r.readAll()
    r.close()
    
    local t = {}
    for name in raw:gmatch('"([^"]+)"') do 
        t[#t+1] = name 
    end
    return t
end

local function streamTrack(filename)
    -- URL encode to handle wild file names
    local safe_filename = filename:gsub("([^%w _%%%-%.~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end):gsub(" ", "%%20")

    local url = SERVER .. "/play/" .. safe_filename
    local res, err = http.get(url, nil, true)

    if not res then
        print("[music] fetch failed: " .. tostring(err))
        return
    end

    print("[music] Streaming: " .. filename)
    
    -- Hard-stop the speaker to wipe leftover garbage
    speakers[1].stop()

    while true do
        local chunk = res.read(16384)
        if not chunk or #chunk == 0 then break end

        local pcm = {}
        for i = 1, #chunk do
            local b = string.byte(chunk, i)
            -- Math for signed 8-bit PCM
            if b > 127 then b = b - 256 end
            pcm[i] = b
        end

        -- Anti-stutter: Yield 2 ticks so it drains slightly, then top it back up
        while not speakers[1].playAudio(pcm, VOLUME) do
            os.sleep(0.1)
        end
    end

    res.close()
    speakers[1].stop()
end

-- ── MAIN EXECUTION LOOP ───────────────────────────────────────────
print("Booting Audio Engine...")
print("Target: " .. SERVER)

while true do
    local tracks = getTracks()
    
    if #tracks == 0 then
        print("[music] No tracks found or server unreachable. Retrying in 5s...")
        os.sleep(5)
    else
        for _, track in ipairs(tracks) do
            streamTrack(track)
            os.sleep(1) -- Tiny buffer pause between songs
        end
    end
end
