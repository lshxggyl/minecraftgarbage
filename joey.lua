local function audioLoop()
    if #speakers == 0 then while true do os.sleep(1) end end

    -- ── CONFIG ──────────────────────────────────────────────────────
    local SERVER  = "https://9ffff80e212eac.lhr.life"
    local VOLUME  = 3.0   -- Max radius, zero distortion.
    local CHUNK   = 16 * 1024

    -- ── HELPERS ─────────────────────────────────────────────────────
    local function checkServer()
        local ok, err = http.get(SERVER.."/tracks")
        if ok then ok.close(); return true end
        
        -- Temporarily un-redirect to the physical terminal
        local old_term = term.redirect(term.native())
        
        print(" ")
        print("!!! AUDIO CONNECTION FAILED !!!")
        print("ERROR: " .. tostring(err))
        print("URL: " .. SERVER .. "/tracks")
        print(" ")
        
        -- Put the redirect back to the monitor wall
        term.redirect(old_term)
        
        return false
    end

    local function getTracks()
        local r = http.get(SERVER .. "/tracks")
        if not r then return {} end
        local raw = r.readAll(); r.close()
        local t = {}
        for name in raw:gmatch('"([^"]+)"') do t[#t+1] = name end
        return t
    end

    -- Stream one track from the server.
    -- Uses cc.audio.dfpwm to decode chunks as they arrive and
    -- feeds them to speaker.playAudio(), waiting on the
    -- "speaker_audio_empty" event whenever the speaker buffer is full.
    local function streamTrack(filename)
        -- URL encode to handle the crazy file names
        local safe_filename = filename:gsub("([^%w _%%%-%.~])", function(c)
            return string.format("%%%02X", string.byte(c))
        end):gsub(" ", "%%20")

        local url = SERVER .. "/play/" .. safe_filename
        local res, err = http.get(url, nil, true)
        
        if not res then
            tprint("[music] fetch failed: " .. tostring(err))
            return
        end

        tprint("[music] Streaming: " .. filename)
        
        -- Hard-stop the speaker to wipe leftover garbage
        speakers[1].stop()

        while true do
            local chunk = res.read(16384)
            if not chunk or #chunk == 0 then break end

            local pcm = {}
            for i = 1, #chunk do
                local b = string.byte(chunk, i)
                -- Math for signed 8-bit
                if b > 127 then b = b - 256 end
                pcm[i] = b
            end

            -- Do NOT wait for the buffer to empty. 
            -- Just yield 2 ticks so it drains slightly, then top it back up.
            while not speakers[1].playAudio(pcm, VOLUME) do
                os.sleep(0.1) 
            end
        end

        res.close()
        speakers[1].stop()
    end
end
