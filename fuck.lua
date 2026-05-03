-- ==========================================
-- XYNIA'S WEAPONIZED BRAINROT ENGINE
-- "CRIMES AGAINST MONITORS" EDITION
-- NOW WITH 900% MORE PSYCHOLOGICAL DAMAGE
-- ==========================================

local m = peripheral.find("monitor")
if not m then
    print("MONITOR NOT FOUND. CANNOT COMMIT ATROCITIES.")
    print("Plug the monitor in, you absolute creature.")
    return
end

local speakers = {peripheral.find("speaker")}
if #speakers == 0 then
    print("No speakers found. Visual torture only. Coward setup.")
end

m.setTextScale(0.5)
term.redirect(m)
local w, h = m.getSize()

-- ==========================================
-- EVEN BIGGER DICTIONARIES OF DISRESPECT
-- ==========================================
local adj = {
    "DOGSHIT", "BRAINDEAD", "SMOOTH-BRAINED", "PATHETIC", "USELESS",
    "GARBAGE", "TRASH", "F-TIER", "ATROCIOUS", "REPULSIVE", "CLOWN-SHOES",
    "NEGATIVE-IQ", "COPE-ADDICTED", "MALDING", "CRINGE", "ABYSMAL",
    "RADIOACTIVE", "UNWASHED", "FERAL", "TERMINALLY-ONLINE", "FATHERLESS",
    "SKILL-DEFICIENT", "CANCEROUS", "PUDDLE-DEEP", "LITERAL", "ABSOLUTE",
    "GALAXY-BRAINED", "CHRONICALLY-OFFLINE", "PRE-NEOLITHIC", "NEURONLESS",
    "WIFI-PASSWORD-SHARING", "DIRT-TIER", "WOODEN-SWORD-HAVING", "BEDROCK-BRAINED",
    "TUTORIAL-FAILING", "ENDER-PEARL-WASTING", "COMPASS-CONFUSED",
    "ZERO-KILL", "SPAWN-TRAPPED", "THIRD-PARTY-DOWNLOADING", "KEYBIND-FORGETTING",
    "LORE-ILLITERATE", "COMPASS-USING", "SPRINT-TOGGLING", "CHEST-PUNCHING",
    "CORPSE-LOSING", "RESPAWN-FORGETTING", "CHUNK-FORGETTING",
    "GRAVEL-TRUSTING", "LAVA-ADJACENT", "FUNDAMENTALLY-COOKED",
    "COSMICALLY-OFFLINE", "STRUCTURALLY-WRONG", "ANATOMICALLY-CLOWNED",
    "IRREVERSIBLY-NPC", "EMPIRICALLY-BAD"
}

local noun = {
    "GAMER", "LAVA DIVER", "CREEPER SNACK", "DIRT HUT ARCHITECT",
    "GRAVEL EATER", "NPC", "BOT", "VILLAGE IDIOT", "SILVERFISH VICTIM",
    "VOID HOPPER", "WARDEN FODDER", "GHAST TARGET", "WALKING CHEST",
    "MOB SPAWNER", "DISAPPOINTMENT", "ERROR 404", "BASEMENT DWELLER",
    "KEYBOARD TURNER", "LOOT PINATA", "DONKEY", "CLOWN", "DEGENERATE",
    "CREEPER MAGNET", "GRAVEL CONNOISSEUR", "SKELETON ARROW COLLECTOR",
    "TNT ACCIDENT SURVIVOR", "DROWNED APPRENTICE", "ZOMBIE FOOD",
    "ENCHANTING TABLE DECORATION", "SAND PHILOSOPHER", "SUGAR CANE FARMER",
    "NETHERITE DREAMER", "WOODCUTTER", "DOOR FORGETTER", "TORCH SKIPPER",
    "BED IGNORER", "COMPASS HAVER", "MAP ILLITERATE", "BOAT DIPPER",
    "FALL DAMAGE RESEARCHER", "LAVA BUCKET REGRET", "PORTAL TOURIST",
    "STRONGHOLD TOURIST", "PHANTOM TARGET", "BAT SYMPATHIZER",
    "SPIDER JOCKEY VICTIM", "WITCH EXPERIMENT", "PILLAGER PINATA",
    "ELDER GUARDIAN HALLUCINATION", "DEEP DARK TOURIST", "SCULK SENSOR ACTIVATOR"
}

