-- Find that massive fucking monitor
local m = peripheral.find("monitor")
if not m then 
    print("Bro, seriously. Plug the fucking monitor in.") 
    return 
end

-- Find the fucking speakers
local speakers = {peripheral.find("speaker")}
if #speakers == 0 then
    print("Dude, you said you had speakers. Where are they? Plug 'em in, idiot.")
end

m.setTextScale(1)
term.redirect(m)
local w, h = m.getSize()

-- Helper functions for the visual shitpost
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

-- ==========================================
-- THE AUDIO BRAINROT LOOP (PSYCHOLOGICAL TORTURE)
-- ==========================================
local function audioLoop()
    if #speakers == 0 then
        while true do os.sleep(1) end
    end
    
    local instruments = {"cow_bell", "bit", "banjo", "didgeridoo", "pling", "flute", "bell", "chime", "xylophone"}
    
    while true do
        for _, s in pairs(speakers) do
            s.playNote(instruments[math.random(1, #instruments)], 0.5, math.random(0, 24))
        end
        os.sleep(math.random(2, 10) / 100) 
    end
end

-- ==========================================
-- THE VISUAL SHITPOST LOOP (800+ LINES OF PAIN)
-- ==========================================
local function visualLoop()
    while true do
        -- SCENE 1: Fake Bootup
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
        center(math.floor(h/2), "THE 800-LINE SERVER MELTDOWN CUT")
        center(math.floor(h/2) + 2, "(YOUR RAM IS GOING TO EXPLODE)")
        os.sleep(2.5)

        -- SCENE 3: The Dirt Hut
        blast(colors.black, colors.white)
        typeWriter(2, 2, "Let's talk about this clown for a second.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Bro builds a dirt hut on day one...", 0.03)
        typeWriter(2, 5, "AND SOMEHOW IT CATCHES ON FIRE.", 0.04)
        os.sleep(1)

        -- SCENE 4: The MLG Fail
        m.setTextColor(colors.orange)
        typeWriter(2, 7, "I watched this dude try to clutch an MLG water bucket", 0.03)
        typeWriter(2, 8, "and he missed the fucking ground.", 0.04)
        typeWriter(2, 9, "HE MISSED. THE GROUND.", 0.06)
        os.sleep(2)

        -- SCENE 5: Silverfish Death
        m.setTextColor(colors.lightBlue)
        typeWriter(2, 11, "Gets clapped by a single silverfish.", 0.03)
        typeWriter(2, 12, "Eats rotten flesh because he can't farm for shit.", 0.03)
        os.sleep(2)

        -- SCENE 6: PVP Tragedy
        blast(colors.black, colors.magenta)
        typeWriter(2, 2, "Don't even get me fucking started on the PVP.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Bro swings his sword like a blind toddler", 0.03)
        typeWriter(2, 5, "having a goddamn seizure.", 0.04)
        os.sleep(1.5)

        -- SCENE 7: Lava Pool
        m.setTextColor(colors.yellow)
        typeWriter(2, 7, "Mined for 4 straight hours yesterday...", 0.03)
        typeWriter(2, 8, "Found exactly three diamonds.", 0.04)
        typeWriter(2, 9, "And immediately fell backward into a lava pool.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 11, "I could hear him crying through Discord.", 0.05)
        os.sleep(2)

        -- SCENE 8: Redstone Fail
        blast(colors.black, colors.lightGray)
        typeWriter(2, 2, "Tried to build a basic 2x2 piston door.", 0.03)
        typeWriter(2, 3, "Followed a tutorial from 2013.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 5, "Ended up powering a TNT block he left in the wall.", 0.04)
        typeWriter(2, 6, "Blew up his entire fucking sorting system.", 0.04)
        os.sleep(2)

        -- SCENE 9: NPC Scam
        blast(colors.black, colors.brown)
        typeWriter(2, 2, "Bro gets finessed by the AI, too.", 0.03)
        os.sleep(1)
        m.setTextColor(colors.lime)
        typeWriter(2, 4, "Traded 64 emeralds for a fucking leather cap.", 0.04)
        typeWriter(2, 5, "A LEATHER CAP.", 0.06)
        os.sleep(2)

        -- SCENE 10: Nether Swarm
        blast(colors.black, colors.orange)
        typeWriter(2, 2, "Punches a Zombie Pigman because he", 0.03)
        typeWriter(2, 3, "'wanted to see what would happen'.", 0.03)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 5, "Got swarmed by 50 pissed off bacon boys.", 0.04)
        typeWriter(2, 6, "Lost his only enchanted pickaxe.", 0.04)
        os.sleep(2)

        -- SCENE 11: End Tragedy
        blast(colors.black, colors.purple)
        typeWriter(2, 2, "Bro finally gets his hands on an Elytra.", 0.03)
        typeWriter(2, 3, "Jumps off a fucking End City tower.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.white)
        typeWriter(2, 5, "Forgets to put the Elytra on.", 0.04)
        typeWriter(2, 6, "Plummets into the goddamn void like a sack of bricks.", 0.04)
        os.sleep(2)

        -- SCENE 12: Enchanting Table Trash
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
        os.sleep(3)

        -- SCENE 13: Bridging Fail
        blast(colors.black, colors.lightBlue)
        typeWriter(2, 2, "Thinks he's playing Bedwars or some shit.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Tries to speed-bridge across a Nether lava lake.", 0.03)
        typeWriter(2, 5, "Unshifts by accident.", 0.04)
        os.sleep(1.5)
        m.setTextColor(colors.orange)
        typeWriter(2, 7, "Just walks straight off the edge.", 0.04)
        typeWriter(2, 8, "Didn't even get shot by a Ghast.", 0.04)
        os.sleep(3)

        -- SCENE 14: Q-Drop Pickaxe
        blast(colors.black, colors.yellow)
        typeWriter(2, 2, "Crafts a brand new Diamond Pickaxe.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Standing next to a lava block.", 0.03)
        typeWriter(2, 5, "Tries to press 'W' to walk forward.", 0.04)
        os.sleep(1.5)
        m.setTextColor(colors.red)
        typeWriter(2, 7, "Presses 'Q' instead.", 0.04)
        typeWriter(2, 8, "Yeets the pickaxe directly into the magma.", 0.04)
        os.sleep(3)

        -- SCENE 15: Warden Encounter
        blast(colors.black, colors.cyan)
        typeWriter(2, 2, "Let's talk about the Ancient City.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Bro sneezes IRL, bumps his mouse, and wakes the Warden.", 0.03)
        os.sleep(1.5)
        m.setTextColor(colors.blue)
        typeWriter(2, 6, "Screams so loud his mom checks on him.", 0.04)
        typeWriter(2, 7, "Gets one-tapped through a fucking wall.", 0.04)
        os.sleep(3)

        -- SCENE 16: Phantom Menace
        blast(colors.black, colors.lightBlue)
        typeWriter(2, 2, "Refuses to sleep because 'beds are for noobs'.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Night 6 rolls around.", 0.04)
        m.setTextColor(colors.gray)
        typeWriter(2, 6, "Gets dive-bombed by 12 Phantoms.", 0.04)
        typeWriter(2, 7, "Knocked straight off a cliff.", 0.04)
        os.sleep(3)

        -- SCENE 17: Village Raid
        blast(colors.black, colors.red)
        typeWriter(2, 2, "Walks into his own breeder with Bad Omen.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Triggers a Raid.", 0.04)
        m.setTextColor(colors.white)
        typeWriter(2, 6, "Hides in a 1x1 dirt hole for three in-game days", 0.04)
        typeWriter(2, 7, "while the Vindicators slaughter his Mending villager.", 0.04)
        os.sleep(3)

        -- SCENE 18: Nether Portal Softlock
        blast(colors.black, colors.magenta)
        typeWriter(2, 2, "Builds a Nether Portal.", 0.03)
        typeWriter(2, 3, "Forgets to bring Flint and Steel inside.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.orange)
        typeWriter(2, 5, "Ghast shoots the portal. It breaks.", 0.04)
        typeWriter(2, 6, "Bro just jumps in the lava to respawn.", 0.04)
        os.sleep(3)

        -- SCENE 19: Kinetic Energy
        blast(colors.black, colors.white)
        typeWriter(2, 2, "Tries to use fireworks with the new Elytra.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Chunks don't load fast enough.", 0.04)
        m.setTextColor(colors.red)
        typeWriter(2, 6, "USER EXPERIENCED KINETIC ENERGY.", 0.05)
        typeWriter(2, 7, "Smeared across a mountain like cheap peanut butter.", 0.04)
        os.sleep(3)

        -- SCENE 20: Dog Tragedy
        blast(colors.black, colors.brown)
        typeWriter(2, 2, "Tames a wolf. Names him 'Good Boy'.", 0.03)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 4, "Immediately brings 'Good Boy' to a Creeper fight.", 0.04)
        typeWriter(2, 5, "Good Boy is now a crater.", 0.05)
        os.sleep(3)

        -- SCENE 21: Bastion Blunder 
        blast(colors.black, colors.gold)
        typeWriter(2, 2, "Let's talk about the Bastion Remnant.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Bro wears full gold armor so he's safe.", 0.03)
        typeWriter(2, 5, "Walks right up to a chest...", 0.04)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 7, "Opens it directly in front of a Piglin Brute.", 0.04)
        typeWriter(2, 8, "Gets two-tapped into another dimension.", 0.04)
        os.sleep(3)

        -- SCENE 22: The Ocean Monument 
        blast(colors.black, colors.cyan)
        typeWriter(2, 2, "Thinks he's ready for an Ocean Monument.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Drinks Water Breathing. Swims down.", 0.03)
        typeWriter(2, 5, "Gets hit with Mining Fatigue III.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.blue)
        typeWriter(2, 7, "Gets trapped behind some Prismarine blocks.", 0.04)
        typeWriter(2, 8, "Takes 4 real-life minutes to break one block.", 0.05)
        m.setTextColor(colors.red)
        typeWriter(2, 10, "Potion runs out. Drowns like a fucking rat.", 0.05)
        os.sleep(3)

        -- SCENE 23: Gravel Suffocation 
        blast(colors.black, colors.lightGray)
        typeWriter(2, 2, "Mines a single piece of coal.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "The ceiling updates.", 0.04)
        m.setTextColor(colors.gray)
        typeWriter(2, 6, "30 blocks of gravel fall directly on his head.", 0.04)
        typeWriter(2, 7, "Forgets he has a shovel in his hotbar.", 0.04)
        typeWriter(2, 8, "Just sits there and suffocates.", 0.05)
        os.sleep(3)

        -- SCENE 24: Riptide Roulette 
        blast(colors.black, colors.lightBlue)
        typeWriter(2, 2, "Enchants a Trident with Riptide III.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "It's raining. He shoots up 100 blocks into the sky.", 0.03)
        os.sleep(1.5)
        m.setTextColor(colors.yellow)
        typeWriter(2, 6, "The rain stops while he's at Y=200.", 0.05)
        m.setTextColor(colors.red)
        typeWriter(2, 8, "Plummets. Dies. Trident falls in a ravine.", 0.05)
        os.sleep(3)

        -- SCENE 25: The Potion Mixup 
        blast(colors.black, colors.magenta)
        typeWriter(2, 2, "Fighting a zombie horde, down to half a heart.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Pulls out what he THINKS is a Healing Potion.", 0.03)
        os.sleep(1)
        m.setTextColor(colors.green)
        typeWriter(2, 6, "It's Potion of Poison II.", 0.05)
        typeWriter(2, 7, "Literally suicides by his own goddamn brewing stand.", 0.05)
        os.sleep(3)

        -- SCENE 26: Enderman Staring Contest 
        blast(colors.black, colors.purple)
        typeWriter(2, 2, "Walking through a warped forest.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Makes direct eye contact with an Enderman.", 0.03)
        typeWriter(2, 5, "Tries to put a pumpkin on his head.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 7, "Accidentally puts on an Iron Helmet instead.", 0.04)
        typeWriter(2, 8, "Gets his spine folded like a lawn chair.", 0.05)
        os.sleep(3)

        -- SCENE 27: Elytra Repair Fail 
        blast(colors.black, colors.white)
        typeWriter(2, 2, "Elytra is at 1 durability.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Puts his god-tier Mending Elytra in a crafting grid", 0.04)
        typeWriter(2, 5, "with a broken one he found in an End Ship.", 0.05)
        os.sleep(1.5)
        m.setTextColor(colors.red)
        typeWriter(2, 7, "Strips all the enchantments.", 0.04)
        typeWriter(2, 8, "Literally flushed a Netherite block's worth of value.", 0.05)
        os.sleep(3)

        -- SCENE 28: Mining Obsidian
        blast(colors.black, colors.black)
        m.setTextColor(colors.purple)
        typeWriter(2, 2, "Bro wants to go to the Nether.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Finds a lava pool. Pours water on it.", 0.03)
        typeWriter(2, 5, "Starts mining the obsidian.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.white)
        typeWriter(2, 7, "He is using an Iron Pickaxe.", 0.04)
        typeWriter(2, 8, "Sits there holding left click for a full minute.", 0.04)
        m.setTextColor(colors.red)
        typeWriter(2, 10, "Block breaks. Drops nothing. Bro is confused.", 0.05)
        os.sleep(3)

        -- SCENE 29: Starving on Peaceful
        blast(colors.black, colors.green)
        typeWriter(2, 2, "Server gets set to Peaceful for an event.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Bro is sprinting everywhere.", 0.03)
        typeWriter(2, 5, "Hunger bar drops to zero.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.orange)
        typeWriter(2, 7, "Starts taking starvation damage.", 0.04)
        typeWriter(2, 8, "Eats a spider eye out of panic.", 0.04)
        m.setTextColor(colors.red)
        typeWriter(2, 10, "Dies to poison while on fucking Peaceful mode.", 0.05)
        os.sleep(3)

        -- SCENE 30: The Furnace Scam
        blast(colors.black, colors.lightGray)
        typeWriter(2, 2, "Puts 64 iron ore in a furnace.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Fuels it with wooden pickaxes and sticks.", 0.03)
        typeWriter(2, 5, "Runs out of fuel at 7 ingots.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.yellow)
        typeWriter(2, 7, "Leaves the furnace running while he goes to get coal.", 0.04)
        typeWriter(2, 8, "Someone walks by and steals all his iron.", 0.04)
        typeWriter(2, 9, "Bro blames Herobrine in the chat.", 0.05)
        os.sleep(3)

        -- SCENE 31: Diamond Hoe (NEW SHIT)
        blast(colors.black, colors.cyan)
        typeWriter(2, 2, "Finds his first 2 diamonds of the wipe.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Doesn't make a sword. Doesn't make an enchanting table.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.lightBlue)
        typeWriter(2, 6, "Crafts a Diamond Hoe.", 0.04)
        typeWriter(2, 7, "Gets the 'Serious Dedication' advancement.", 0.04)
        m.setTextColor(colors.red)
        typeWriter(2, 9, "Bro doesn't even have a fucking farm.", 0.05)
        typeWriter(2, 10, "Just running around with a useless blue stick.", 0.05)
        os.sleep(3)

        -- SCENE 32: Nether Roof Softlock (NEW SHIT)
        blast(colors.black, colors.red)
        typeWriter(2, 2, "Learns how to Ender Pearl through bedrock.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Does it perfectly. Gets on the Nether Roof.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.white)
        typeWriter(2, 6, "Checks his inventory.", 0.04)
        typeWriter(2, 7, "No obsidian. No flint and steel.", 0.04)
        m.setTextColor(colors.orange)
        typeWriter(2, 9, "Just wandering an endless flat gray void.", 0.05)
        typeWriter(2, 10, "Had to beg an admin in Discord to kill him.", 0.05)
        os.sleep(3)

        -- SCENE 33: Woodland Mansion (NEW SHIT)
        blast(colors.black, colors.brown)
        typeWriter(2, 2, "Walks 15,000 blocks to a Woodland Mansion.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Finds it. Gets spooked by a spider.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.yellow)
        typeWriter(2, 6, "Tries to burn the spider with Flint and Steel.", 0.04)
        typeWriter(2, 7, "Misses the spider. Lights the wool carpet.", 0.04)
        m.setTextColor(colors.red)
        typeWriter(2, 9, "The entire mansion burns to the ground.", 0.05)
        typeWriter(2, 10, "Loot gone. 15,000 blocks for absolute nothing.", 0.05)
        os.sleep(3)

        -- SCENE 34: The Zombie Sword (NEW SHIT)
        blast(colors.black, colors.green)
        typeWriter(2, 2, "Fighting a zombie in a cave.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Accidentally presses 'Q'.", 0.04)
        typeWriter(2, 5, "Drops his Sharpness V Netherite Sword.", 0.04)
        os.sleep(1)
        m.setTextColor(colors.magenta)
        typeWriter(2, 7, "The zombie picks it up.", 0.05)
        typeWriter(2, 8, "The zombie literally two-taps him.", 0.05)
        typeWriter(2, 9, "Gets spawn-camped by a mob he armed himself.", 0.05)
        os.sleep(3)

        -- SCENE 35: Creeper PTSD 
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

        -- SCENE 36: The Bed Bomb 
        blast(colors.black, colors.red)
        typeWriter(2, 2, "'Hey guys, I brought a bed to set my spawn in the Nether!'", 0.03)
        os.sleep(1.5)
        blast(colors.white, colors.black)
        os.sleep(0.1)
        blast(colors.orange, colors.white)
        center(math.floor(h/2), "INTENTIONAL GAME DESIGN, BITCH.")
        os.sleep(2)

        -- SCENE 37: Floating Trees 
        blast(colors.black, colors.green)
        typeWriter(2, 2, "The absolute worst crime of all.", 0.03)
        os.sleep(1)
        typeWriter(2, 4, "Bro leaves floating trees outside his base.", 0.03)
        os.sleep(1.5)
        m.setTextColor(colors.white)
        typeWriter(2, 6, "Who raised you? Are you an animal?", 0.05)
        typeWriter(2, 7, "Even creepers have more respect for the environment.", 0.05)
        os.sleep(3)

        -- SCENE 38: Chat Logs Vol 1
        blast(colors.black, colors.white)
        typeWriter(2, 2, "PULLING SERVER CHAT LOGS...", 0.03)
        os.sleep(1)
        m.setTextColor(colors.lightGray)
        typeWriter(2, 4, "[Server] Local_Idiot: 'guys plz help'", 0.03)
        typeWriter(2, 5, "[Server] Local_Idiot: 'i fell in a hole and cant get out'", 0.03)
        os.sleep(1)
        m.setTextColor(colors.cyan)
        typeWriter(2, 7, "[Server] Admin: 'literally just mine up bro'", 0.04)
        os.sleep(2)

        -- SCENE 39: Chat Logs Vol 2
        blast(colors.black, colors.white)
        typeWriter(2, 2, "MORE LOGS...", 0.03)
        os.sleep(1)
        m.setTextColor(colors.lightGray)
        typeWriter(2, 4, "[Server] Local_Idiot: 'how do i un-tame a cat'", 0.03)
        typeWriter(2, 5, "[Server] Local_Idiot: 'it keeps sitting on my chest'", 0.03)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 7, "[Server] Local_Idiot: 'my iron golem is mad at me now'", 0.03)
        m.setTextColor(colors.yellow)
        typeWriter(2, 9, "Local_Idiot was pummeled by Iron Golem", 0.04)
        os.sleep(3)

        -- SCENE 40: Chat Logs Vol 3 (NEW SHIT)
        blast(colors.black, colors.white)
        typeWriter(2, 2, "EVEN MORE LOGS (IT NEVER ENDS)...", 0.03)
        os.sleep(1)
        m.setTextColor(colors.lightGray)
        typeWriter(2, 4, "[Server] Local_Idiot: 'anyone have spare dirt'", 0.03)
        typeWriter(2, 5, "[Server] Local_Idiot: 'a creeper blew up my chests'", 0.03)
        os.sleep(1)
        m.setTextColor(colors.cyan)
        typeWriter(2, 7, "[Server] Admin: 'how do you not have dirt'", 0.04)
        os.sleep(1)
        m.setTextColor(colors.lightGray)
        typeWriter(2, 9, "[Server] Local_Idiot: 'I threw it in lava to save space'", 0.03)
        m.setTextColor(colors.red)
        typeWriter(2, 11, "[Server] Admin: 'I am going to ban you'", 0.04)
        os.sleep(4)

        -- SCENE 41: Matrix Hacker Meltdown 
        blast(colors.black, colors.lime)
        for i = 1, 500 do
            local rx = math.random(1, w)
            local ry = math.random(1, h)
            m.setCursorPos(rx, ry)
            local chars = {"0", "1", "L", "F", "NOOB", "TRASH", "LMAO", "RIP", "DUMB", "IDIOT", "CLOWN"}
            m.write(chars[math.random(1, #chars)])
            os.sleep(0.001)
        end
        os.sleep(0.5)

        -- SCENE 42: The Stats 
        blast(colors.blue, colors.white)
        center(2, "--- FINAL PLAYER STATS DIGEST ---")
        os.sleep(1)
        m.setTextColor(colors.yellow)
        typeWriter(2, 4, "Blocks Placed: 14,203", 0.02)
        typeWriter(2, 5, "Blocks Broken By Accident: 14,202", 0.02)
        typeWriter(2, 6, "Times Drowned in 2-Deep Water: 24", 0.02)
        typeWriter(2, 7, "Times Scammed By Villagers: 87", 0.02)
        typeWriter(2, 8, "Pets Accidentally Murdered: 11", 0.02)
        os.sleep(1)
        typeWriter(2, 10, "Hours Played: 1,250", 0.02)
        typeWriter(2, 11, "Bitches Acquired: -1 (You owe someone)", 0.04)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 13, "Skill Level: NON-EXISTENT", 0.03)
        typeWriter(2, 14, "Brain Smoothness: QUANTUM LEVEL", 0.03)
        os.sleep(4)

        -- SCENE 43: Fake System Format 
        blast(colors.blue, colors.white)
        center(math.floor(h/2) - 2, "WINDOWS HAS DETECTED A FATAL SKILL ISSUE.")
        center(math.floor(h/2), "FORMATTING C: DRIVE TO SAVE HUMANITY...")
        os.sleep(2)
        
        local formatY = math.floor(h/2) + 2
        m.setCursorPos(10, formatY)
        m.write("[")
        m.setCursorPos(w - 9, formatY)
        m.write("]")
        
        for i = 11, w - 10 do
            m.setCursorPos(i, formatY)
            m.setBackgroundColor(colors.red)
            m.write(" ")
            os.sleep(0.02)
        end
        m.setBackgroundColor(colors.black)
        m.setTextColor(colors.yellow)
        center(math.floor(h/2) + 4, "JUST KIDDING, I CAN'T DO THAT.")
        center(math.floor(h/2) + 5, "BUT YOU STILL SUCK AT MINECRAFT.")
        os.sleep(3)

        -- SCENE 44: Unhinged Bouncing Freakout 
        local c_list = {colors.red, colors.yellow, colors.lime, colors.magenta, colors.cyan, colors.orange, colors.pink}
        for i = 1, 250 do
            blast(colors.black, c_list[math.random(1, #c_list)])
            local phrase = {"YOU SUCK", "GET GOOD", "TOUCH GRASS", "ZERO BITCHES", "UNINSTALL", "F-TIER GAMER", "CRY MORE", "L + RATIO", "SMOOTH BRAIN", "LITERAL TRASH", "DONKEY BRAINS"}
            local text = phrase[math.random(1, #phrase)]
            m.setCursorPos(math.random(1, w - string.len(text)), math.random(1, h))
            m.write(text)
            os.sleep(0.02)
        end

        -- SCENE 45: DVD Logo Bounce of Shame 
        blast(colors.black, colors.white)
        local bx, by = 1, 1
        local dx, dy = 1, 1
        local bounceText = "DOGSHIT"
        for i = 1, 350 do
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
            os.sleep(0.02)
        end

        -- SCENE 46: ASCII Art - Giant Gravestone (NEW SHIT)
        blast(colors.black, colors.lightGray)
        center(2, "IN MEMORY OF YOUR MINECRAFT CAREER:")
        os.sleep(1.5)
        m.setTextColor(colors.white)
        center(4, "        _______        ")
        center(5, "       /       \\       ")
        center(6, "      /         \\      ")
        center(7, "     |   R.I.P   |     ")
        center(8, "     |           |     ")
        center(9, "     |   BOZO    |     ")
        center(10,"     |           |     ")
        center(11,"     |  DIED TO  |     ")
        center(12,"     | GRAVITY & |     ")
        center(13,"     | STUPIDITY |     ")
        center(14,"   __|___________|__   ")
        m.setTextColor(colors.green)
        center(16, "REST IN PISS.")
        os.sleep(4)

        -- SCENE 47: Giant ASCII Clown Face 
        blast(colors.black, colors.red)
        center(2, "LOOK IN THE MIRROR, BRO:")
        os.sleep(1.5)
        m.setTextColor(colors.white)
        center(4, "      .       .      ")
        center(5, "    /   \\   /   \\    ")
        center(6, "   |  O  | |  O  |   ")
        center(7, "    \\   /   \\   /    ")
        center(8, "      ---   ---      ")
        m.setTextColor(colors.red)
        center(9, "        ( O )        ")
        m.setTextColor(colors.white)
        center(11,"  \\               /  ")
        center(12,"   \\_____________/   ")
        center(13,"    |   V V V   |    ")
        center(14,"    |___________|    ")
        m.setTextColor(colors.red)
        center(16, "YOU ARE THE CIRCUS.")
        os.sleep(4)

        -- SCENE 48: Giant L ASCII
        blast(colors.black, colors.red)
        center(2, "PLEASE HOLD THIS FOR ME:")
        os.sleep(1.5)
        m.setTextColor(colors.yellow)
        center(4, "  ██       ")
        center(5, "  ██       ")
        center(6, "  ██       ")
        center(7, "  ██       ")
        center(8, "  ██       ")
        center(9, "  ██       ")
        center(10,"  ████████ ")
        center(11,"  ████████ ")
        os.sleep(4)

        -- SCENE 49: ASCII Art - The Trash Can 
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

        -- SCENE 50: ASCII Art - The Literal Poop (NEW SHIT)
        blast(colors.black, colors.brown)
        center(2, "THIS IS YOUR GAMEPLAY:")
        os.sleep(1.5)
        center(5, "      (   )      ")
        center(6, "     (      )    ")
        center(7, "   (          )  ")
        center(8, "  (____________) ")
        m.setTextColor(colors.white)
        center(10, "A STEAMING PILE.")
        os.sleep(4)

        -- SCENE 51: The Giant Middle Finger 
        blast(colors.black, colors.white)
        center(2, "FINAL MESSAGE FROM THE SERVER:")
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

        -- SCENE 52: Defragmenting Remaining Brain Cells 
        blast(colors.black, colors.lime)
        typeWriter(2, 2, "ATTEMPTING TO LOCATE USER'S BRAIN CELLS...", 0.03)
        os.sleep(1.5)
        typeWriter(2, 4, "SCANNING SECTOR 1... [EMPTY]", 0.02)
        typeWriter(2, 5, "SCANNING SECTOR 2... [EMPTY]", 0.02)
        typeWriter(2, 6, "SCANNING SECTOR 3... [404 NOT FOUND]", 0.02)
        os.sleep(1)
        m.setTextColor(colors.red)
        typeWriter(2, 8, "CRITICAL ALERT: YOU ARE CLINICALLY BRAINDEAD.", 0.04)
        os.sleep(3)

        -- SCENE 53: The Progress Bar of Shame
        blast(colors.black, colors.white)
        center(math.floor(h/2) - 2, "UPLOADING YOUR EMBARRASSMENT...")
        
        local barY = math.floor(h/2)
        m.setCursorPos(10, barY)
        m.write("[")
        m.setCursorPos(w - 9, barY)
        m.write("]")
        
        for i = 11, w - 10 do
            m.setCursorPos(i, barY)
            m.setBackgroundColor(colors.green)
            m.write(" ")
            os.sleep(0.03)
        end
        
        m.setBackgroundColor(colors.black)
        m.setTextColor(colors.lime)
        center(math.floor(h/2) + 2, "UPLOAD COMPLETE. EVERYONE KNOWS YOU SUCK.")
        os.sleep(3)

        -- SCENE 54: The Epileptic Finale 
        for i = 1, 150 do
            blast(colors.red, colors.white)
            center(math.floor(h/2) - 2, "ABSOLUTE")
            center(math.floor(h/2), "FUCKING")
            center(math.floor(h/2) + 2, "CLOWN")
            os.sleep(0.01)
            
            blast(colors.white, colors.red)
            center(math.floor(h/2) - 2, "ABSOLUTE")
            center(math.floor(h/2), "FUCKING")
            center(math.floor(h/2) + 2, "CLOWN")
            os.sleep(0.01)
            
            blast(colors.black, colors.yellow)
            center(math.floor(h/2) - 2, "ABSOLUTE")
            center(math.floor(h/2), "FUCKING")
            center(math.floor(h/2) + 2, "CLOWN")
            os.sleep(0.01)

            blast(colors.lime, colors.black)
            center(math.floor(h/2) - 2, "ABSOLUTE")
            center(math.floor(h/2), "FUCKING")
            center(math.floor(h/2) + 2, "CLOWN")
            os.sleep(0.01)
        end
        
        blast(colors.black, colors.red)
        center(math.floor(h/2), "REBOOTING THIS GOD AWFUL SHITSHOW...")
        os.sleep(5)
    end
end

-- ==========================================
-- RUN BOTH LOOPS AT THE SAME FUCKING TIME
-- ==========================================
parallel.waitForAny(visualLoop, audioLoop)
