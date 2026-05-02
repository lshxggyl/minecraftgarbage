-- ============================================
--   OPERATION STYLUS -- CC DISPLAY SCRIPT
--   Attach a monitor peripheral for best results
--   The bigger the monitor the better
--   Run: lua operation_stylus.lua
-- ============================================

local mon = peripheral.find("monitor")
local display = mon or term

-- grab ALL speakers not just one
local speakers = {peripheral.find("speaker")}

local function playNote(inst, vol, pitch)
    for _, s in ipairs(speakers) do
        s.playNote(inst, vol, pitch)
    end
end

-- startup check
term.clear()
term.setCursorPos(1,1)
if mon then
    print("Monitor found: OK")
else
    print("Monitor: NOT FOUND (using terminal)")
end
if #speakers > 0 then
    print("Speakers found: " .. #speakers)
    for _, s in ipairs(speakers) do
        s.playNote("bell", 1.0, 12)
    end
else
    print("Speakers: NOT FOUND - check they are attached!")
end
sleep(3)

if mon then
    mon.setTextScale(1.5)
end

local w, h = display.getSize()

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================

local function cls()
    display.setBackgroundColor(colors.black)
    display.setTextColor(colors.white)
    display.clear()
    display.setCursorPos(1, 1)
end

local function at(x, y)
    display.setCursorPos(x, y)
end

local function col(fg, bg)
    display.setTextColor(fg or colors.white)
    display.setBackgroundColor(bg or colors.black)
end

local function centerText(text, y, fg)
    local x = math.max(1, math.floor((w - #text) / 2) + 1)
    at(x, y)
    col(fg or colors.white)
    display.write(text:sub(1, w))
end

local function fillLine(y, char, fg)
    at(1, y)
    col(fg or colors.orange)
    display.write(string.rep(char or "-", w))
end

local function writeLine(text, y, fg, bg)
    at(1, y)
    col(fg or colors.white, bg or colors.black)
    display.write(string.rep(" ", w))
    at(1, y)
    display.write(text:sub(1, w))
end

-- ============================================
-- TYPEWRITER EFFECT
-- ============================================

local function typewrite(text, x, y, fg, delay)
    delay = delay or 0.03
    col(fg or colors.white)
    for i = 1, #text do
        at(x + i - 1, y)
        display.write(text:sub(i, i))
        sleep(delay)
    end
end

-- ============================================
-- SCROLL FEED -- prints lines one by one,
-- scrolling the display up when full
-- ============================================

local scrollY = 3  -- current line being written

local function resetScrollArea()
    scrollY = 3
    for i = 3, h do
        writeLine("", i, colors.black)
    end
end

local function scrollFeed(text, fg)
    if scrollY > h then
        display.scroll(1)
        scrollY = h
    end
    at(1, scrollY)
    col(fg or colors.white)
    display.write(string.rep(" ", w))
    at(1, scrollY)
    display.write(text:sub(1, w))
    scrollY = scrollY + 1
    sleep(1.0)
end

-- ============================================
-- STORY CONTENT
-- ============================================

local function headerBar(title, fg)
    cls()
    fillLine(1, "=", colors.orange)
    centerText(title, 1, fg or colors.orange)
    fillLine(2, "-", colors.gray)
    resetScrollArea()
    sleep(0.5)
end

local function scene_intro()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*!?<>[]{}^~"

    local function randChar()
        return chars:sub(math.random(1, #chars), math.random(1, #chars))
    end

    local function glitchText(text, x, y, fg, iterations)
        for i = 1, iterations do
            at(x, y)
            col(fg)
            local out = ""
            for j = 1, #text do
                if math.random() < (i / iterations) then
                    out = out .. text:sub(j, j)
                else
                    out = out .. randChar()
                end
            end
            display.write(out:sub(1, w - x + 1))
            sleep(0.07)
        end
        at(x, y)
        col(fg)
        display.write(text:sub(1, w - x + 1))
    end

    local function progressBar(y, pct, fg)
        local filled = math.floor((w - 10) * pct)
        local empty = (w - 10) - filled
        at(1, y)
        col(fg)
        display.write("[")
        col(colors.lime)
        display.write(string.rep("#", filled))
        col(colors.gray)
        display.write(string.rep(".", empty))
        col(fg)
        display.write("] " .. math.floor(pct * 100) .. "%  ")
    end

    -- phase 1: black screen with cursor blink
    cls()
    sleep(0.5)

    -- phase 2: matrix rain
    col(colors.green)
    for i = 1, 30 do
        local x = math.random(1, w)
        local y = math.random(1, h)
        at(x, y)
        display.write(randChar())
        sleep(0.03)
    end
    sleep(0.3)

    -- phase 3: connecting message
    cls()
    local connectMsg = "ESTABLISHING SECURE CONNECTION..."
    for i = 1, #connectMsg do
        at(math.floor((w - #connectMsg) / 2) + 1, math.floor(h/2))
        col(colors.green)
        display.write(connectMsg:sub(1, i))
        sleep(0.04)
    end
    sleep(0.8)

    -- phase 4: ACCESS DENIED flash
    cls()
    for i = 1, 4 do
        centerText(">>> ACCESS DENIED <<<", math.floor(h/2), colors.red)
        sleep(0.15)
        cls()
        sleep(0.1)
    end

    -- phase 5: override sequence
    cls()
    local midY = math.floor(h / 2) - 4
    sleep(0.2)

    centerText("OVERRIDE PROTOCOL INITIATED", midY, colors.yellow)
    sleep(0.3)
    centerText("BYPASSING SECURITY LAYER 1...", midY + 1, colors.gray)
    sleep(0.4)
    centerText("BYPASSING SECURITY LAYER 2...", midY + 2, colors.gray)
    sleep(0.4)
    centerText("BYPASSING SECURITY LAYER 3...", midY + 3, colors.gray)
    sleep(0.6)

    -- phase 6: progress bars
    cls()
    centerText("DECRYPTING CLASSIFIED DOCUMENT", 2, colors.yellow)
    sleep(0.3)

    local steps = {0.1, 0.2, 0.35, 0.5, 0.65, 0.75, 0.88, 0.95, 1.0}
    for _, pct in ipairs(steps) do
        progressBar(4, pct, colors.yellow)
        sleep(0.18)
    end

    sleep(0.3)
    centerText("DECRYPTION COMPLETE", 6, colors.lime)
    sleep(0.4)

    -- phase 7: file header glitch reveal
    cls()
    sleep(0.2)
    glitchText("CLASSIFICATION: TOP SECRET", 2, 2, colors.red, 18)
    sleep(0.2)
    glitchText("CASE FILE: 0458-244385-9062", 2, 3, colors.yellow, 18)
    sleep(0.2)
    glitchText("DATE: APRIL 30 2026", 2, 4, colors.gray, 14)
    sleep(0.2)
    glitchText("LOCATION: WATERTOWN, CONNECTICUT", 2, 5, colors.gray, 14)
    sleep(0.3)
    glitchText("SUBJECT: ONE (1) JARED", 2, 6, colors.white, 14)
    sleep(0.5)

    -- phase 8: ACCESS GRANTED
    for i = 1, 3 do
        centerText(">>> ACCESS GRANTED <<<", h - 2, colors.lime)
        sleep(0.2)
        at(1, h - 2)
        col(colors.black)
        display.write(string.rep(" ", w))
        sleep(0.15)
    end
    centerText(">>> ACCESS GRANTED <<<", h - 2, colors.lime)
    sleep(0.8)

    -- phase 9: big dramatic title glitch reveal
    cls()
    sleep(0.3)
    glitchText("  OPERATION", math.floor((w - 20) / 2), math.floor(h/2) - 1, colors.orange, 25)
    sleep(0.1)
    glitchText("    STYLUS", math.floor((w - 20) / 2), math.floor(h/2) + 1, colors.yellow, 25)
    sleep(2.5)
end

local function scene_title()
    cls()
    fillLine(1, "*", colors.red)
    centerText("* CLASSIFIED DOCUMENT *", 1, colors.red)
    fillLine(2, "*", colors.red)
    sleep(0.3)
    centerText("OPERATION STYLUS", 4, colors.orange)
    sleep(0.2)
    centerText("A SAGA OF CHAOS, COPE & CURSED POTIONS", 6, colors.yellow)
    sleep(0.2)
    centerText("APRIL 2026 // WATERTOWN, CONNECTICUT", 7, colors.gray)
    sleep(0.2)
    fillLine(9, "=", colors.orange)
    sleep(0.3)
    centerText("[ SCROLL DOWN TO DEBRIEF ]", 11, colors.gray)
    sleep(30)
end

local function scene_act1()
    headerBar("=[ ACT I: THE COCK-BLOCK OF THE CENTURY ]=", colors.orange)
    scrollFeed(" It started simply enough.", colors.white)
    scrollFeed("", colors.white)
    scrollFeed(" Jared, a paranoid cyber monk running", colors.white)
    scrollFeed(" NOBARA LINUX with PROTON VPN on every", colors.lime)
    scrollFeed(" single fucking device he owns, decided", colors.white)
    scrollFeed(" he wanted a phone. Specifically:", colors.white)
    scrollFeed("", colors.white)
    scrollFeed("   >> MOTO G STYLUS 2026  <<", colors.yellow)
    scrollFeed("   >> BOOST MOBILE ONLINE <<", colors.yellow)
    scrollFeed("   >> COST: $24.99         <<", colors.lime)
    scrollFeed("", colors.white)
    scrollFeed(" Reasonable. Simple. Achievable.", colors.white)
    scrollFeed(" What could possibly go wrong.", colors.white)
    scrollFeed("", colors.white)
    scrollFeed(" EVERYTHING.", colors.red)
    scrollFeed(" EVERY LAST FUCKING THING WENT WRONG.", colors.red)
    sleep(25)
end

local function scene_timeline()
    headerBar("=[ MISSION LOG: TIMELINE OF SUFFERING ]=", colors.orange)
    scrollFeed("", colors.white)
    scrollFeed(" [WED 2:00 AM] ORDER PLACED", colors.yellow)
    scrollFeed("   Card cleared. Confirmation in.", colors.white)
    scrollFeed("   Life is beautiful. Temporarily.", colors.lime)
    scrollFeed("", colors.white)
    scrollFeed(" [WED 4:17 PM] LABEL CREATED", colors.yellow)
    scrollFeed("   UPS hasn't touched shit yet.", colors.gray)
    scrollFeed("   False hope achieved.", colors.gray)
    scrollFeed("", colors.white)
    scrollFeed(" [WED 6:23 PM] !!! EVERYTHING IS FUCKED", colors.red)
    scrollFeed("   Fraud bot spots Proton VPN node:", colors.red)
    scrollFeed("   IP = NEW YORK. Address = CONNECTICUT.", colors.red)
    scrollFeed("   Bot LOSES ITS ENTIRE SHIT.", colors.red)
    scrollFeed("   Return to Sender. Order: NUKED.", colors.red)
    scrollFeed("   Package never moved. Was a lie.", colors.red)
    scrollFeed("", colors.white)
    scrollFeed(" [WED 9:00 PM] SUPPORT CALLED. USELESS.", colors.yellow)
    scrollFeed("   Rep says: 'idk lol bestie'", colors.gray)
    scrollFeed("   Ghost line haunts dashboard.", colors.gray)
    scrollFeed("", colors.white)
    scrollFeed(" [THU MIDNIGHT] CHAOS PROTOCOLS ACTIVE", colors.yellow)
    scrollFeed("   Card crisis. Cursed potion brewed.", colors.lime)
    scrollFeed("   Lua scripts written. Atrazine consumed.", colors.lime)
    scrollFeed("", colors.white)
    scrollFeed(" [THU 6:30 PM] !!! THE HAMMER DROPS !!!", colors.lime)
    scrollFeed("   VPN: DEAD. Browser: VIRGIN CHROMIUM.", colors.lime)
    scrollFeed("   Fresh card. Burner email. Raw ISP.", colors.lime)
    scrollFeed("   $2,075 DISCOUNT SECURED. $77.57 TOTAL.", colors.lime)
    scrollFeed("   FRAUD BOT: BAMBOOZLED. DESTROYED.", colors.lime)
    scrollFeed("", colors.white)
    scrollFeed(" [TUE ETA] WAR TROPHY ARRIVES", colors.yellow)
    scrollFeed("   Jared wins. Flawless fucking victory.", colors.lime)
    sleep(30)
end

local function scene_cardcrisis()
    headerBar("=[ ACT II: THE GREAT CARD CRISIS OF 2026 ]=", colors.orange)
    scrollFeed("", colors.white)
    scrollFeed(" Jared's complete financial arsenal:", colors.white)
    scrollFeed("", colors.white)
    scrollFeed("  [CASHAPP]   STATUS: FLAGGED BULLSHIT", colors.red)
    scrollFeed("  [VENMO]     STATUS: ALSO BULLSHIT", colors.red)
    scrollFeed("  [CHIME]     STATUS: BURNED. FUCKED.", colors.red)
    scrollFeed("", colors.white)
    scrollFeed(" Situation assessment: completely fucked.", colors.white)
    scrollFeed("", colors.white)
    scrollFeed(" ......", colors.gray)
    sleep(1)
    scrollFeed("", colors.white)
    scrollFeed(" WAIT.", colors.yellow)
    scrollFeed("", colors.white)
    scrollFeed(" CHIME HAS VIRTUAL CARD GENERATION.", colors.lime)
    scrollFeed(" A fresh 16-digit number.", colors.lime)
    scrollFeed(" A completely new fucking identity.", colors.lime)
    scrollFeed(" To a fraud bot: a different human.", colors.lime)
    scrollFeed("", colors.white)
    scrollFeed(" Jared committed friendly identity", colors.white)
    scrollFeed(" fraud against himself.", colors.white)
    scrollFeed(" To buy a $24.99 phone.", colors.yellow)
    scrollFeed("", colors.white)
    scrollFeed(" We are so incredibly back.", colors.lime)
    sleep(25)
end

local function scene_notebook()
    headerBar("=[ THE OPSEC INCIDENT (CLASSIFIED) ]=", colors.red)
    scrollFeed("", colors.white)
    scrollFeed(" Jared wrote his battle plan on paper:", colors.white)
    scrollFeed("", colors.white)
    scrollFeed("  +-----------------------------+", colors.gray)
    scrollFeed("  | CARD: XXXX XXXX XXXX XXXX   |", colors.yellow)
    scrollFeed("  | CVV:  XXX                   |", colors.yellow)
    scrollFeed("  | ADDR: [REDACTED], CT         |", colors.yellow)
    scrollFeed("  | EMAIL: mk4modz@gmail.com    |", colors.yellow)
    scrollFeed("  +-----------------------------+", colors.gray)
    scrollFeed("", colors.white)
    scrollFeed(" On paper. Like it was 1987.", colors.white)
    scrollFeed("", colors.white)
    scrollFeed(" Then he took a PHOTO of it.", colors.red)
    scrollFeed(" With his PHONE.", colors.red)
    scrollFeed(" Sitting in his CAMERA ROLL.", colors.red)
    scrollFeed(" Unencrypted. Accessible. Forever.", colors.red)
    scrollFeed("", colors.white)
    scrollFeed(" We don't discuss this.", colors.gray)
    scrollFeed(" We move on. We heal.", colors.gray)
    sleep(25)
end

local function scene_potion()
    headerBar("=[ THE CURSED MIDNIGHT POTION ]=", colors.lime)
    at(1, 1)
    fillLine(1, "~", colors.lime)
    centerText("=[ THE CURSED MIDNIGHT POTION ]=", 1, colors.lime)
    scrollFeed("", colors.white)
    scrollFeed(" Brewed in Connecticut tap water at", colors.white)
    scrollFeed(" midnight (probably has atrazine):", colors.gray)
    scrollFeed("", colors.white)
    scrollFeed("  [x] Himalayan Salt", colors.lime)
    scrollFeed("  [x] Turmeric", colors.lime)
    scrollFeed("  [x] EXPIRED Lemon Juice", colors.yellow)
    scrollFeed("  [x] Apple Cider Vinegar", colors.lime)
    scrollFeed("  [x] Ginger Powder", colors.lime)
    scrollFeed("  [x] Black Pepper (activates turmeric)", colors.lime)
    scrollFeed("  [x] Raw Honey", colors.lime)
    scrollFeed("", colors.white)
    scrollFeed(" Consumed simultaneously while:", colors.white)
    scrollFeed("  - Running a covert anti-fraud op", colors.yellow)
    scrollFeed("  - Writing Lua scripts in ComputerCraft", colors.yellow)
    scrollFeed("  - Questioning every life choice", colors.yellow)
    scrollFeed("", colors.white)
    scrollFeed(" The potion chose him.", colors.lime)
    scrollFeed(" The potion ALWAYS chooses him.", colors.lime)
    sleep(25)
end

local function scene_victory()
    cls()
    fillLine(1, "*", colors.yellow)
    centerText("**** FLAWLESS FUCKING VICTORY ****", 1, colors.yellow)
    fillLine(2, "*", colors.yellow)
    sleep(0.5)
    resetScrollArea()

    scrollFeed("", colors.white)
    scrollFeed("  DISCOUNT SECURED  : $2,075.00", colors.lime)
    scrollFeed("  PHONE COST        : $24.99", colors.lime)
    scrollFeed("  TOTAL PAID        : $77.57", colors.lime)
    scrollFeed("  VPN STATUS        : DEAD (as required)", colors.lime)
    scrollFeed("  FRAUD FLAGS       : 0", colors.lime)
    scrollFeed("  INTERCEPTS        : 0", colors.lime)
    scrollFeed("  CURSED POTIONS    : 1", colors.lime)
    scrollFeed("  LUA SCRIPTS       : WRITTEN", colors.lime)
    scrollFeed("  FRAUD BOT STATUS  : BAMBOOZLED", colors.lime)
    scrollFeed("  ATRAZINE CONSUMED : PROBABLY", colors.yellow)
    scrollFeed("", colors.white)
    scrollFeed(" The fraud bot never knew what the", colors.white)
    scrollFeed(" absolute fuck hit it.", colors.white)
    scrollFeed("", colors.white)
    scrollFeed(" Jared wins.", colors.yellow)
    scrollFeed(" The Linux gods are pleased.", colors.yellow)
    scrollFeed(" The potion did its fucking job.", colors.lime)
    scrollFeed("", colors.white)
    scrollFeed("  // END OF OPERATION STYLUS //", colors.orange)
    scrollFeed("  // APRIL 30, 2026           //", colors.orange)
    scrollFeed("  // CLASSIFIED AS HELL       //", colors.red)
    sleep(35)
end

local function scene_restart()
    cls()
    centerText("[ RESTARTING OPERATION STYLUS ]", math.floor(h / 2), colors.gray)
    centerText("[ press any key to skip a scene ]", math.floor(h / 2) + 2, colors.gray)
    sleep(15)
end

-- ============================================
-- SAD MUSIC
-- Extremely slow mournful bell melody in A minor
-- Pitches: semitones above F#3 (0=rest, 1=G3, 3=A3 etc)
-- ============================================

local function playMusic()
    if #speakers == 0 then return end

    local melody = {
        {15, 1.4},  -- A4
        {13, 1.4},  -- G4
        {11, 1.6},  -- F4
        {10, 2.2},  -- E4
        {0,  0.8},
        {8,  1.4},  -- D4
        {6,  1.4},  -- C4
        {5,  1.6},  -- B3
        {3,  3.0},  -- A3
        {0,  1.2},
        {3,  1.2},  -- A3
        {6,  1.2},  -- C4
        {8,  1.2},  -- D4
        {10, 1.8},  -- E4
        {0,  0.6},
        {11, 1.2},  -- F4
        {10, 1.2},  -- E4
        {8,  1.2},  -- D4
        {6,  1.6},  -- C4
        {3,  3.5},  -- A3
        {0,  1.5},
        {10, 1.2},  -- E4
        {8,  1.2},  -- D4
        {6,  1.2},  -- C4
        {3,  1.4},  -- A3
        {1,  4.0},  -- G3
        {0,  2.5},
    }

    -- steady bass pattern that loops independently
    -- A minor bass: A, E, A, C, A, E, G, E
    local bassline = {3, 10, 3, 6, 3, 10, 1, 10}

    local function bellMelody()
        while true do
            for _, note in ipairs(melody) do
                local pitch, dur = note[1], note[2]
                if pitch > 0 then
                    playNote("bell", 0.9, pitch)
                    sleep(0.08)
                    playNote("guitar", 0.3, math.max(0, pitch - 3))
                end
                sleep(dur)
            end
            sleep(3.0)
        end
    end

    local function runBass()
        local i = 1
        while true do
            local pitch = bassline[i]
            -- deep bass hit
            playNote("bass", 0.85, math.max(0, pitch - 12))
            sleep(0.05)
            -- mid bass for body
            playNote("bass", 0.4, math.max(0, pitch - 6))
            sleep(0.55)
            -- subtle off-beat ghost note
            playNote("bass", 0.3, math.max(0, pitch - 12))
            sleep(0.45)
            i = (i % #bassline) + 1
        end
    end

    parallel.waitForAny(bellMelody, runBass)
end

-- ============================================
-- MAIN LOOP
-- ============================================

local function runDisplay()
    while true do
        scene_intro()
        scene_title()
        scene_act1()
        scene_timeline()
        scene_cardcrisis()
        scene_notebook()
        scene_potion()
        scene_victory()
        scene_restart()
    end
end

parallel.waitForAny(runDisplay, playMusic)