local fake_history = {
    "how to un-tame a wolf",
    "why are villagers running away from me",
    "how to get sharpness 5 on dirt",
    "minecraft unban appeal template",
    "how to convince admins i wasnt xraying",
    "free minecoins generator 2026 working no virus",
    "why did my iron golem kill me",
    "how to build roof in minecraft",
    "is it safe to drink poison in minecraft",
    "how to undo creeper explosion",
    "where did my diamonds go",
    "how to make friends in smp",
    "what does the crafting table do",
    "how do i place blocks",
    "is herobrine real 2026",
    "how to breathe underwater without helmet",
    "why does lava hurt",
    "how to win minecraft",
    "minecraft final boss",
    "how to get good at minecraft fast free",
    "does dirt grow diamonds if you water it",
    "how to delete the void",
    "what happens if creeper catches me",
    "how to befriend warden",
    "how to undo dying in minecraft",
    "is iron better than wood yes or no",
    "can I eat raw chicken minecraft I'm hungry",
    "what is a nether",
    "how to skip nighttime without sleeping",
    "why is skeleton racist to me specifically",
    "how to report a creeper to server admin",
    "refund policy minecraft death"
}

local fake_dms = {
    "Bro plz give my stuff back",
    "I swear it was lag",
    "Can u come light up my cave I'm scared",
    "How do you craft a chest again?",
    "Admin teleport me I'm stuck in a hole",
    "Please bro I lost my iron pick",
    "Stop killing me I have nothing",
    "Who took my 14 dirt blocks",
    "Can you explain how hunger works",
    "Why did you put lava in my house",
    "I only had 3 hp left that's not fair",
    "Can you spare some wood? I have none",
    "I've been in this cave for 40 minutes",
    "The zombies keep finding me somehow",
    "I think someone is following me in single player",
    "How do I turn off the game",
    "My dog died please come to the funeral",
    "I named my pig Gerald and now I can't eat pork",
    "The creeper was provoked you have to believe me",
    "I need 4 iron can we trade I have 62 dirt",
    "Is it bad that I dug straight down",
    "I fell in lava with my full netherite please help",
    "Ban the skeleton I have proof",
    "How many planks does it take to make a house"
}

local fake_processes = {
    "minecraft.exe", "hopium_pump.dll", "skill_issue_handler.sys",
    "cope.bat", "delete_skills.exe", "refund_request.exe",
    "dirt_palace_renderer.dll", "keyboard_gamer.exe", "lava_walk.bat",
    "void_tourism.sys", "XRay_totally_not.dll", "admin_please.exe",
    "my_items_gone.sys", "noob_protection_DISABLED.exe"
}

local fake_errors = {
    "KERNEL_SKILL_ISSUE",
    "BRAINCELL_PAGE_FAULT",
    "IRQL_NOT_LESS_OR_EQUAL_TO_SKILL",
    "CRITICAL_COPE_FAILURE",
    "DRIVER_OVERRAN_STACK_OVERFLOW_OF_BAD_PLAYS",
    "SYSTEM_THREAD_EXCEPTION_NOT_HANDLED_LIKE_A_NOOB",
    "MEMORY_CORRUPTION_BY_STUPIDITY",
    "BAD_POOL_CALLER_BAD_AT_GAME",
    "UNEXPECTED_KERNEL_MODE_TRAP_FAILURE",
    "INACCESSIBLE_BOOT_DEVICE_INACCESSIBLE_SKILL",
    "DPC_WATCHDOG_VIOLATION_OF_DECENCY",
    "PAGE_FAULT_IN_NONPAGED_SKILL_AREA",
    "CLOCK_WATCHDOG_TIMEOUT_OF_PATIENCE"
}

local conspiracy_theories = {
    "Your base coords have been sold to 3 different factions",
    "The warden is not hostile. It specifically hates YOU.",
    "Your ping is high because you're bad, not the server",
    "Herobrine is real and he's embarrassed for you",
    "The pillagers have your home address (in-game)",
    "Your iron golem filed a restraining order",
    "The villagers are gossiping about you right now",
    "The ender dragon could have been stopped. You chose not to.",
    "Your wolf died on purpose to get away from you",
    "The skeleton was aiming for someone else but reconsidered",
    "Your farm is sentient and it's staging a revolt",
    "The nether portal has been rerouted to spite you",
    "PhoenixSC made a video about you. It's not flattering.",
    "Dream saw your speedrun time and cried"
}

