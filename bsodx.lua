-- ==========================================
-- XYNIA'S WEAPONIZED BRAINROT ENGINE
-- THE "DOMESTIC TERRORISM" CUT
-- ==========================================

local m = peripheral.find("monitor")
if not m then print("Plug the monitor in, dumbass.") return end

local speakers = {peripheral.find("speaker")}
if #speakers == 0 then print("Plug in the speakers, coward.") end

m.setTextScale(1)
term.redirect(m)
local w, h = m.getSize()

-- ==========================================
-- MASSIVE DICTIONARIES OF DISRESPECT
-- ==========================================
local adj = {
    "DOGSHIT", "BRAINDEAD", "SMOOTH-BRAINED", "PATHETIC", "USELESS",
    "GARBAGE", "TRASH", "F-TIER", "ATROCIOUS", "REPULSIVE", "CLOWN-SHOES",
    "NEGATIVE-IQ", "COPE-ADDICTED", "MALDING", "CRINGE", "ABYSMAL",
    "RADIOCATIVE", "UNWASHED", "FERAL", "TERMINALLY-ONLINE", "FATHERLESS",
    "SKILL-DEFICIENT", "CANCEROUS", "PUDDLE-DEEP", "LITERAL", "ABSOLUTE"
}

local noun = {
    "GAMER", "LAVA DIVER", "CREEPER SNACK", "DIRT HUT ARCHITECT",
    "GRAVEL EATER", "NPC", "BOT", "VILLAGE IDIOT", "SILVERFISH VICTIM",
    "VOID HOPPER", "WARDEN FODDER", "GHAST TARGET", "WALKING CHEST",
    "MOB SPAWNER", "DISAPPOINTMENT", "ERROR 404", "BASEMENT DWELLER",
    "KEYBOARD TURNER", "LOOT PINATA", "DONKEY", "CLOWN", "DEGENERATE"
}

local fake_history = {
    "how to un-tame a wolf",
    "why are villagers running away from me",
    "how to get sharpnes 5 on dirt",
    "minecraft unban appeal template",
    "how to convince admins i wasnt xraying",
    "free minecoins generator 2026 working no virus",
    "why did my iron golem kill me",
    "how to build roof in minecraft",
    "is it safe to drink poison in minecraft",
    "how to undo creeper explosion",
    "where did my diamonds go",
    "how to make friends in smp"
}

local fake_dms = {
    "Bro plz give my stuff back",
    "I swear it was lag",
    "Can u come light up my cave I'm scared",
    "How do you craft a chest again?",
    "Admin teleport me I'm stuck in a hole",
    "Please bro I lost my iron pick",
    "Stop killing me I have nothing",
    "Who took my 14 dirt blocks"
}

local colors_list = {colors.red, colors.orange, colors.yellow, colors.lime, colors.lightBlue, colors.cyan, colors.purple, colors.magenta, colors.pink, colors.white}

-- ==========================================
-- HELPER FUNCTIONS
-- ==========================================
local function center(y, text)
    local x = math.floor((w - string.len(text)) / 2) + 1
    m.setCursorPos(x, y)
    m.write(text)
end

local function blast(bg, fg)
    m.setBackgroundColor(bg)
    m.setTextColor(fg)
    m.clear()
end

