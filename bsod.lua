-- Find that massive fucking monitor
local m = peripheral.find("monitor")
if not m then 
    print("Bro, plug the fucking monitor in. Are you blind?") 
    return 
end

m.setTextScale(1)
term.redirect(m)
local w, h = m.getSize()

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

local function typeWriter(x, y, text, speed)
    m.setCursorPos(x, y)
    for i = 1, string.len(text) do
        m.write(string.sub(text, i, i))
        os.sleep(speed or 0.05)
    end
end

-- The extended cinematic shitpost
while true do
    -- SCENE 1: Fake Bootup / Intimidation
    blast(colors.black, colors.green)
    typeWriter(2, 2, "INITIALIZING SYSTEM...", 0.02)
    typeWriter(2, 3, "BYPASSING MAINFRAME...", 0.02)
    typeWriter(2, 4, "UPLOADING USER'S CRINGE BROWSER HISTORY...", 0.04)
    os.sleep(1)
    typeWriter(2, 6, "ERROR: HISTORY TOO PATHETIC. ABORTING.", 0.05)
    os.sleep(1.5)

    -- SCENE 2: The Title Card
    blast(colors.black, colors.red)
    center(math.floor(h/2) - 2, "--- A TALE OF A FUCKING LOSER ---")
    os.sleep(2)

    -- SCENE 3: The Deep Lore Roast
    blast(colors.black, colors.white)
    typeWriter(2, 2, "Let's talk about this clown for a second.", 0.03)
    os.sleep(1)
    
    typeWriter(2, 4, "Bro builds a dirt hut on day one...", 0.03)
    typeWriter(2, 5, "AND SOMEHOW IT CATCHES ON FIRE.", 0.05)
    os.sleep(1)

    m.setTextColor(colors.orange)
    typeWriter(2, 7, "I watched this dude try to clutch an MLG water bucket", 0.03)
    typeWriter(2, 8, "and he missed the fucking ground.", 0.05)
    typeWriter(2, 9, "HE MISSED. THE GROUND.", 0.08)
    os.sleep(2)

    m.setTextColor(colors.lightBlue)
    typeWriter(2, 11, "Gets clapped by a single silverfish.", 0.04)
    typeWriter(2, 12, "Eats rotten flesh because he can't farm for shit.", 0.04)
    os.sleep(2)

    -- SCENE 3.5: The PVP & Mining Tragedy (NEW SHIT)
    blast(colors.black, colors.magenta)
    typeWriter(2, 2, "Don't even get me fucking started on the PVP.", 0.04)
    os.sleep(1)
    typeWriter(2, 4, "Bro swings his sword like a blind toddler", 0.03)
    typeWriter(2, 5, "having a goddamn seizure.", 0.05)
    os.sleep(1.5)

    m.setTextColor(colors.yellow)
    typeWriter(2, 7, "Mined for 4 straight hours yesterday...", 0.04)
    typeWriter(2, 8, "Found exactly three diamonds.", 0.05)
    typeWriter(2, 9, "And immediately fell backward into a lava pool.", 0.05)
    os.sleep(1)
    
    m.setTextColor(colors.red)
    typeWriter(2, 11, "I could hear him crying through Discord.", 0.06)
    typeWriter(2, 12, "Fucking pathetic.", 0.08)
    os.sleep(3)

    -- SCENE 4: Matrix Hacker Meltdown
    blast(colors.black, colors.lime)
    for i = 1, 100 do
        local rx = math.random(1, w)
        local ry = math.random(1, h)
        m.setCursorPos(rx, ry)
        -- Random binary and insults
        local chars = {"0", "1", "L", "F", "NOOB", "TRASH", "LMAO"}
        m.write(chars[math.random(1, #chars)])
        os.sleep(0.01)
    end
    os.sleep(0.5)

    -- SCENE 5: The Unhinged Bouncing Freakout
    local c_list = {colors.red, colors.yellow, colors.lime, colors.magenta, colors.cyan}
    for i = 1, 50 do
        blast(colors.black, c_list[math.random(1, #c_list)])
        local phrase = {"YOU SUCK", "GET GOOD", "TOUCH GRASS", "ZERO BITCHES", "DOGSHIT AIM"}
        local text = phrase[math.random(1, #phrase)]
        m.setCursorPos(math.random(1, w - string.len(text)), math.random(1, h))
        m.write(text)
        os.sleep(0.05)
    end

    -- SCENE 5.5: The Blue Screen Diagnosis (NEW SHIT)
    blast(colors.blue, colors.white)
    center(math.floor(h/2) - 4, "SYSTEM FATAL ERROR: USER IS TRASH")
    center(math.floor(h/2) - 2, "DIAGNOSIS REPORT COMPILED:")
    os.sleep(1.5)
    
    m.setTextColor(colors.yellow)
    center(math.floor(h/2), "TERMINAL SKILL ISSUE DETECTED.")
    center(math.floor(h/2) + 1, "NO CURE AVAILABLE.")
    os.sleep(2)
    
    m.setTextColor(colors.red)
    center(math.floor(h/2) + 3, "RECOMMENDATION: UNINSTALL AND CRY.")
    os.sleep(3.5)

    -- SCENE 6: The Epileptic Finale
    for i = 1, 10 do
        blast(colors.red, colors.white)
        center(math.floor(h/2) - 1, "ABSOLUTE")
        center(math.floor(h/2) + 1, "FUCKING CLOWN")
        os.sleep(0.1)
        
        blast(colors.white, colors.red)
        center(math.floor(h/2) - 1, "ABSOLUTE")
        center(math.floor(h/2) + 1, "FUCKING CLOWN")
        os.sleep(0.1)
    end
    
    blast(colors.black, colors.red)
    center(math.floor(h/2), "REBOOTING SHITSHOW...")
    os.sleep(3)
end