local fake_achievements = {
    {name="How Did We Get Here?", desc="Get every status effect. At once. In the void."},
    {name="Taking Inventory", desc="Open your inventory. That's it. That's the bar you cleared."},
    {name="Who Is Cutting Onions?", desc="Lose your house to a creeper for the 8th time."},
    {name="Cover Me in Debris", desc="Lose full netherite in lava. In the overworld somehow."},
    {name="Adventure Time", desc="Touch grass. Warning: may cause disorientation."},
    {name="Serious Dedication", desc="Craft a hoe. Your magnum opus. Your legacy."},
    {name="Is It a Bird?", desc="Die to a phantom you definitely saw coming."},
    {name="Where Have You Been?", desc="Discover a village. Name yourself an honorary villager. Get rejected."},
    {name="The End?", desc="Fall in the void trying to reach the end portal."},
    {name="Free the End", desc="Die to the ender dragon on the first hit."},
    {name="Arbalistic", desc="Miss every skeleton arrow. Somehow."},
    {name="With Our Powers Combined!", desc="Log in during a raid you definitely caused."}
}

local colors_list = {
    colors.red, colors.orange, colors.yellow, colors.lime,
    colors.lightBlue, colors.cyan, colors.purple, colors.magenta,
    colors.pink, colors.white
}

local ascii_skull = {
    "  ___  ",
    " /   \\ ",
    "| o o |",
    "|  ^  |",
    "| --- |",
    " \\___/ "
}

local ascii_rip = {
    "+==========+",
    "|          |",
    "|   R.I.P  |",
    "|          |",
    "|  ur kit  |",
    "|          |",
    "+==========+"
}

local ascii_bsod = {
    ":(",
    "",
    "Your PC (skill issue) ran into a problem",
    "and needs to restart.",
    "",
    "Stop code: BRAINCELL_NOT_FOUND",
}