local function genInsult()
    return adj[math.random(1, #adj)] .. " " .. noun[math.random(1, #noun)]
end

local function typeWriter(x, y, text, speed)
    m.setCursorPos(x, y)
    for i = 1, string.len(text) do
        m.write(string.sub(text, i, i))
        os.sleep(speed or 0.02)
    end
end

-- ==========================================
-- ENGINE 1: AUDIO TORTURE (MODEM CRASH)
-- ==========================================
local function audioLoop()
    if #speakers == 0 then while true do os.sleep(1) end end
    local inst = {"cow_bell", "bit", "banjo", "didgeridoo", "pling", "flute", "bell"}
    
    while true do
        for _, s in pairs(speakers) do
            local pitch = math.random(0, 24)
            -- Stutter effect
            for i=1, math.random(1, 4) do
                s.playNote(inst[math.random(1, #inst)], 1.5, pitch)
                os.sleep(0.05)
            end
        end
        os.sleep(math.random(1, 8) / 100) 
    end
end

-- ==========================================
-- ENGINE 2: THE APOCALYPSE
-- ==========================================
local function visualLoop()
    while true do
        -- 1. FAKE IP LEAK & DOX
        blast(colors.black, colors.green)
        typeWriter(2, 2, "FETCHING NETWORK DATA...", 0.01)
        os.sleep(0.5)
        typeWriter(2, 4, "IPv4: 192.168.1." .. math.random(2, 254), 0.01)
        typeWriter(2, 5, "MAC: 00:1A:2B:3C:4D:" .. math.random(10, 99), 0.01)
        typeWriter(2, 6, "BASE COORDS: X:" .. math.random(-5000, 5000) .. " Y:12 Z:" .. math.random(-5000, 5000), 0.01)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 8, "UPLOADING TO PUBLIC CHAT...", 0.02)
        os.sleep(1.5)

        -- 2. BROWSER HISTORY LEAK
        blast(colors.blue, colors.white)
        center(2, "--- EXPOSING SEARCH HISTORY ---")
        for i = 4, h-2, 2 do
            m.setTextColor(colors.yellow)
            typeWriter(2, i, "> " .. fake_history[math.random(1, #fake_history)], 0.01)
            os.sleep(0.3)
        end
        os.sleep(2)

        -- 3. DISCORD DM LEAK
        blast(colors.black, colors.magenta)
        center(2, "--- LEAKED DISCORD DMS ---")
        for i = 4, h-2, 2 do
            m.setTextColor(colors.white)
            typeWriter(2, i, "You: " .. fake_dms[math.random(1, #fake_dms)], 0.01)
            m.setTextColor(colors.lightGray)
            typeWriter(2, i+1, "Read 9:42 PM - Ignored", 0.005)
            os.sleep(0.4)
        end
        os.sleep(2)

        -- 4. PROCEDURAL ROAST GENERATOR
        blast(colors.black, colors.white)
        for i = 1, 15 do
            m.clear()
            m.setTextColor(colors_list[math.random(1, #colors_list)])
            center(math.floor(h/2) - 2, "YOUR OFFICIAL TITLE:")
            m.setTextColor(colors.white)
            center(math.floor(h/2), "THE")
            m.setTextColor(colors.red)
            center(math.floor(h/2) + 2, genInsult())
            os.sleep(0.2)
        end
        os.sleep(1)

        -- 5. MATRIX RAIN OF SHIT
        blast(colors.black, colors.lime)
        for i = 1, 500 do
            local rx = math.random(1, w)
            local ry = math.random(1, h)
            m.setCursorPos(rx, ry)
            m.setTextColor(colors_list[math.random(1, #colors_list)])
            
            if math.random(1, 10) > 8 then
                m.write(genInsult())
            else
                local chars = {"L", "F", "0", "1", "NOOB", "RIP", "TRASH"}
                m.write(chars[math.random(1, #chars)])
            end
            os.sleep(0.002)
        end

        -- 6. BOUNCING DVD LOGO OF DISRESPECT
        blast(colors.black, colors.white)
        local bx, by = math.random(1, w-10), math.random(1, h-2)
        local dx, dy = 1, 1
        for i = 1, 300 do
            m.setBackgroundColor(colors.black)
            m.clear()
            
            bx = bx + dx
            by = by + dy
            
            local bounceText = "UR " .. genInsult()
            
            if bx <= 1 or bx + string.len(bounceText) - 1 >= w then dx = -dx end
            if by <= 1 or by >= h then dy = -dy end
            
            m.setTextColor(colors_list[math.random(1, #colors_list)])
            m.setCursorPos(bx, by)
            m.write(bounceText)
            os.sleep(0.02)
        end

        -- 7. THE SEIZURE PROTOCOL
        for i = 1, 80 do
            blast(colors_list[math.random(1, #colors_list)], colors.black)
            center(math.floor(h/2) - 1, "ABSOLUTE")
            center(math.floor(h/2) + 1, genInsult())
            os.sleep(0.01)
            
            blast(colors.black, colors_list[math.random(1, #colors_list)])
            center(math.floor(h/2) - 1, "ABSOLUTE")
            center(math.floor(h/2) + 1, genInsult())
            os.sleep(0.01)
        end
        
        -- End of cycle reboot
        blast(colors.black, colors.red)
        center(math.floor(h/2), "MEMORY LEAK DETECTED. REBOOTING...")
        os.sleep(3)
    end
end

-- ==========================================
-- RUN BOTH LOOPS AT THE SAME FUCKING TIME
-- ==========================================
parallel.waitForAny(visualLoop, audioLoop)
