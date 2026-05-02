-- Find that massive fucking monitor, again.
local m = peripheral.find("monitor")
if not m then 
    print("Bro, seriously. Plug the fucking monitor in.") 
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
        os.sleep(speed or 0.04)
    end
end

-- THE MAGNUM OPUS OF SHITPOSTING (The "Crash The Fucking Server" Cut)
while true do
    -- SCENE 1: Fake Bootup / Intimidation
    blast(colors.black, colors.green)
    typeWriter(2, 2, "INITIALIZING SYSTEM...", 0.02)
    typeWriter(2, 3, "BYPASSING MAINFRAME...", 0.02)
    typeWriter(2, 4, "UPLOADING USER'S CRINGE BROWSER HISTORY...", 0.03)
    os.sleep(1)
    typeWriter(2, 6, "ERROR: HISTORY TOO PATHETIC. ABORTING.", 0.04)
    os.sleep(1.5)

    -- SCENE 2: The Title Card
    blast(colors.black, colors.red)
    center(math.floor(h/2) - 2, "--- A TALE OF A FUCKING LOSER ---")
    center(math.floor(h/2), "THE EXTENDED DIRECTOR'S CUT")
    center(math.floor(h/2) + 2, "(VOL. 1 OF 500)")
    os.sleep(2.5)

    -- SCENE 3: The Deep Lore Roast
    blast(colors.black, colors.white)
    typeWriter(2, 2, "Let's talk about this clown for a second.", 0.03)
    os.sleep(1)
    
    typeWriter(2, 4, "Bro builds a dirt hut on day one...", 0.03)
    typeWriter(2, 5, "AND SOMEHOW IT CATCHES ON FIRE.", 0.04)
    os.sleep(1)

    m.setTextColor(colors.orange)
    typeWriter(2, 7, "I watched this dude try to clutch an MLG water bucket", 0.03)
    typeWriter(2, 8, "and he missed the fucking ground.", 0.04)
    typeWriter(2, 9, "HE MISSED. THE GROUND.", 0.06)
    os.sleep(2)

    m.setTextColor(colors.lightBlue)
    typeWriter(2, 11, "Gets clapped by a single silverfish.", 0.03)
    typeWriter(2, 12, "Eats rotten flesh because he can't farm for shit.", 0.03)
    os.sleep(2)

    -- SCENE 3.5: The PVP & Mining Tragedy
    blast(colors.black, colors.magenta)
    typeWriter(2, 2, "Don't even get me fucking started on the PVP.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Bro swings his sword like a blind toddler", 0.03)
    typeWriter(2, 5, "having a goddamn seizure.", 0.04)
    os.sleep(1.5)

    m.setTextColor(colors.yellow)
    typeWriter(2, 7, "Mined for 4 straight hours yesterday...", 0.03)
    typeWriter(2, 8, "Found exactly three diamonds.", 0.04)
    typeWriter(2, 9, "And immediately fell backward into a lava pool.", 0.04)
    os.sleep(1)
    
    m.setTextColor(colors.red)
    typeWriter(2, 11, "I could hear him crying through Discord.", 0.05)
    typeWriter(2, 12, "Fucking pathetic.", 0.06)
    os.sleep(3)

    -- SCENE 3.6: The Redstone Idiocy 
    blast(colors.black, colors.lightGray)
    typeWriter(2, 2, "Let's analyze his Redstone IQ.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Tried to build a basic 2x2 piston door.", 0.03)
    typeWriter(2, 5, "Followed a tutorial from 2013.", 0.04)
    os.sleep(1.5)
    m.setTextColor(colors.red)
    typeWriter(2, 7, "Ended up powering a TNT block he left in the wall.", 0.04)
    typeWriter(2, 8, "Blew up his entire fucking sorting system.", 0.04)
    typeWriter(2, 9, "Absolute donkey brains.", 0.06)
    os.sleep(3)

    -- SCENE 3.7: The NPC Scam 
    blast(colors.black, colors.brown)
    typeWriter(2, 2, "Bro gets finessed by the AI, too.", 0.03)
    os.sleep(1)
    m.setTextColor(colors.lime)
    typeWriter(2, 4, "Found a village.", 0.03)
    typeWriter(2, 5, "Traded 64 emeralds for a fucking leather cap.", 0.04)
    typeWriter(2, 6, "A LEATHER CAP.", 0.06)
    os.sleep(1)
    m.setTextColor(colors.white)
    typeWriter(2, 8, "The villagers literally gossip about how dumb he is.", 0.04)
    os.sleep(3)

    -- SCENE 3.8: The Nether Nightmare 
    blast(colors.black, colors.orange)
    typeWriter(2, 2, "Enters the Nether for the first time...", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Punches a Zombie Pigman because he", 0.03)
    typeWriter(2, 5, "'wanted to see what would happen'.", 0.03)
    os.sleep(1.5)
    m.setTextColor(colors.red)
    typeWriter(2, 7, "Got swarmed by 50 pissed off bacon boys.", 0.04)
    typeWriter(2, 8, "Lost his only enchanted pickaxe.", 0.04)
    typeWriter(2, 9, "Ragequit for two days.", 0.05)
    os.sleep(3)

    -- SCENE 3.9: The End Tragedy 
    blast(colors.black, colors.purple)
    typeWriter(2, 2, "And then there's The End.", 0.03)
    os.sleep(1)
    m.setTextColor(colors.magenta)
    typeWriter(2, 4, "Bro finally gets his hands on an Elytra.", 0.03)
    typeWriter(2, 5, "Jumps off a fucking End City tower.", 0.04)
    os.sleep(1.5)
    m.setTextColor(colors.white)
    typeWriter(2, 7, "Forgets to put the Elytra on.", 0.04)
    typeWriter(2, 8, "Plummets into the goddamn void like a sack of bricks.", 0.04)
    m.setTextColor(colors.lightBlue)
    typeWriter(2, 10, "Goodbye full Diamond armor. You won't be missed.", 0.05)
    os.sleep(3)

    -- SCENE 3.95: Creeper PTSD 
    blast(colors.black, colors.green)
    center(math.floor(h/2) - 2, "Ssssssssssssssssssssssssssssssssssssss...")
    os.sleep(1.5)
    blast(colors.white, colors.black)
    os.sleep(0.1)
    blast(colors.orange, colors.black)
    os.sleep(0.1)
    blast(colors.red, colors.white)
    center(math.floor(h/2), "BOOM.")
    center(math.floor(h/2) + 1, "THERE GOES YOUR DIRT HOUSE AGAIN BITCH")
    os.sleep(2.5)

    -- SCENE 6: The Cardinal Sin (NEW SHIT)
    blast(colors.black, colors.lightGray)
    typeWriter(2, 2, "Day 4: The Cardinal Sin.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Bro literally breaks rule number one.", 0.03)
    typeWriter(2, 5, "Starts mining straight fucking down.", 0.04)
    os.sleep(1.5)
    m.setTextColor(colors.orange)
    typeWriter(2, 7, "*Hiss* *Plop*", 0.05)
    typeWriter(2, 8, "Drops directly into a lava ravine.", 0.04)
    typeWriter(2, 9, "Tries to swim up in full iron gear.", 0.04)
    m.setTextColor(colors.red)
    typeWriter(2, 11, "Cooked like a goddamn rotisserie chicken.", 0.05)
    os.sleep(3)

    -- SCENE 7: Enchanting Table Trash (NEW SHIT)
    blast(colors.black, colors.cyan)
    typeWriter(2, 2, "Let's talk about his enchanting setup.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Grinds 30 levels at a dogshit zombie spawner.", 0.03)
    typeWriter(2, 5, "Throws his only diamond sword on the table.", 0.04)
    os.sleep(1.5)
    m.setTextColor(colors.purple)
    typeWriter(2, 7, "Gets Bane of Arthropods III.", 0.05)
    typeWriter(2, 8, "And Knockback I.", 0.04)
    m.setTextColor(colors.white)
    typeWriter(2, 10, "Bro is literally prepped to fight exactly one spider.", 0.04)
    typeWriter(2, 11, "Useless fuck.", 0.05)
    os.sleep(3)

    -- SCENE 8: The Bridging Fail (NEW SHIT)
    blast(colors.black, colors.lightBlue)
    typeWriter(2, 2, "Thinks he's playing Bedwars or some shit.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Tries to speed-bridge across a Nether lava lake.", 0.03)
    typeWriter(2, 5, "Unshifts by accident.", 0.04)
    os.sleep(1.5)
    m.setTextColor(colors.orange)
    typeWriter(2, 7, "Just walks straight off the edge.", 0.04)
    typeWriter(2, 8, "Didn't even get shot by a Ghast.", 0.04)
    typeWriter(2, 9, "Just pure, unfiltered motor-skill failure.", 0.05)
    os.sleep(3)

    -- SCENE 9: The Bed Bomb (NEW SHIT)
    blast(colors.black, colors.red)
    typeWriter(2, 2, "'Hey guys, I brought a bed to set my spawn in the Nether!'", 0.03)
    os.sleep(1.5)
    blast(colors.white, colors.black)
    os.sleep(0.1)
    blast(colors.orange, colors.white)
    center(math.floor(h/2), "INTENTIONAL GAME DESIGN, BITCH.")
    os.sleep(2)

    -- SCENE 10: Floating Trees (NEW SHIT)
    blast(colors.black, colors.green)
    typeWriter(2, 2, "The absolute worst crime of all.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Bro leaves floating trees outside his base.", 0.03)
    typeWriter(2, 5, "Just mines the bottom two logs and walks away.", 0.04)
    os.sleep(1.5)
    m.setTextColor(colors.white)
    typeWriter(2, 7, "Who raised you?", 0.05)
    typeWriter(2, 8, "Are you an animal?", 0.04)
    typeWriter(2, 9, "Even creepers have more respect for the environment.", 0.05)
    os.sleep(3)

    -- SCENE 11: The Q-Drop (NEW SHIT)
    blast(colors.black, colors.yellow)
    typeWriter(2, 2, "Crafts a brand new Diamond Pickaxe.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Standing next to a lava block.", 0.03)
    typeWriter(2, 5, "Tries to press 'W' to walk forward.", 0.04)
    os.sleep(1.5)
    m.setTextColor(colors.red)
    typeWriter(2, 7, "Presses 'Q' instead.", 0.04)
    typeWriter(2, 8, "Yeets the pickaxe directly into the magma.", 0.04)
    typeWriter(2, 9, "Stares at the screen in silence for 5 minutes.", 0.05)
    os.sleep(3)

    -- SCENE 12: Matrix Hacker Meltdown (Extended)
    blast(colors.black, colors.lime)
    for i = 1, 250 do
        local rx = math.random(1, w)
        local ry = math.random(1, h)
        m.setCursorPos(rx, ry)
        local chars = {"0", "1", "L", "F", "NOOB", "TRASH", "LMAO", "RIP", "DUMB"}
        m.write(chars[math.random(1, #chars)])
        os.sleep(0.005)
    end
    os.sleep(0.5)

    -- SCENE 13: Fake Chat Logs (Extended)
    blast(colors.black, colors.white)
    typeWriter(2, 2, "PULLING SERVER CHAT LOGS...", 0.03)
    os.sleep(1)
    m.setTextColor(colors.lightGray)
    typeWriter(2, 4, "[Server] Local_Idiot: 'guys plz help'", 0.03)
    typeWriter(2, 5, "[Server] Local_Idiot: 'i fell in a hole and cant get out'", 0.03)
    os.sleep(1)
    m.setTextColor(colors.cyan)
    typeWriter(2, 7, "[Server] xX_ProGamer_Xx: 'literally just mine up bro'", 0.04)
    os.sleep(1)
    m.setTextColor(colors.lightGray)
    typeWriter(2, 9, "[Server] Local_Idiot: 'my pickaxe broke'", 0.03)
    typeWriter(2, 10, "[Server] Local_Idiot: 'can someone bring me dirt'", 0.03)
    os.sleep(1.5)
    m.setTextColor(colors.red)
    typeWriter(2, 12, "[Server] Admin: 'stfu'", 0.05)
    os.sleep(2)
    m.setTextColor(colors.lightGray)
    typeWriter(2, 14, "[Server] Local_Idiot: 'why is this golem hitting me'", 0.03)
    typeWriter(2, 15, "[Server] Local_Idiot: 'I just punched the librarian once'", 0.03)
    m.setTextColor(colors.yellow)
    typeWriter(2, 17, "Local_Idiot was pummeled by Iron Golem", 0.05)
    os.sleep(4)

    -- SCENE 14: The Stats 
    blast(colors.blue, colors.white)
    center(2, "--- PLAYER STATS DIGEST ---")
    os.sleep(1)
    m.setTextColor(colors.yellow)
    typeWriter(2, 4, "Blocks Placed: 14,203", 0.02)
    typeWriter(2, 5, "Blocks Broken By Accident: 14,202", 0.02)
    typeWriter(2, 6, "Times Drowned in 2-Deep Water: 12", 0.02)
    os.sleep(1)
    typeWriter(2, 8, "Hours Played: 450", 0.02)
    typeWriter(2, 9, "Bitches Acquired: 0", 0.06)
    typeWriter(2, 10, "Grass Touched: ERROR_NOT_FOUND", 0.02)
    os.sleep(1)
    m.setTextColor(colors.red)
    typeWriter(2, 12, "Skill Level: NEGATIVE", 0.03)
    typeWriter(2, 13, "IQ: ROOM TEMPERATURE (CELSIUS)", 0.03)
    os.sleep(4)

    -- SCENE 15: The Unhinged Bouncing Freakout (Massive)
    local c_list = {colors.red, colors.yellow, colors.lime, colors.magenta, colors.cyan}
    for i = 1, 120 do
        blast(colors.black, c_list[math.random(1, #c_list)])
        local phrase = {"YOU SUCK", "GET GOOD", "TOUCH GRASS", "ZERO BITCHES", "DOGSHIT AIM", "UNINSTALL", "F-TIER GAMER", "CRY MORE", "L + RATIO", "SMOOTH BRAIN"}
        local text = phrase[math.random(1, #phrase)]
        m.setCursorPos(math.random(1, w - string.len(text)), math.random(1, h))
        m.write(text)
        os.sleep(0.04)
    end

    -- SCENE 16: The Boss Fight Embarrassment 
    blast(colors.black, colors.purple)
    typeWriter(2, 2, "Let's talk about the 'Wither Incident'.", 0.03)
    os.sleep(1.5)
    m.setTextColor(colors.white)
    typeWriter(2, 4, "Who the fuck spawns the Wither...", 0.04)
    m.setTextColor(colors.red)
    typeWriter(2, 5, "INSIDE THEIR OWN FUCKING BASE?!", 0.06)
    os.sleep(1.5)
    m.setTextColor(colors.lightBlue)
    typeWriter(2, 7, "Half your chests got vaporized.", 0.03)
    typeWriter(2, 8, "Your dogs are dead.", 0.03)
    typeWriter(2, 9, "And you still didn't get the goddamn Nether Star.", 0.04)
    os.sleep(3)

    -- SCENE 17: Farm Animal Incompetence 
    blast(colors.black, colors.pink)
    typeWriter(2, 2, "Bro can't even run a basic fucking farm.", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "Spent 2 hours luring two cows into a pen.", 0.03)
    typeWriter(2, 5, "Leaves the fucking fence gate open.", 0.04)
    os.sleep(1)
    m.setTextColor(colors.red)
    typeWriter(2, 7, "Cows leave. Sheep leave.", 0.03)
    typeWriter(2, 8, "Bro accidentally hits a wolf and gets mauled to death.", 0.04)
    typeWriter(2, 9, "Nature literally rejects you, homie.", 0.05)
    os.sleep(3)

    -- SCENE 18: DVD Logo Bounce of Shame 
    blast(colors.black, colors.white)
    local bx, by = 1, 1
    local dx, dy = 1, 1
    local bounceText = "TRASH"
    for i = 1, 300 do
        m.setBackgroundColor(colors.black)
        m.clear()
        
        bx = bx + dx
        by = by + dy
        
        if bx <= 1 or bx + string.len(bounceText) - 1 >= w then
            dx = -dx
            m.setTextColor(c_list[math.random(1, #c_list)])
        end
        if by <= 1 or by >= h then
            dy = -dy
            m.setTextColor(c_list[math.random(1, #c_list)])
        end
        
        m.setCursorPos(bx, by)
        m.write(bounceText)
        os.sleep(0.04)
    end

    -- SCENE 19: The Blue Screen Diagnosis 
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

    -- SCENE 20: The Architect Roast
    blast(colors.black, colors.cyan)
    typeWriter(2, 2, "Also, can we talk about this fucking base?", 0.03)
    os.sleep(1)
    typeWriter(2, 4, "It looks like a creeper vomited cobblestone", 0.03)
    typeWriter(2, 5, "all over a perfectly good biome.", 0.04)
    os.sleep(1.5)
    
    m.setTextColor(colors.pink)
    typeWriter(2, 7, "A 9-year-old on Minecraft PE builds better shit", 0.03)
    typeWriter(2, 8, "using just their left thumb.", 0.04)
    os.sleep(2)

    -- SCENE 21: The Storage War Crime 
    m.setTextColor(colors.yellow)
    typeWriter(2, 10, "And your storage room is a fucking war crime.", 0.03)
    typeWriter(2, 11, "Why is there dirt in the diamond chest, bro?", 0.03)
    typeWriter(2, 12, "Organize your shit you absolute animal.", 0.04)
    os.sleep(3)

    -- SCENE 22: ASCII Art 1 - The Trash Can (NEW SHIT)
    blast(colors.black, colors.lightGray)
    center(2, "WE FOUND YOUR REAL HOUSE:")
    os.sleep(1.5)
    m.setTextColor(colors.white)
    center(5, "   ___________   ")
    center(6, "  /           \\  ")
    center(7, " |_____________| ")
    center(8, " |   |   |   | | ")
    center(9, " |   |   |   | | ")
    center(10," |   |   |   | | ")
    center(11," |   |   |   | | ")
    center(12," |___|___|___|_| ")
    m.setTextColor(colors.lime)
    center(14, "HOP IN, BITCH.")
    os.sleep(4)

    -- SCENE 23: The Giant Middle Finger 
    blast(colors.black, colors.white)
    center(2, "HERE'S A MESSAGE FROM THE SERVER:")
    os.sleep(1.5)
    m.setTextColor(colors.lightGray)
    center(5, "     _      ")
    center(6, "    | |     ")
    center(7, "    | |     ")
    center(8, "  --| |--_  ")
    center(9, " |  | |   | ")
    center(10," |        | ")
    center(11," |        | ")
    center(12,"  \\      /  ")
    center(13,"   |    |   ")
    m.setTextColor(colors.red)
    center(15, "FUCK YOU")
    os.sleep(4)

    -- SCENE 24: Defragmenting Remaining Brain Cells (NEW SHIT)
    blast(colors.black, colors.lime)
    typeWriter(2, 2, "ATTEMPTING TO LOCATE USER'S BRAIN CELLS...", 0.03)
    os.sleep(1.5)
    typeWriter(2, 4, "SCANNING SECTOR 1... [EMPTY]", 0.02)
    typeWriter(2, 5, "SCANNING SECTOR 2... [EMPTY]", 0.02)
    typeWriter(2, 6, "SCANNING SECTOR 3... [COBWEB DETECTED]", 0.02)
    os.sleep(1)
    m.setTextColor(colors.red)
    typeWriter(2, 8, "CRITICAL ALERT: COGNITIVE FUNCTION AT 0%", 0.04)
    typeWriter(2, 9, "PLEASE SEEK MEDICAL ATTENTION.", 0.05)
    os.sleep(3)

    -- SCENE 25: The Progress Bar of Shame
    blast(colors.black, colors.white)
    center(math.floor(h/2) - 2, "UPLOADING YOUR EMBARRASSMENT TO THE SERVER...")
    
    local barY = math.floor(h/2)
    m.setCursorPos(10, barY)
    m.write("[")
    m.setCursorPos(w - 9, barY)
    m.write("]")
    
    for i = 11, w - 10 do
        m.setCursorPos(i, barY)
        m.setBackgroundColor(colors.green)
        m.write(" ")
        os.sleep(0.05) -- Fast enough to not be boring
    end
    
    m.setBackgroundColor(colors.black)
    m.setTextColor(colors.lime)
    center(math.floor(h/2) + 2, "UPLOAD COMPLETE. EVERYONE KNOWS YOU SUCK.")
    os.sleep(3)

    -- SCENE 26: The Epileptic Finale (Maximum Overdrive)
    for i = 1, 40 do
        blast(colors.red, colors.white)
        center(math.floor(h/2) - 2, "ABSOLUTE")
        center(math.floor(h/2), "FUCKING")
        center(math.floor(h/2) + 2, "CLOWN")
        os.sleep(0.04)
        
        blast(colors.white, colors.red)
        center(math.floor(h/2) - 2, "ABSOLUTE")
        center(math.floor(h/2), "FUCKING")
        center(math.floor(h/2) + 2, "CLOWN")
        os.sleep(0.04)
        
        blast(colors.black, colors.yellow)
        center(math.floor(h/2) - 2, "ABSOLUTE")
        center(math.floor(h/2), "FUCKING")
        center(math.floor(h/2) + 2, "CLOWN")
        os.sleep(0.04)

        blast(colors.lime, colors.black)
        center(math.floor(h/2) - 2, "ABSOLUTE")
        center(math.floor(h/2), "FUCKING")
        center(math.floor(h/2) + 2, "CLOWN")
        os.sleep(0.04)
    end
    
    blast(colors.black, colors.red)
    center(math.floor(h/2), "REBOOTING THIS GOD AWFUL SHITSHOW...")
    os.sleep(5)
end