-- ==========================================
-- HELPER FUNCTIONS
-- ==========================================
local function center(y, text)
    local x = math.max(1, math.floor((w - #text) / 2) + 1)
    m.setCursorPos(x, y)
    m.write(text:sub(1, w))
end

local function blast(bg, fg)
    m.setBackgroundColor(bg or colors.black)
    m.setTextColor(fg or colors.white)
    m.clear()
end

local function genInsult()
    return adj[math.random(1, #adj)] .. " " .. noun[math.random(1, #noun)]
end

local function genDoubleInsult()
    return adj[math.random(1, #adj)] .. ", " .. adj[math.random(1, #adj)] .. " " .. noun[math.random(1, #noun)]
end

local function typeWriter(x, y, text, speed)
    m.setCursorPos(math.max(1,x), math.max(1,y))
    for i = 1, #text do
        if m.getCursorPos() then
            m.write(text:sub(i, i))
        end
        os.sleep(speed or 0.02)
    end
end

local function slowTypeCenter(y, text, speed)
    local x = math.max(1, math.floor((w - #text) / 2) + 1)
    typeWriter(x, y, text, speed)
end

local function fillRow(y, char, fg, bg)
    m.setBackgroundColor(bg or colors.black)
    m.setTextColor(fg or colors.white)
    m.setCursorPos(1, y)
    m.write(string.rep(char or " ", w))
end

local function drawBox(x1, y1, x2, y2, fg, bg)
    m.setBackgroundColor(bg or colors.black)
    m.setTextColor(fg or colors.white)
    for row = y1, y2 do
        for col = x1, x2 do
            m.setCursorPos(col, row)
            if row == y1 or row == y2 then
                m.write("-")
            elseif col == x1 or col == x2 then
                m.write("|")
            else
                m.write(" ")
            end
        end
    end
end

local function progressBar(y, label, speed)
    m.setTextColor(colors.white)
    typeWriter(2, y, label .. " [", speed)
    local barStart = 2 + #label + 2
    m.setTextColor(colors.lime)
    for i = 1, math.min(30, w - barStart - 2) do
        m.setCursorPos(barStart + i - 1, y)
        m.write("=")
        os.sleep(speed or 0.03)
    end
    m.setTextColor(colors.white)
    m.write("]")
    m.setTextColor(colors.red)
    m.write(" FAILED")
end

-- ==========================================
-- ENGINE: AUDIO TORTURE (EVEN MORE CHAOTIC)
-- ==========================================
local function audioLoop()
    if #speakers == 0 then while true do os.sleep(1) end end
    local inst = {"cow_bell", "bit", "banjo", "didgeridoo", "pling", "flute", "bell", "bass", "guitar", "harp", "iron_xylophone", "xylophone"}

    while true do
        for _, s in pairs(speakers) do
            local pitch = math.random(0, 24)
            local vol = math.random(5, 15) / 10
            local repeats = math.random(1, 6)
            for i = 1, repeats do
                s.playNote(inst[math.random(1, #inst)], vol, pitch + math.random(-2, 2))
                os.sleep(math.random(2, 8) / 100)
            end
        end
        os.sleep(math.random(1, 6) / 100)
    end
end

-- ==========================================
-- ENGINE: FAKE BSOD (WINDOWS TRAUMA)
-- ==========================================
local function phase_bsod()
    blast(colors.blue, colors.white)
    local midH = math.floor(h / 2)
    center(midH - 4, ":( ")
    os.sleep(0.3)
    center(midH - 2, "Your PC ran into a problem because you're bad at this.")
    center(midH - 1, "We're collecting some error info (it's all about you).")
    os.sleep(0.5)

    local pct = 0
    while pct < 100 do
        pct = math.min(100, pct + math.random(1, 7))
        center(midH + 1, pct .. "% complete (your mistakes have been catalogued)")
        os.sleep(0.04)
    end

    os.sleep(0.5)
    m.setTextColor(colors.lightGray)
    center(midH + 3, "Stop code: " .. fake_errors[math.random(1, #fake_errors)])
    center(midH + 4, "Failed process: " .. fake_processes[math.random(1, #fake_processes)])
    os.sleep(3)
end

-- ==========================================
-- ENGINE: FAKE IP & DOX (ALL FAKE, RELAX)
-- ==========================================
local function phase_dox()
    blast(colors.black, colors.green)
    typeWriter(2, 2, "[SYSTEM INTRUSION DETECTED]", 0.01)
    os.sleep(0.3)
    typeWriter(2, 4, "FETCHING NETWORK DATA...", 0.01)
    os.sleep(0.4)
    typeWriter(2, 5, "IPv4......: 192.168." .. math.random(0,5) .. "." .. math.random(2, 254), 0.01)
    typeWriter(2, 6, "IPv6......: fe80::dead:beef:" .. math.random(1000,9999) .. ":cafe", 0.01)
    typeWriter(2, 7, "MAC.......: 00:1A:2B:3C:4D:" .. math.random(10, 99), 0.01)
    typeWriter(2, 8, "HOSTNAME..: SKILL-ISSUE-PC-" .. math.random(1000, 9999), 0.01)
    typeWriter(2, 9, "BASE COORDS: X:" .. math.random(-9999, 9999) .. " Y:11 Z:" .. math.random(-9999, 9999), 0.01)
    typeWriter(2, 10, "STASH COORDS: X:" .. math.random(-9999, 9999) .. " Y:7 Z:" .. math.random(-9999, 9999), 0.01)
    os.sleep(0.5)
    m.setTextColor(colors.red)
    typeWriter(2, 12, ">> UPLOADING TO #public-chat...", 0.02)
    os.sleep(0.5)
    typeWriter(2, 13, ">> POSTING TO REDDIT r/minecraftfails...", 0.02)
    os.sleep(0.5)
    typeWriter(2, 14, ">> NOTIFYING 3 RIVAL FACTIONS...", 0.02)
    os.sleep(0.5)
    typeWriter(2, 15, ">> DONE. COPE.", 0.03)
    os.sleep(2)
end

-- ==========================================
-- ENGINE: BROWSER HISTORY LEAK
-- ==========================================
local function phase_history()
    blast(colors.blue, colors.white)
    center(2, "--- EXPOSING FULL BROWSER HISTORY ---")
    local row = 4
    for i = 1, math.min(#fake_history, math.floor((h - 4) / 1)) do
        m.setTextColor(colors.yellow)
        typeWriter(2, row, "> " .. fake_history[math.random(1, #fake_history)], 0.008)
        row = row + 1
        if row >= h then break end
        os.sleep(0.15)
    end
    os.sleep(2)
end

-- ==========================================
-- ENGINE: DISCORD DM LEAK
-- ==========================================
local function phase_discord()
    blast(colors.black, colors.magenta)
    center(2, "--- LEAKED DISCORD DMS (UNREAD: 0) ---")
    local row = 4
    while row < h - 1 do
        m.setTextColor(colors.white)
        local dm = fake_dms[math.random(1, #fake_dms)]
        typeWriter(2, row, "You: " .. dm, 0.008)
        row = row + 1
        if row >= h then break end
        m.setTextColor(colors.lightGray)
        local readTime = math.random(1, 12) .. ":" .. string.format("%02d", math.random(0, 59)) .. " " .. (math.random(0,1) == 0 and "AM" or "PM")
        typeWriter(2, row, "  Seen " .. readTime .. " - No reply", 0.005)
        row = row + 1
        if row >= h then break end
        os.sleep(0.3)
    end
    os.sleep(2)
end

-- ==========================================
-- ENGINE: FAKE ACHIEVEMENT UNLOCKED SPAM
-- ==========================================
local function phase_achievements()
    blast(colors.black, colors.white)
    center(2, "ACHIEVEMENT GET! (somehow)")
    os.sleep(0.5)
    for i = 1, 8 do
        local ach = fake_achievements[math.random(1, #fake_achievements)]
        local startY = math.random(2, h - 3)
        drawBox(2, startY, w - 1, startY + 2, colors.yellow, colors.black)
        m.setTextColor(colors.yellow)
        center(startY, "ACHIEVEMENT GET: " .. ach.name)
        m.setTextColor(colors.lightGray)
        center(startY + 1, ach.desc:sub(1, w - 4))
        os.sleep(1)
        blast(colors.black, colors.white)
        os.sleep(0.1)
    end
end

-- ==========================================
-- ENGINE: PROCEDURAL ROAST GENERATOR
-- ==========================================
local function phase_roast()
    blast(colors.black, colors.white)
    for i = 1, 20 do
        m.clear()
        m.setTextColor(colors_list[math.random(1, #colors_list)])
        center(math.floor(h/2) - 3, "OFFICIAL CLASSIFICATION:")
        m.setTextColor(colors.white)
        center(math.floor(h/2) - 1, "YOU ARE HEREBY DECLARED A")
        m.setTextColor(colors.red)
        center(math.floor(h/2) + 1, genDoubleInsult())
        m.setTextColor(colors.lightGray)
        center(math.floor(h/2) + 3, "by the International Minecraft Courts")
        os.sleep(0.15)
    end
    os.sleep(1)
end

-- ==========================================
-- ENGINE: MATRIX RAIN OF SHAME
-- ==========================================
local function phase_matrix()
    blast(colors.black, colors.lime)
    for i = 1, 800 do
        local rx = math.random(1, w)
        local ry = math.random(1, h)
        m.setCursorPos(rx, ry)
        m.setTextColor(colors_list[math.random(1, #colors_list)])
        local r = math.random(1, 15)
        if r > 12 then
            m.write((genInsult():sub(1, w - rx + 1)))
        elseif r > 9 then
            local words = {"L", "F", "NOOB", "RIP", "GG", "COPIUM", "RATIO", "MALDING", "CLIPPED", "VOIDED"}
            m.write(words[math.random(1, #words)])
        else
            m.write(tostring(math.random(0, 1)))
        end
        os.sleep(0.001)
    end
    os.sleep(0.5)
end

-- ==========================================
-- ENGINE: BOUNCING DVD LOGO OF DISRESPECT
-- ==========================================
local function phase_dvd()
    blast(colors.black, colors.white)
    local bx = math.random(1, math.max(1, w - 20))
    local by = math.random(1, math.max(1, h - 2))
    local dx, dy = 1, 1
    for i = 1, 500 do
        m.setBackgroundColor(colors.black)
        m.clear()
        bx = bx + dx
        by = by + dy
        local bounceText = genInsult()
        local tlen = #bounceText
        if bx <= 1 or bx + tlen >= w then dx = -dx end
        if by <= 1 or by >= h then dy = -dy end
        bx = math.max(1, math.min(w - tlen, bx))
        by = math.max(1, math.min(h, by))
        m.setTextColor(colors_list[math.random(1, #colors_list)])
        m.setCursorPos(bx, by)
        m.write(bounceText:sub(1, w - bx + 1))
        os.sleep(0.015)
    end
end

-- ==========================================
-- ENGINE: SKULL & RIP ANIMATION
-- ==========================================
local function phase_rip()
    blast(colors.black, colors.white)
    local midW = math.floor(w / 2) - 4
    local midH = math.floor(h / 2) - 4
    -- Flash skull
    for flash = 1, 5 do
        m.setTextColor(flash % 2 == 0 and colors.white or colors.red)
        for i, line in ipairs(ascii_skull) do
            m.setCursorPos(math.max(1, midW), math.max(1, midH + i - 1))
            m.write(line)
        end
        os.sleep(0.1)
        blast(colors.black, colors.white)
        os.sleep(0.05)
    end

    m.setTextColor(colors.red)
    for i, line in ipairs(ascii_skull) do
        m.setCursorPos(math.max(1, midW), math.max(1, midH + i - 1))
        m.write(line)
    end

    m.setTextColor(colors.white)
    center(midH + #ascii_skull + 1, "YOU DIED")
    center(midH + #ascii_skull + 2, genInsult())
    center(midH + #ascii_skull + 3, "Score: " .. math.random(-9999, 0))
    os.sleep(3)
end

-- ==========================================
-- ENGINE: FAKE VIRUS SCAN
-- ==========================================
local function phase_virusscan()
    blast(colors.black, colors.green)
    typeWriter(2, 2, "AVAST ANTIVIRUS - THREAT DETECTED", 0.01)
    os.sleep(0.3)
    typeWriter(2, 4, "Scanning: C:\\Users\\" .. adj[math.random(1,#adj)] .. "_GAMER\\Minecraft", 0.01)
    os.sleep(0.3)

    local threats = {
        {"SkillIssue.exe",           "CRITICAL - Skill Issue Virus (W64.NoobWare)"},
        {"HopiumPump.dll",           "HIGH    - Cope Injection Module"},
        {"XRay_Legit_I_Promise.jar", "CRITICAL - Confirmed Cheating Malware"},
        {"freecoins2026.exe",        "CRITICAL - Digital Idiocy (Trojan.Brainworm)"},
        {"DeleteSystem32.bat",       "CRITICAL - Self Inflicted Destruction Script"},
        {"DirtHouseBuilder.sys",     "LOW     - Aesthetic Crime (barely functional)"},
        {"LavaWalker.dll",           "HIGH    - Gravity Denial Module (always kills you)"},
        {"KeyboardTurner.exe",       "MEDIUM  - 2009 Combat Technique Detected"},
        {"F2P_Mindset.exe",          "HIGH    - Advanced Cope Behavior"},
        {"UnbanApeal_template.docx", "MEDIUM  - Denial Engine (delusional)"},
    }

    local row = 6
    for _, threat in ipairs(threats) do
        if row >= h - 1 then break end
        m.setTextColor(colors.white)
        typeWriter(2, row, ">> " .. threat[1], 0.005)
        m.setTextColor(colors.red)
        typeWriter(2, row + 1, "   [" .. threat[2] .. "]", 0.005)
        row = row + 2
        os.sleep(0.1)
    end

    os.sleep(0.5)
    m.setTextColor(colors.red)
    center(h - 1, "QUARANTINE FAILED - CANNOT FIX FUNDAMENTAL STUPIDITY")
    os.sleep(2.5)
end

-- ==========================================
-- ENGINE: CONSPIRACY THEORIES
-- ==========================================
local function phase_conspiracy()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.red)
    center(2, "*** CLASSIFIED INTEL ABOUT YOU ***")
    local row = 4
    for i = 1, math.min(#conspiracy_theories, math.floor((h - 4) / 2)) do
        if row >= h then break end
        m.setTextColor(colors_list[math.random(1, #colors_list)])
        typeWriter(2, row, "- " .. conspiracy_theories[math.random(1, #conspiracy_theories)], 0.01)
        row = row + 2
        os.sleep(0.4)
    end
    os.sleep(2)
end

-- ==========================================
-- ENGINE: FAKE TASK MANAGER
-- ==========================================
local function phase_taskmanager()
    blast(colors.black, colors.white)
    center(1, "TASK MANAGER - PROCESSES RUNNING IN YOUR HEAD")
    fillRow(2, "-", colors.gray, colors.black)
    m.setTextColor(colors.lightGray)
    typeWriter(2, 3, "NAME                CPU%    MEM     STATUS", 0.002)
    fillRow(4, "-", colors.gray, colors.black)

    local procs = {
        {"cope.exe",              "97%",  "8.2GB", "NOT RESPONDING"},
        {"skill.dll",             "0%",   "0KB",   "NOT FOUND"},
        {"braincells.sys",        "0.1%", "256B",  "CRITICAL LOW"},
        {"touch_grass.exe",       "0%",   "0KB",   "NEVER LAUNCHED"},
        {"dirt_palace_3d.exe",    "45%",  "2.1GB", "RUNNING (barely)"},
        {"xray_client.jar",       "12%",  "900MB", "TOTALLY LEGIT"},
        {"unban_appeal.docx",     "8%",   "400MB", "DRAFTING (6th attempt)"},
        {"delete_evidence.bat",   "34%",  "1.1GB", "SUSPENDED"},
        {"hopium.exe",            "55%",  "5.5GB", "NOT RESPONDING"},
        {"minecraft.exe",         "99%",  "14GB",  "NOT RESPONDING"},
        {"parents_trust.dll",     "0%",   "0KB",   "TERMINATED"},
    }

    local row = 5
    for _, p in ipairs(procs) do
        if row >= h then break end
        m.setTextColor(p[4] == "NOT RESPONDING" and colors.red or colors.white)
        local line = string.format("%-20s %-7s %-7s %s", p[1]:sub(1,20), p[2], p[3], p[4])
        typeWriter(2, row, line:sub(1, w - 2), 0.002)
        row = row + 1
        os.sleep(0.06)
    end
    os.sleep(3)
end

-- ==========================================
-- ENGINE: SEIZURE PROTOCOL (ENHANCED)
-- ==========================================
local function phase_seizure()
    for i = 1, 120 do
        local bg = colors_list[math.random(1, #colors_list)]
        local fg = colors_list[math.random(1, #colors_list)]
        blast(bg, fg)
        if math.random(1, 3) == 1 then
            center(math.floor(h/2) - 1, genInsult())
            center(math.floor(h/2) + 1, genInsult())
        else
            center(math.floor(h/2), "ABSOLUTE " .. genInsult())
        end
        os.sleep(0.007)
    end
end

-- ==========================================
-- ENGINE: PROGRESS BARS OF SHAME
-- ==========================================
local function phase_progress()
    blast(colors.black, colors.white)
    center(2, "RUNNING DIAGNOSTICS ON: YOU")
    os.sleep(0.5)

    local checks = {
        "Checking skill level",
        "Verifying braincell count",
        "Locating redeeming qualities",
        "Searching for game sense",
        "Attempting to find W",
        "Looking for non-dirt-tier plays",
        "Confirming basic awareness",
        "Validating spatial reasoning",
    }

    local row = 4
    for i, check in ipairs(checks) do
        if row >= h - 1 then break end
        progressBar(row, check, 0.015)
        row = row + 2
        os.sleep(0.1)
    end

    os.sleep(0.5)
    m.setTextColor(colors.red)
    center(h - 1, "DIAGNOSIS: TERMINAL SKILL ISSUE. NO CURE FOUND.")
    os.sleep(3)
end

-- ==========================================
-- ENGINE: WARDEN CUTSCENE
-- ==========================================
local function phase_warden()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(3, "PROXIMITY ALERT: WARDEN INCOMING")
    os.sleep(0.5)
    m.setTextColor(colors.orange)

    local warden = {
        "                _",
        "     ___.------'  '-.",
        "  .-'  |              '.",
        " /     |   WARDEN      \\",
        "|      |   FOUND YOU    |",
        " \\     |    AGAIN      /",
        "  '-.__|         _.--'",
        "        '-------'",
    }
    for i, line in ipairs(warden) do
        center(4 + i, line)
        os.sleep(0.1)
    end

    os.sleep(0.5)
    m.setTextColor(colors.white)
    center(h - 3, "You placed a torch.")
    center(h - 2, "It heard you.")
    center(h - 1, "It always hears you.")
    os.sleep(3)
end

-- ==========================================
-- ENGINE: SCOREBOARD OF SHAME
-- ==========================================
local function phase_scoreboard()
    blast(colors.black, colors.white)
    center(2, "LIFETIME SERVER STATS: " .. genInsult())
    fillRow(3, "=", colors.gray, colors.black)

    local stats = {
        {"Deaths by creeper",       math.random(60, 999)},
        {"Deaths by lava",          math.random(40, 500)},
        {"Deaths by fall damage",   math.random(80, 800)},
        {"Deaths by own TNT",       math.random(5, 200)},
        {"Deaths by skeleton",      math.random(90, 1200)},
        {"Total diamonds lost",     math.random(100, 5000)},
        {"Dirt blocks placed",      math.random(5000, 99999)},
        {"Unban appeals written",   math.random(3, 47)},
        {"Times claimed 'it was lag'", math.random(200, 9999)},
        {"Friends made",            math.random(0, 2)},
        {"Times you've improved",   0},
        {"Wins",                    0},
    }

    local row = 4
    for _, s in ipairs(stats) do
        if row >= h then break end
        m.setTextColor(colors_list[math.random(1, #colors_list)])
        local line = string.format("%-36s %d", s[1]:sub(1,36), s[2])
        typeWriter(2, row, line:sub(1, w - 2), 0.003)
        row = row + 1
        os.sleep(0.05)
    end
    os.sleep(3)
end

-- ==========================================
-- ENGINE: REBOOT SEQUENCE
-- ==========================================
local function phase_reboot()
    blast(colors.black, colors.red)
    center(math.floor(h/2) - 2, "MEMORY LEAK DETECTED.")
    center(math.floor(h/2), "REBOOTING CONFIDENCE...")
    center(math.floor(h/2) + 2, "ETA: NEVER")
    os.sleep(2)

    blast(colors.black, colors.white)
    for i = 5, 0, -1 do
        m.clear()
        center(math.floor(h/2) - 1, "REINITIALIZING BRAIN IN " .. i .. "...")
        center(math.floor(h/2) + 1, genInsult())
        os.sleep(1)
    end
end

-- ==========================================
-- ENGINE: LIVE FEED TICKER
-- ==========================================
local function phase_ticker()
    blast(colors.black, colors.yellow)
    center(2, "*** BREAKING NEWS ABOUT YOU ***")
    local ticker_items = {
        "LOCAL PLAYER DIES AGAIN - SOURCES CONFIRM 'IT WAS LAG'",
        "INVENTORY LOST IN LAVA - FOURTH TIME THIS WEEK",
        "DIRT HUT DISTRICT REPORTS SURGE IN STRUCTURAL FAILURES",
        "VILLAGERS FILE COMPLAINT: 'HE KEEPS PUNCHING US'",
        "CREEPER ASSOCIATION NAMES NEW HONORARY MEMBER",
        "SERVER ECONOMY CRASHES: TOO MUCH DIRT IN CIRCULATION",
        "UNBAN APPEAL #" .. math.random(7, 38) .. " DENIED - ADMINS TIRED",
        "LOCAL SKELETON WINS MARKSMAN AWARD (VICTIM: YOU)",
        "NETHER PORTAL REQUESTS RESTRAINING ORDER",
        "IRON GOLEM RETIRES CITING 'MORAL OBJECTIONS'",
    }

    for _, item in ipairs(ticker_items) do
        local row = math.random(3, h - 1)
        m.setTextColor(colors_list[math.random(1, #colors_list)])
        -- Scroll text across the screen
        for startX = w, 1 - #item, -1 do
            m.setCursorPos(1, row)
            m.write(string.rep(" ", w))
            local drawX = startX
            local drawStr = item
            if drawX < 1 then
                drawStr = drawStr:sub(1 - drawX + 1)
                drawX = 1
            end
            m.setCursorPos(drawX, row)
            m.write(drawStr:sub(1, w - drawX + 1))
            os.sleep(0.015)
        end
    end
end

-- ==========================================
-- MAIN VISUAL LOOP - ALL PHASES
-- ==========================================
local phase_order = {
    phase_bsod,
    phase_dox,
    phase_virusscan,
    phase_history,
    phase_discord,
    phase_achievements,
    phase_roast,
    phase_taskmanager,
    phase_progress,
    phase_conspiracy,
    phase_scoreboard,
    phase_matrix,
    phase_rip,
    phase_dvd,
    phase_warden,
    phase_ticker,
    phase_seizure,
    phase_reboot,
}

local function visualLoop()
    while true do
        -- Shuffle phase order every cycle for maximum chaos
        for i = #phase_order, 2, -1 do
            local j = math.random(1, i)
            phase_order[i], phase_order[j] = phase_order[j], phase_order[i]
        end

        for _, phase in ipairs(phase_order) do
            local ok, err = pcall(phase)
            if not ok then
                -- If a phase crashes, display the crash and move on
                blast(colors.red, colors.white)
                center(math.floor(h/2), "PHASE CRASHED: " .. tostring(err):sub(1, w-4))
                os.sleep(1)
            end
        end
    end
end

-- ==========================================
-- UNLEASH BOTH LOOPS SIMULTANEOUSLY
-- ==========================================
blast(colors.black, colors.red)
center(math.floor(h/2) - 1, "INITIALIZING BRAINROT ENGINE...")
center(math.floor(h/2) + 1, "NO SURVIVORS.")
os.sleep(2)

parallel.waitForAny(visualLoop, audioLoop)
