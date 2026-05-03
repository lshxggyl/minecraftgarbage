-- ==========================================
-- XYNIA'S WEAPONIZED BRAINROT ENGINE
-- "RESTRAINING ORDER FILED BY MONITOR" EDITION
-- THIS SCRIPT VOTED MOST UNHINGED 2026
-- ==========================================
 
local m = peripheral.find("monitor")
if not m then
    print("NO MONITOR. CANNOT COMMIT ATROCITIES.")
    print("Plug it in, you absolute walnut.")
    return
end
 
local speakers = {peripheral.find("speaker")}
if #speakers == 0 then print("No speakers found. Coward rig. Visual suffering only.") end
 
m.setTextScale(1)
term.redirect(m)
local w, h = m.getSize()
 
math.randomseed(os.time())
 
-- ==========================================
-- THE DICTIONARY OF ETERNAL DISRESPECT
-- ==========================================
local adj = {
    "DOGSHIT","BRAINDEAD","SMOOTH-BRAINED","PATHETIC","USELESS",
    "GARBAGE","TRASH","F-TIER","ATROCIOUS","REPULSIVE","CLOWN-SHOES",
    "NEGATIVE-IQ","COPE-ADDICTED","MALDING","CRINGE","ABYSMAL",
    "RADIOACTIVE","UNWASHED","FERAL","TERMINALLY-ONLINE","FATHERLESS",
    "SKILL-DEFICIENT","CANCEROUS","PUDDLE-DEEP","ABSOLUTE","LITERAL",
    "GALAXY-BRAINED","PRE-NEOLITHIC","NEURONLESS","WIFI-SHARING",
    "DIRT-TIER","WOODEN-SWORD-HAVING","BEDROCK-BRAINED","TUTORIAL-FAILING",
    "COMPASS-CONFUSED","ZERO-KILL","SPAWN-TRAPPED","KEYBIND-FORGETTING",
    "LORE-ILLITERATE","SPRINT-TOGGLING","CHEST-PUNCHING","CORPSE-LOSING",
    "GRAVEL-TRUSTING","LAVA-ADJACENT","FUNDAMENTALLY-COOKED",
    "COSMICALLY-OFFLINE","STRUCTURALLY-WRONG","ANATOMICALLY-CLOWNED",
    "IRREVERSIBLY-NPC","EMPIRICALLY-BAD","STATISTICALLY-HOPELESS",
    "CERTIFIED-BUFFOON","PROFESSIONALLY-LOST","CLINICALLY-UNAWARE",
    "CHRONICALLY-DYING","DIRT-HUFFING","TORCH-SKIPPING","BED-IGNORING",
    "LAVA-TRUSTING","VOID-ADJACENT","HOTBAR-FORGETTING","RECIPE-ILLITERATE",
    "HUNGER-DENYING","SWORD-SHEATHING","ARMOR-OPTIONAL","HELMET-ALLERGIC",
    "SHIELD-FORGETTING","FURNACE-BAFFLED","COMPASS-WORSHIPPING",
    "MAP-ILLITERATE","CHUNK-BLIND","BIOME-LOST","CAVE-FEARING",
    "GRAVITY-SURPRISED","SUFFOCATION-PRONE","DROWNING-PRONE",
    "CACTUS-ADJACENT","MAGMA-STEPPING","PISTON-FACING","NOTCH-FORSAKEN",
    "MOJANG-ABANDONED","TERMINALLY-COOKED","GALAXY-ROTTED","WIFI-DEFICIENT",
    "UNIRONICALLY-BAD","DEMONSTRABLY-COOKED","MEASURABLY-DOGSHIT",
    "PEER-REVIEWED-TRASH","DOUBLE-BLIND-AWFUL","PROVABLY-BOTTOM-TIER",
    "ACADEMICALLY-HOPELESS","PHILOSOPHICALLY-LOST","SPIRITUALLY-GRIEFED",
    "EXISTENTIALLY-NOOB","HISTORICALLY-BAD","MATHEMATICALLY-COOKED",
    "THERMODYNAMICALLY-COOKED","GEOLOGICALLY-CONFUSED","ASTRONOMICALLY-BAD",
    "BIOLOGICALLY-NPC","CHEMICALLY-UNBALANCED","PHYSICALLY-CHALLENGED-BY-GRAVITY"
}
 
local noun = {
    "GAMER","LAVA DIVER","CREEPER SNACK","DIRT HUT ARCHITECT",
    "GRAVEL EATER","NPC","BOT","VILLAGE IDIOT","SILVERFISH VICTIM",
    "VOID HOPPER","WARDEN FODDER","GHAST TARGET","WALKING CHEST",
    "DISAPPOINTMENT","ERROR 404","BASEMENT DWELLER","KEYBOARD TURNER",
    "LOOT PINATA","CLOWN","CREEPER MAGNET","SKELETON ARROW COLLECTOR",
    "TNT ACCIDENT SURVIVOR","ZOMBIE FOOD","SAND PHILOSOPHER",
    "NETHERITE DREAMER","WOODCUTTER","DOOR FORGETTER","TORCH SKIPPER",
    "BED IGNORER","COMPASS HAVER","FALL DAMAGE RESEARCHER",
    "LAVA BUCKET REGRET","PORTAL TOURIST","STRONGHOLD TOURIST",
    "PHANTOM TARGET","SPIDER JOCKEY VICTIM","PILLAGER PINATA",
    "DEEP DARK TOURIST","SCULK ACTIVATOR","CRAFTING TABLE CONFUSER",
    "FURNACE STARER","ANVIL VICTIM","PISTON CASUALTY","HOGLIN HUGGER",
    "STRIDER RIDER (FELL OFF)","ZOMBIE PIGLIN ATTACKER",
    "ENDERMAN EYE CONTACT MAKER","ELYTRA CRASHER","BEE PUNCHER",
    "AXOLOTL DROWNER","GOAT VICTIM","COPPER COLLECTOR (NO PLAN)",
    "AMETHYST TOURIST","BUNDLE HAVER (CONFUSED)","CANDLE FIRE VICTIM",
    "DRIPLEAF DROPPER","POWDER SNOW WALKER","FROGLIGHT HOARDER",
    "MANGROVE SWAMP WANDERER","ANCIENT CITY TOURIST (DEAD)",
    "TRIAL CHAMBER CASUALTY","BREEZE WIND CHARGE VICTIM",
    "COPPER BULB CONFUSER","WOLF ARMOR WASTER","ARMADILLO LURER",
    "BOGGED ARROW COLLECTOR","MACE DROPPER","HEAVY CORE LOSER",
    "VAULT KEY FUMBLER","OMINOUS BOTTLE DRINKER (ON ACCIDENT)"
}
 
local fake_history = {
    "how to un-tame a wolf","why are villagers running from me",
    "how to get sharpness 5 on dirt","minecraft unban appeal template",
    "how to convince admins i wasnt xraying",
    "free minecoins generator 2026 working guaranteed",
    "why did my iron golem kill me","how to build a roof minecraft",
    "is it safe to drink poison in minecraft",
    "how to undo creeper explosion","where did my diamonds go",
    "how to make friends in smp","what does the crafting table do",
    "how do i place blocks","is herobrine real 2026",
    "how to breathe underwater without helmet","why does lava hurt",
    "how to win minecraft","minecraft final boss",
    "does dirt grow diamonds if you water it","how to delete the void",
    "what happens if creeper catches me","how to befriend warden",
    "how to undo dying in minecraft","is iron better than wood",
    "can you eat raw chicken minecraft","what is a nether",
    "why is skeleton specifically targeting me",
    "how to report a creeper to admin","refund policy minecraft death",
    "why does everything keep killing me",
    "minecraft tips for absolute beginners asking for myself",
    "how long to get good at minecraft","is 600 deaths normal",
    "how to make netherite without mining",
    "can i tame a creeper if im nice","what does shift do",
    "how to sprint","is f3 cheating","what are coordinates for",
    "why do i keep falling in holes","minecraft is rigged proof",
    "can i sue a skeleton for damages",
    "how to get admin on any server 2026",
    "my base is gone what do i do",
    "how to fake screenshot for unban appeal",
    "someone took my stuff what are my rights",
    "how to cry less when dying in minecraft",
    "how do speedrunners do it so fast asking for me",
    "how to apologize to a village after burning it",
    "am i bad at minecraft quiz","minecraft therapy near me",
    "how to get diamonds from the sky",
    "what does enchanting do exactly","why wont mobs stop",
    "what is a shield for","can you sleep during the day",
    "how far down is bedrock","what is below bedrock",
    "what happens if you mine bedrock with hands",
    "why is the sky red in the nether",
    "what is the nether for","do i have to go to the nether",
    "how to avoid the nether","nether alternatives 2026",
    "can i finish minecraft without going to the nether",
    "whats the point of the end","do i have to fight the dragon",
    "what if i just dont go to the end",
    "minecraft for people who are bad at minecraft",
}
 
local fake_dms = {
    "Bro plz give my stuff back","I swear it was lag",
    "Can u light up my cave I'm scared",
    "How do you craft a chest?",
    "Admin teleport me I'm stuck in a hole",
    "I lost my iron pick please",
    "Stop killing me I have nothing",
    "Who took my 14 dirt blocks",
    "Why did you put lava in my house",
    "I only had 3hp that's not fair",
    "I've been in this cave for 40 minutes",
    "The zombies keep finding me somehow",
    "I think someone follows me in singleplayer",
    "My dog died please come to the funeral",
    "I named my pig Gerald now I can't eat pork",
    "The creeper was provoked you have to believe me",
    "How many planks does it take to make a house",
    "Ban the skeleton I have evidence",
    "Is it normal to cry at a minecraft death",
    "My unban appeal got denied AGAIN (4th time)",
    "Can you vouch for me on the appeal",
    "I had full iron and lost to a zombie",
    "The warden heard my breathing through my mic",
    "I built a house but forgot windows now its dark",
    "Someone griefed my dirt hut. I'm devastated.",
    "If I give you 2 wheat will you help",
    "Why does everyone have netherite and I have wood",
    "This is my 6th account this month",
    "Show me how to make a sword please",
    "I tried to ride a creeper it didn't work",
    "Is pvp supposed to be this one-sided",
    "At what point does it stop being a skill issue",
    "I read a wiki and it made it worse",
    "I joined a faction and immediately got kicked",
    "Do you think I'll ever get good",
    "I don't wanna quit I just wanna be less bad",
    "My mom says go to bed but we're mid-raid",
    "Do you ever feel like minecraft doesn't want you",
    "The server said I was 'clearly not ready'",
    "How do you not die so much",
    "What's the trick to not falling in lava",
    "I feel like the game is watching me specifically",
    "The ender dragon looked at me weird",
    "I accidentally punched the admin. How do I explain.",
    "I have 400 dirt and no plan",
    "Is there a mode where mobs are nicer",
    "What does the ender eye do I threw all mine",
    "I crafted a hoe by accident. Is it useful.",
}
 
local conspiracy_theories = {
    "Your base coords have been sold to 3 rival factions",
    "The warden is not hostile. It specifically hates YOU.",
    "Your ping is high because you are bad, not the server.",
    "Herobrine is real and he is embarrassed for you.",
    "The pillagers have your coordinates and are reconsidering their choices.",
    "Your iron golem filed a restraining order.",
    "The villagers gossip about you. Constantly.",
    "The ender dragon recognized you and sighed audibly.",
    "Your wolf died on purpose to escape.",
    "The skeleton was aiming at someone else but changed its mind.",
    "Your farm is staging a revolt. It has demands.",
    "The nether portal has been rerouted to spite you.",
    "Dream watched your gameplay. He cried.",
    "The endermen hold annual meetings. You are the main agenda item.",
    "The creeper has a family. They know where you respawn.",
    "The server logs have a folder labeled 'This Guy Again'.",
    "Your chunks load slower because even the server is tired.",
    "The respawn screen is your most visited location.",
    "Notch originally coded a 'this player is struggling' alert. It fires constantly for you.",
    "The stronghold was never in that direction.",
    "You are the reason the server added the grief-detection plugin.",
    "The admin has a folder of screenshots labeled 'Exhibit A through AAAA'.",
    "The wandering trader actively routes around your coordinates.",
    "Your crafting recipe history has been submitted to a medical journal.",
    "The bats are not neutral. They are observing.",
    "The ancient city you woke the warden in had not been disturbed in 8000 years. You did that.",
    "The ender dragon has beaten more players than you have beaten mobs.",
    "The gravel you landed on was load-bearing.",
    "Your skin was reported to Mojang by a passing enderman.",
    "The blaze you are fighting used to be afraid of you. It got over it fast.",
    "The server's TPS drops every time you open your inventory.",
    "The iron golem you killed was the village's therapist.",
    "That lava you fell in was the same lava. It found you again.",
    "Your XP bar goes down when you make bad decisions. That's why it's always empty.",
}
 
local fake_achievements = {
    {n="How Did We Get Here?",       d="Get every status effect. In a dirt hut. You had no plan."},
    {n="Taking Inventory",            d="Open your inventory. That is it. That is the bar you cleared."},
    {n="Who Is Cutting Onions?",      d="Lose your base to a creeper. 9th time this month."},
    {n="Cover Me in Debris",          d="Lose full netherite in lava. In the overworld. Somehow."},
    {n="Adventure Time",              d="Touch grass. You immediately wanted to go back inside."},
    {n="Serious Dedication",          d="Craft a hoe. Your magnum opus. Your tombstone reads 'He Had a Hoe'."},
    {n="Is It a Bird?",               d="Die to a phantom you watched approach for 90 full seconds."},
    {n="The End?",                    d="Fall into the void trying to reach the end portal. Twice."},
    {n="Free the End",                d="Get one-shot by the ender dragon before it completes a lap."},
    {n="Arbalistic",                  d="Miss every crossbow shot at a mob that is not moving. Art."},
    {n="With Our Powers Combined!",   d="Log in mid-raid. You caused it. Nobody told you. Yet."},
    {n="Star Trader",                 d="Trade 16 emeralds for a single piece of dirt. No regrets."},
    {n="Two by Two",                  d="Kill both animals before getting in the boat you built wrong."},
    {n="Sound of Music",              d="Play a jukebox. Get banned from the music district immediately."},
    {n="A Throwaway Joke",            d="Throw your only trident. Into lava. Watch it happen in slow motion."},
    {n="Sniper Duel",                 d="Get headshot by a skeleton from render distance away. Respect."},
    {n="Spooky Scary Skeleton",       d="Get killed by a skeleton. Get killed by its arrow three more times on the way back."},
    {n="The Parrots and the Bats",    d="Dye a parrot with a cookie. The funeral was held in your dirt hut."},
    {n="Getting Wood",                d="Punch a tree. Congratulations. You did the first step. Nothing else though."},
    {n="We Need to Go Deeper",        d="Enter the nether. Die immediately. Return to the overworld confused."},
    {n="Hidden in the Depths",        d="Find a deep dark city. Wake the warden. Die. Tell no one."},
    {n="You've Got a Friend in Me",   d="Tame a wolf. The wolf died. You grieved longer than any human relationship."},
    {n="When Pigs Fly",               d="Ride a pig off a cliff while holding a carrot. It was your idea."},
    {n="Subspace Bubble",             d="Get lost in the nether. Get more lost trying to get unlost. Stay lost."},
}
 
local fake_errors = {
    "KERNEL_SKILL_ISSUE","BRAINCELL_PAGE_FAULT",
    "IRQL_NOT_LESS_OR_EQUAL_TO_SKILL","CRITICAL_COPE_FAILURE",
    "DRIVER_OVERRAN_STACK_OVERFLOW_OF_BAD_PLAYS",
    "SYSTEM_THREAD_EXCEPTION_NOT_HANDLED_LIKE_A_NOOB",
    "MEMORY_CORRUPTION_BY_STUPIDITY","BAD_POOL_CALLER_BAD_AT_GAME",
    "INACCESSIBLE_BOOT_DEVICE_INACCESSIBLE_SKILL",
    "DPC_WATCHDOG_VIOLATION_OF_DECENCY",
    "PAGE_FAULT_IN_NONPAGED_SKILL_AREA",
    "CLOCK_WATCHDOG_TIMEOUT_OF_PATIENCE",
    "MANUALLY_INITIATED_SKILL_ISSUE",
    "WHEA_UNCORRECTABLE_PLAY","VIDEO_DXGKRNL_FATAL_ERROR_IN_JUDGMENT",
    "KMODE_EXCEPTION_NOT_HANDLED_EVER",
    "APC_INDEX_MISMATCH_WITH_REALITY",
    "CRITICAL_STRUCTURE_CORRUPTION_OF_GAMEPLAY",
    "SECURE_KERNEL_ERROR_IN_BASIC_FUNCTION",
    "HYPERVISOR_ERROR_IN_DECISION_MAKING",
    "ATTEMPTED_WRITE_TO_READONLY_SKILL",
    "REFERENCE_BY_POINTER_TO_BRAIN_NOT_FOUND",
    "EMPTY_THREAD_REAPER_OBJECT_WHERE_SKILL_SHOULD_BE",
    "UNEXPECTED_STORE_EXCEPTION_WHILE_DYING_AGAIN",
}
 
local fake_processes = {
    "minecraft.exe","hopium_pump.dll","skill_issue_handler.sys",
    "cope.bat","delete_skills.exe","refund_request.exe",
    "dirt_palace_renderer.dll","keyboard_gamer.exe","lava_walk.bat",
    "void_tourism.sys","XRay_totally_not.dll","admin_please.exe",
    "unban_appeal_v9.docx","tutorial_skipped.dll",
    "gravel_physics_denier.sys","bed_ignorer.bat","torch_skipper.exe",
    "hotbar_roulette.sys","sprint_toggler.bat",
    "fall_damage_surprise.exe","enchant_table_starer.dll",
    "furnace_watcher.sys","creeper_negotiator.exe",
    "skeleton_diplomat.dll","warden_friend_attempt.bat",
    "lava_trust_issues.exe","diamonds_where.sys",
    "xp_where.dll","respawn_screen_cached.exe",
    "inventory_chaos_manager.sys","chest_label_avoider.dll"
}
 
local ascii_skull = {
    "   ___   ","  /   \\  "," | o o | ",
    " |  ^  | "," | --- | ","  \\___/  "
}
 
local colors_list = {
    colors.red,colors.orange,colors.yellow,colors.lime,
    colors.lightBlue,colors.cyan,colors.purple,colors.magenta,
    colors.pink,colors.white
}
 
-- ==========================================
-- HELPERS
-- ==========================================
local function rnd(t) return t[math.random(1,#t)] end
 
local function center(y, text)
    local x = math.max(1, math.floor((w - #text) / 2) + 1)
    m.setCursorPos(x, math.max(1,y))
    m.write(text:sub(1, w))
end
 
local function blast(bg, fg)
    m.setBackgroundColor(bg or colors.black)
    m.setTextColor(fg or colors.white)
    m.clear()
end
 
local function genInsult()
    return rnd(adj).." "..rnd(noun)
end
 
local function genDoubleInsult()
    return rnd(adj)..", "..rnd(adj).." "..rnd(noun)
end
 
local function genTripleInsult()
    return "CERTIFIED "..rnd(adj)..", "..rnd(adj).." "..rnd(noun)
end
 
local function tw(x, y, text, speed)
    m.setCursorPos(math.max(1,x), math.max(1,y))
    for i = 1, #text do
        m.write(text:sub(i,i))
        os.sleep(speed or 0.02)
    end
end
 
local function fillRow(y, char, fg, bg)
    m.setBackgroundColor(bg or colors.black)
    m.setTextColor(fg or colors.white)
    m.setCursorPos(1, math.max(1,y))
    m.write(string.rep(char or "-", w))
end
 
local function box(x1,y1,x2,y2,fg)
    m.setTextColor(fg or colors.white)
    for row=y1,y2 do
        for col=x1,x2 do
            m.setCursorPos(col,row)
            if row==y1 or row==y2 then m.write("-")
            elseif col==x1 or col==x2 then m.write("|")
            else m.write(" ") end
        end
    end
end
 
local function progressBar(y, label, speed)
    m.setTextColor(colors.white)
    local lbl = (label:sub(1,20))
    tw(2, y, lbl.." [", speed)
    local barStart = 2 + #lbl + 2
    m.setTextColor(colors.lime)
    local barW = math.min(20, w - barStart - 8)
    for i=1,barW do
        m.setCursorPos(barStart+i-1, y)
        m.write("=")
        os.sleep(speed or 0.03)
    end
    m.setTextColor(colors.white)
    m.write("] ")
    m.setTextColor(colors.red)
    m.write("FAILED")
end
 
local function scrollLine(y, text, fg)
    m.setTextColor(fg or colors.white)
    for startX = w, 1-#text, -2 do
        m.setCursorPos(1, y)
        m.write(string.rep(" ", w))
        local dx = math.max(1, startX)
        local str = text
        if startX < 1 then str = str:sub(2-startX) end
        m.setCursorPos(dx, y)
        m.write(str:sub(1, w-dx+1))
        os.sleep(0.012)
    end
end
 
-- ==========================================
-- AUDIO ENGINE
-- ==========================================
local function audioLoop()
    if #speakers == 0 then while true do os.sleep(1) end end
    local inst = {
        "cow_bell","bit","banjo","didgeridoo","pling","flute",
        "bell","bass","guitar","harp","iron_xylophone","xylophone",
        "chime","basedrum","snare","hat","bass"
    }
    while true do
        for _, s in pairs(speakers) do
            local pitch = math.random(0,24)
            local vol = math.random(8,20)/10
            for i=1, math.random(1,8) do
                s.playNote(rnd(inst), vol, math.max(0,math.min(24,pitch+math.random(-3,3))))
                os.sleep(math.random(1,6)/100)
            end
        end
        os.sleep(math.random(1,5)/100)
    end
end
 
-- ==========================================
-- PHASE: BSOD
-- ==========================================
local function phase_bsod()
    blast(colors.blue, colors.white)
    local mid = math.floor(h/2)
    center(mid-4, ":(")
    os.sleep(0.3)
    center(mid-2, "Your PC encountered YOU and gave up.")
    center(mid-1, "Collecting error info (all of it is your fault).")
    os.sleep(0.4)
    for pct=0,100,math.random(2,8) do
        center(mid+1, pct.."% complete    ")
        os.sleep(0.04)
    end
    center(mid+1, "100% complete")
    os.sleep(0.4)
    m.setTextColor(colors.lightGray)
    center(mid+3, "Stop code: "..rnd(fake_errors))
    center(mid+4, "Offending process: "..rnd(fake_processes))
    center(mid+5, "For more info, touch grass. (You won't.)")
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: FAKE DOX
-- ==========================================
local function phase_dox()
    blast(colors.black, colors.green)
    tw(2,2,"[XYNIA NET INTRUSION v6.66]",0.01)
    os.sleep(0.3)
    tw(2,4,"FETCHING VICTIM DATA...",0.01)
    os.sleep(0.4)
    tw(2,5,"IPv4........: 192.168."..math.random(0,5).."."..math.random(2,254),0.01)
    tw(2,6,"IPv6........: fe80::dead:beef:"..math.random(1000,9999)..":cafe",0.01)
    tw(2,7,"MAC.........: 00:1A:2B:3C:4D:"..math.random(10,99),0.01)
    tw(2,8,"HOSTNAME....: SKILL-ISSUE-PC-"..math.random(1000,9999),0.01)
    tw(2,9,"BASE COORDS.: X:"..math.random(-9999,9999).." Y:11 Z:"..math.random(-9999,9999),0.01)
    tw(2,10,"STASH.......: X:"..math.random(-9999,9999).." Y:7 Z:"..math.random(-9999,9999),0.01)
    tw(2,11,"PORTAL......: X:"..math.random(-9999,9999).." Z:"..math.random(-9999,9999),0.01)
    tw(2,12,"DEATHS TODAY: "..math.random(8,99),0.01)
    tw(2,13,"KILL/DEATH..: 0."..math.random(0,9).."/"..math.random(100,999),0.01)
    os.sleep(0.5)
    m.setTextColor(colors.red)
    tw(2,15,">> POSTING TO #public-announcements ...",0.02)
    os.sleep(0.4)
    tw(2,16,">> FORWARDING TO "..math.random(3,8).." RIVAL FACTIONS ...",0.02)
    os.sleep(0.4)
    tw(2,17,">> SUBMITTING TO r/minecraftfails ...",0.02)
    os.sleep(0.4)
    tw(2,18,">> EMAILING SERVER ADMIN WITH HIGHLIGHTS ...",0.02)
    os.sleep(0.5)
    m.setTextColor(colors.yellow)
    tw(2,20,">> DONE. CONSEQUENCES INCOMING. COPE.",0.03)
    os.sleep(2.5)
end
 
-- ==========================================
-- PHASE: BROWSER HISTORY
-- ==========================================
local function phase_history()
    blast(colors.blue, colors.white)
    center(2,"--- FULL BROWSER HISTORY: EXPOSED ---")
    fillRow(3,"-",colors.gray,colors.blue)
    local row = 4
    for i=1, #fake_history do
        if row >= h then break end
        m.setTextColor(rnd(colors_list))
        tw(2, row, "> "..fake_history[math.random(1,#fake_history)], 0.006)
        row = row + 1
        os.sleep(0.1)
    end
    os.sleep(2)
end
 
-- ==========================================
-- PHASE: DISCORD DM LEAK
-- ==========================================
local function phase_discord()
    blast(colors.black, colors.magenta)
    center(2,"--- LEAKED DMs: ALL OF THEM ---")
    local row = 4
    while row < h-1 do
        m.setTextColor(colors.white)
        tw(2, row, "You: "..rnd(fake_dms), 0.006)
        row=row+1
        if row>=h then break end
        m.setTextColor(colors.lightGray)
        local hr=math.random(1,12)
        local mn=string.format("%02d",math.random(0,59))
        local ap=math.random(0,1)==0 and "AM" or "PM"
        tw(2, row, "  Read "..hr..":"..mn.." "..ap.." — Left on read forever", 0.004)
        row=row+1
        os.sleep(0.25)
    end
    os.sleep(2)
end
 
-- ==========================================
-- PHASE: ROAST GENERATOR
-- ==========================================
local function phase_roast()
    blast(colors.black, colors.white)
    for i=1,25 do
        m.clear()
        m.setTextColor(rnd(colors_list))
        center(math.floor(h/2)-3, "OFFICIAL INTERNATIONAL CLASSIFICATION:")
        m.setTextColor(colors.white)
        center(math.floor(h/2)-1, "YOU ARE HEREBY DECLARED A")
        m.setTextColor(colors.red)
        center(math.floor(h/2)+1, genTripleInsult())
        m.setTextColor(colors.lightGray)
        center(math.floor(h/2)+3, "— The International Minecraft Tribunal, "..os.time())
        os.sleep(0.12)
    end
    os.sleep(1)
end
 
-- ==========================================
-- PHASE: MATRIX RAIN
-- ==========================================
local function phase_matrix()
    blast(colors.black, colors.lime)
    local words = {"L","F","NOOB","RIP","GG","COPE","RATIO","MALDING","CLIPPED","VOIDED","SKILL?","WHAT?","HOW?","WHY?","NOOOO"}
    for i=1,1000 do
        m.setCursorPos(math.random(1,w), math.random(1,h))
        m.setTextColor(rnd(colors_list))
        local r=math.random(1,15)
        if r>13 then m.write(genInsult():sub(1,w-m.getCursorPos()+1))
        elseif r>10 then m.write(rnd(words))
        else m.write(tostring(math.random(0,1))) end
        os.sleep(0.001)
    end
    os.sleep(0.5)
end
 
-- ==========================================
-- PHASE: DVD BOUNCE
-- ==========================================
local function phase_dvd()
    blast(colors.black, colors.white)
    local bx=math.random(1,math.max(1,w-20))
    local by=math.random(1,math.max(1,h-2))
    local dx,dy=1,1
    for i=1,600 do
        m.setBackgroundColor(colors.black)
        m.clear()
        bx=bx+dx; by=by+dy
        local txt = (i%50==0) and genTripleInsult() or genInsult()
        local tlen=#txt
        if bx<=1 or bx+tlen>=w then dx=-dx end
        if by<=1 or by>=h then dy=-dy end
        bx=math.max(1,math.min(w-tlen,bx))
        by=math.max(1,math.min(h,by))
        m.setTextColor(rnd(colors_list))
        m.setCursorPos(bx,by)
        m.write(txt:sub(1,w-bx+1))
        os.sleep(0.012)
    end
end
 
-- ==========================================
-- PHASE: SKULL ANIMATION
-- ==========================================
local function phase_rip()
    blast(colors.black, colors.white)
    local mw=math.floor(w/2)-4
    local mh=math.floor(h/2)-4
    for flash=1,6 do
        m.setTextColor(flash%2==0 and colors.white or colors.red)
        for i,line in ipairs(ascii_skull) do
            m.setCursorPos(math.max(1,mw), math.max(1,mh+i-1))
            m.write(line)
        end
        os.sleep(0.08)
        blast(colors.black,colors.white)
        os.sleep(0.04)
    end
    m.setTextColor(colors.red)
    for i,line in ipairs(ascii_skull) do
        m.setCursorPos(math.max(1,mw), math.max(1,mh+i-1))
        m.write(line)
    end
    m.setTextColor(colors.white)
    center(mh+#ascii_skull+1,"YOU DIED")
    m.setTextColor(colors.red)
    center(mh+#ascii_skull+2,genDoubleInsult())
    m.setTextColor(colors.lightGray)
    center(mh+#ascii_skull+3,"Score: "..math.random(-99999,-1))
    center(mh+#ascii_skull+4,"Cause: "..rnd({"Your own fault","Definitely lag","Gravity (skill issue)","A choice you made","You","Hubris","The void called and you answered"}))
    os.sleep(3.5)
end
 
-- ==========================================
-- PHASE: VIRUS SCAN
-- ==========================================
local function phase_virusscan()
    blast(colors.black, colors.green)
    tw(2,2,"XYNIA THREAT DETECTION v9.0 — SCANNING",0.01)
    os.sleep(0.3)
    tw(2,4,"Target: C:\\Users\\"..rnd(adj).."_GAMER\\AppData\\Roaming\\.minecraft",0.01)
    os.sleep(0.4)
    local threats={
        {"SkillIssue.exe",             "CRITICAL — W64.NoobWare.Persistent"},
        {"HopiumPump.dll",             "HIGH     — Cope Injection Module (kernel level)"},
        {"XRay_Legit_I_Promise.jar",   "CRITICAL — Confirmed Cheating Suite"},
        {"freecoins2026.exe",          "CRITICAL — Trojan.Brainworm.Desperate"},
        {"DeleteSystem32.bat",         "CRITICAL — Self Destruction Automation"},
        {"DirtHouseBuilder.sys",       "LOW      — Aesthetic Crime (barely structural)"},
        {"LavaWalker.dll",             "HIGH     — Gravity Denial (always kills you)"},
        {"KeyboardTurner.exe",         "MEDIUM   — 2009 Combat Methodology Detected"},
        {"F2P_Mindset.exe",            "HIGH     — Advanced Cope Behavior"},
        {"UnbanApeal_v9.docx",         "MEDIUM   — Delusional Narrative Engine"},
        {"GravelTruster.sys",          "HIGH     — Physics Denial Module"},
        {"LavaBucketRegret.dll",       "CRITICAL — Irreversible Decision Logger"},
        {"VoidJumper.bat",             "HIGH     — Teleports you into the void repeatedly"},
        {"AdminPlease.exe",            "MEDIUM   — Plea Broadcast Service"},
        {"CreativeMode_Wish.dll",      "LOW      — Cope Simulator (harmless, sad)"},
    }
    local row=6
    for _,t in ipairs(threats) do
        if row>=h-1 then break end
        m.setTextColor(colors.white)
        tw(2,row,">> "..t[1],0.004)
        m.setTextColor(colors.red)
        tw(2,row+1,"   ["..t[2].."]",0.004)
        row=row+2
        os.sleep(0.08)
    end
    os.sleep(0.5)
    m.setTextColor(colors.red)
    center(h-1,"QUARANTINE FAILED. CANNOT FIX FUNDAMENTAL SKILL ISSUE.")
    os.sleep(2.5)
end
 
-- ==========================================
-- PHASE: TASK MANAGER
-- ==========================================
local function phase_taskmanager()
    blast(colors.black, colors.white)
    center(1,"TASK MANAGER — PROCESSES RUNNING IN YOUR SKULL")
    fillRow(2,"-",colors.gray,colors.black)
    m.setTextColor(colors.lightGray)
    tw(2,3,string.format("%-22s%-7s%-8s%s","NAME","CPU%","MEM","STATUS"),0.002)
    fillRow(4,"-",colors.gray,colors.black)
    local procs={
        {"cope.exe",              "97%",  "8.2GB",  "NOT RESPONDING"},
        {"skill.dll",             "0%",   "0KB",    "NOT FOUND"},
        {"braincells.sys",        "0.1%", "256B",   "CRITICAL LOW"},
        {"touch_grass.exe",       "0%",   "0KB",    "NEVER LAUNCHED"},
        {"dirt_palace_3d.exe",    "45%",  "2.1GB",  "RUNNING (barely)"},
        {"xray_client.jar",       "12%",  "900MB",  "TOTALLY LEGIT"},
        {"unban_appeal_v9.docx",  "8%",   "400MB",  "DRAFTING (9th attempt)"},
        {"hopium.exe",            "55%",  "5.5GB",  "NOT RESPONDING"},
        {"minecraft.exe",         "99%",  "14GB",   "NOT RESPONDING"},
        {"parents_trust.dll",     "0%",   "0KB",    "TERMINATED"},
        {"self_awareness.exe",    "0%",   "0KB",    "NEVER INSTALLED"},
        {"map_reading.dll",       "0%",   "0KB",    "CORRUPTED"},
        {"torch_placement.sys",   "0%",   "2KB",    "IDLE (always)"},
        {"bed_usage.exe",         "0%",   "0KB",    "NEVER EXECUTED"},
        {"lava_trust.dll",        "100%", "12GB",   "RUNNING (why)"},
        {"void_avoidance.sys",    "0%",   "0KB",    "DISABLED"},
        {"death_counter.exe",     "2%",   "16GB",   "RUNNING (large log)"},
        {"respawn_screen.dll",    "89%",  "11GB",   "CONSTANTLY ACTIVE"},
    }
    local row=5
    for _,p in ipairs(procs) do
        if row>=h then break end
        m.setTextColor(p[4]=="NOT RESPONDING" and colors.red or (p[4]=="NOT FOUND" and colors.orange or colors.white))
        local line=string.format("%-22s%-7s%-8s%s",p[1]:sub(1,22),p[2],p[3],p[4])
        tw(2,row,line:sub(1,w-2),0.002)
        row=row+1
        os.sleep(0.05)
    end
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: PROGRESS BARS OF SHAME
-- ==========================================
local function phase_progress()
    blast(colors.black, colors.white)
    center(2,"RUNNING FULL DIAGNOSTICS ON: YOU (GOD HELP US)")
    os.sleep(0.5)
    local checks={
        "Checking skill level",
        "Verifying braincell count",
        "Locating redeeming qualities",
        "Searching for game sense",
        "Attempting to find a single W",
        "Looking for non-dirt-tier plays",
        "Confirming basic awareness",
        "Validating spatial reasoning",
        "Checking lava avoidance reflex",
        "Scanning for any map knowledge",
        "Testing hunger bar awareness",
        "Verifying torch placement logic",
        "Checking if bed was ever used",
        "Auditing enchantment knowledge",
        "Reviewing crafting recipe recall",
    }
    local row=4
    for i,check in ipairs(checks) do
        if row>=h-1 then break end
        progressBar(row, check, 0.01)
        row=row+2
        os.sleep(0.05)
    end
    os.sleep(0.5)
    m.setTextColor(colors.red)
    center(h-1,"DIAGNOSIS: TERMINAL. IRREVERSIBLE. NO CURE EXISTS.")
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: SCOREBOARD
-- ==========================================
local function phase_scoreboard()
    blast(colors.black, colors.white)
    center(2,"LIFETIME STATS: "..genInsult())
    fillRow(3,"=",colors.gray,colors.black)
    local stats={
        {"Deaths by creeper",             math.random(80,999)},
        {"Deaths by lava",                math.random(60,700)},
        {"Deaths by fall damage",         math.random(100,900)},
        {"Deaths by own TNT",             math.random(10,300)},
        {"Deaths by skeleton",            math.random(90,1500)},
        {"Deaths to the void",            math.random(20,400)},
        {"Deaths by suffocation",         math.random(5,200)},
        {"Deaths by cactus (how)",        math.random(3,150)},
        {"Deaths by drowned (surface)",   math.random(5,100)},
        {"Deaths by their own fire",      math.random(5,80)},
        {"Total diamonds ever lost",      math.random(200,9999)},
        {"Dirt blocks placed",            math.random(5000,99999)},
        {"Unban appeals written",         math.random(5,60)},
        {"Times claimed lag",             math.random(500,9999)},
        {"Times actually lagging",        math.random(0,3)},
        {"Friends made (ingame)",         math.random(0,2)},
        {"Friends kept (ingame)",         0},
        {"Times improved",                0},
        {"Wins",                          0},
        {"Times said 'gg' and meant it",  0},
        {"Overall rating (out of 100)",   math.random(0,3)},
    }
    local row=4
    for _,s in ipairs(stats) do
        if row>=h then break end
        m.setTextColor(rnd(colors_list))
        local line=string.format("%-36s %d",s[1]:sub(1,36),s[2])
        tw(2,row,line:sub(1,w-2),0.003)
        row=row+1
        os.sleep(0.04)
    end
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: CONSPIRACY BOARD
-- ==========================================
local function phase_conspiracy()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.red)
    center(2,"*** CLASSIFIED INTEL REGARDING YOU ***")
    fillRow(3,"-",colors.red,colors.black)
    local row=4
    local shuffled={}
    for _,v in ipairs(conspiracy_theories) do shuffled[#shuffled+1]=v end
    for i=#shuffled,2,-1 do
        local j=math.random(1,i)
        shuffled[i],shuffled[j]=shuffled[j],shuffled[i]
    end
    for i,ct in ipairs(shuffled) do
        if row>=h then break end
        m.setTextColor(rnd(colors_list))
        tw(2,row,"- "..ct, 0.008)
        row=row+2
        os.sleep(0.3)
    end
    os.sleep(2)
end
 
-- ==========================================
-- PHASE: ACHIEVEMENT SPAM
-- ==========================================
local function phase_achievements()
    blast(colors.black, colors.white)
    center(2,"ACHIEVEMENT UNLOCKED! (somehow)")
    os.sleep(0.5)
    for i=1,math.min(#fake_achievements, math.floor((h-4)/3)) do
        local ach=rnd(fake_achievements)
        local sy=math.random(3,h-4)
        box(2,sy,w-1,sy+2,colors.yellow)
        m.setTextColor(colors.yellow)
        center(sy,">>> "..ach.n)
        m.setTextColor(colors.lightGray)
        center(sy+1,ach.d:sub(1,w-4))
        os.sleep(1.2)
        blast(colors.black,colors.white)
        center(2,"ACHIEVEMENT UNLOCKED! (somehow)")
        os.sleep(0.1)
    end
end
 
-- ==========================================
-- PHASE: SEIZURE PROTOCOL
-- ==========================================
local function phase_seizure()
    for i=1,150 do
        blast(rnd(colors_list), colors.black)
        local r=math.random(1,4)
        if r==1 then
            center(math.floor(h/2),genTripleInsult())
        elseif r==2 then
            center(math.floor(h/2)-1,genInsult())
            center(math.floor(h/2)+1,genInsult())
        elseif r==3 then
            center(math.floor(h/2),"WHAT THE FUCK ARE YOU DOING")
        else
            center(math.floor(h/2),genDoubleInsult())
        end
        os.sleep(0.006)
        blast(colors.black, rnd(colors_list))
        center(math.floor(h/2),"ABSOLUTE "..genInsult())
        os.sleep(0.006)
    end
end
 
-- ==========================================
-- PHASE: NEWS TICKER
-- ==========================================
local function phase_ticker()
    blast(colors.black, colors.yellow)
    center(1,"*** BREAKING NEWS ***")
    local headlines={
        "LOCAL PLAYER DIES AGAIN — CLAIMS 'DEFINITELY LAG'",
        "INVENTORY LOST IN LAVA — FOURTH TIME THIS WEEK ALONE",
        "DIRT HUT DISTRICT REPORTS SURGE IN STRUCTURAL COLLAPSES",
        "VILLAGERS FILE CLASS-ACTION COMPLAINT AGAINST UNNAMED PLAYER",
        "CREEPER ASSOCIATION NAMES NEW HONORARY VICTIM — SOURCES CONFIRM IT'S YOU",
        "SERVER ECONOMY CRASHES: TOO MUCH DIRT IN CIRCULATION — ONE PERSON RESPONSIBLE",
        "UNBAN APPEAL #"..math.random(7,50).." DENIED — ADMINS QUOTE 'PLEASE STOP SUBMITTING THESE'",
        "LOCAL SKELETON WINS MARKSMAN AWARD — VICTIM UNAVAILABLE FOR COMMENT",
        "NETHER PORTAL PETITIONS COURT FOR REASSIGNMENT AWAY FROM THIS PLAYER",
        "IRON GOLEM RETIRES EARLY CITING 'MORAL INJURY'",
        "ENDER DRAGON FILES HOSTILE WORKPLACE COMPLAINT",
        "WARDEN HEARS PLAYER FROM 4 CHUNKS AWAY — SCIENTIST BAFFLED BY VOLUME",
        "GRAVEL PLACEMENT RULED 'RECKLESS' BY INDEPENDENT INQUIRY",
        "SERVER TPS DROPS EVERY TIME THIS PLAYER OPENS INVENTORY — CORRELATION CONFIRMED",
        "PHANTOM ATTACK SURVIVOR CLAIMS 'I WAS GONNA SLEEP' — SLEPT ZERO TIMES",
        "LOCAL PLAYER LOSES FULL NETHERITE IN LAVA — IN THE OVERWORLD — SCIENTISTS CONFUSED",
        "BEE PUNCHER STILL AT LARGE — SERVER OFFERS DIRT REWARD",
        "ENDERMEN HOLD EMERGENCY ASSEMBLY — AGENDA ITEM: ONE SPECIFIC PLAYER",
    }
    for _,h_text in ipairs(headlines) do
        local row=math.random(2,h-1)
        scrollLine(row, "  >>> "..h_text.."  <<<  ", rnd(colors_list))
    end
end
 
-- ==========================================
-- PHASE: EULOGY
-- ==========================================
local function phase_eulogy()
    blast(colors.black, colors.white)
    m.setTextColor(colors.lightGray)
    center(2, "IN MEMORIAM")
    center(3, string.rep("-", math.min(20,w)))
    os.sleep(0.5)
    local lines = {
        "We are gathered here today to mourn",
        "the inventory of "..genInsult()..",",
        "lost to lava on "..os.date("%A"),
        "at approximately who-cares o'clock.",
        "",
        "Survived by: 400 dirt blocks,",
        "1 leather boot (one),",
        "and a half-written unban appeal.",
        "",
        "The deceased had "..math.random(0,3).." diamonds",
        "at time of death.",
        "They were in the lava.",
        "",
        "In lieu of flowers, please",
        "learn to not fall in lava.",
        "Just. Don't fall in it.",
        "It is bright orange.",
        "You can see it.",
        "",
        "Rest in pieces.",
        "— The Server",
    }
    local row=5
    for _,line in ipairs(lines) do
        if row>=h then break end
        m.setTextColor(line=="" and colors.black or colors.white)
        center(row, line)
        row=row+1
        os.sleep(0.15)
    end
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: WARDEN WARNING
-- ==========================================
local function phase_warden()
    blast(colors.black, colors.red)
    center(2,"WARDEN PROXIMITY ALERT")
    os.sleep(0.5)
    m.setTextColor(colors.orange)
    local warden={
        "      _____     ",
        "    /       \\   ",
        "   | O     O |  ",
        "   |    ^    |  ",
        "   |  -----  |  ",
        "   |         |  ",
        "  /|         |\\  ",
        " / |_________|  \\",
    }
    for i,line in ipairs(warden) do
        center(3+i, line)
        os.sleep(0.1)
    end
    os.sleep(0.5)
    m.setTextColor(colors.white)
    center(h-4, "You placed a torch.")
    center(h-3, "It heard you.")
    center(h-2, "It always hears you.")
    center(h-1, "It is never not hearing you.")
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: LOADING SCREEN OF DOOM
-- ==========================================
local function phase_loading()
    blast(colors.black, colors.white)
    center(2, "LOADING: "..genInsult().."'S GAME")
    local tasks={
        "Importing bad decisions",
        "Allocating cope buffer",
        "Loading dirt textures (primary asset)",
        "Connecting to denial server",
        "Calibrating death counter (resetting to 0)",
        "Fetching respawn coordinates",
        "Initializing lava magnetism",
        "Compiling skeleton aim data",
        "Building creeper pathfinding (targeting: you)",
        "Mounting inventory chaos module",
        "Establishing unban pipeline",
        "Loading admin blacklist",
        "Syncing gravel physics",
        "Preparing void coordinates",
        "Packaging skill issue report",
    }
    local row=4
    for i,task in ipairs(tasks) do
        if row>=h-1 then break end
        m.setTextColor(colors.lightGray)
        tw(2,row,task.."...",0.01)
        m.setTextColor(colors.red)
        tw(w-5,row,"FAIL",0.005)
        row=row+1
        os.sleep(0.08)
    end
    os.sleep(0.5)
    m.setTextColor(colors.red)
    center(h-1,"LAUNCH ABORTED. SKILL PREREQUISITES NOT MET.")
    os.sleep(2.5)
end
 
-- ==========================================
-- PHASE: LIVE CHAT SIMULATION
-- ==========================================
local function phase_livechat()
    blast(colors.black, colors.white)
    center(1,"[ SERVER CHAT LOG — UNCENSORED ]")
    fillRow(2,"-",colors.gray,colors.black)
    local names={"xX_ProGamer_Xx","CreeperHunter99","AdminSteve","Notch_Real","DiamondMiner64","ServerBot","SMP_Veteran","GrindMode2026","BuildMaster","HerobrineFan"}
    local msgs={
        "who keeps dying at spawn lmao",
        "bro fell in lava AGAIN",
        "how does someone die this much",
        "I think we have a bot on the server",
        "no that's just [PLAYER]",
        "LMAOOO they did it again",
        "can we get a death counter plugin just for this person",
        "their base coords got leaked btw",
        "wasn't hard to find tbh, it's a dirt hut",
        "I feel bad. no wait I don't.",
        "they tried to fight the warden with a wooden sword",
        "was it enchanted at least",
        "no",
        "...respect",
        "just. a little bit.",
        "no wait not respect",
        "admin can we get this player some grief protection",
        "they need it for their own base from themselves",
        "just ban the creepers near them",
        "ban the lava while you're at it",
        "and the void",
        "and gravel",
        "and skeletons",
        "basically ban physics near this player",
        "that's not how minecraft works",
        "then this player is unprotectable",
        "F",
        "F",
        "F",
        "F (but respectfully)",
    }
    local row=3
    for i=1,math.min(#msgs,h-3) do
        if row>=h then break end
        local name=rnd(names)
        m.setTextColor(rnd(colors_list))
        m.setCursorPos(2,row)
        m.write("<"..name.."> ")
        m.setTextColor(colors.white)
        m.write(msgs[i]:sub(1,w-#name-5))
        row=row+1
        os.sleep(0.2)
    end
    os.sleep(2.5)
end
 
-- ==========================================
-- PHASE: FAKE SPEEDRUN TIMER
-- ==========================================
local function phase_speedrun()
    blast(colors.black, colors.white)
    center(2,"SPEEDRUN ATTEMPT #"..math.random(40,300).." — LIVE")
    fillRow(3,"-",colors.gray,colors.black)
    local splits={
        {"Punch tree",          "0:00.42",  "0:00.38", false},
        {"Craft crafting table","0:01.90",  "0:01.20", false},
        {"Get wood",            "0:03.11",  "0:02.50", false},
        {"Find cave",           "0:24.60",  "0:18.00", false},
        {"Get iron",            "2:14.30",  "1:45.00", false},
        {"Smelt iron",          "3:01.00",  "2:20.00", false},
        {"Find lava",           "3:01.03",  "2:25.00", false},
        {"Make water bucket",   "DEAD",     "2:30.00", true},
        {"Respawn",             "+4:22.00", "---",     true},
        {"Craft crafting table","AGAIN",    "---",     true},
        {"Find cave again",     "DEAD",     "---",     true},
        {"Give up",             "12:44.99", "---",     true},
    }
    local row=4
    for _,s in ipairs(splits) do
        if row>=h then break end
        m.setTextColor(s[4] and colors.red or colors.lime)
        local line=string.format("%-24s %-10s %s",s[1]:sub(1,24),s[2],s[4] and "(-"..(math.random(100,9999)/100)..")" or "(+"..math.random(1,60).."s)")
        tw(2,row,line:sub(1,w-2),0.005)
        row=row+1
        os.sleep(0.15)
    end
    os.sleep(0.5)
    m.setTextColor(colors.red)
    center(h-1,"FINAL TIME: DNF. CAUSE: EXISTING.")
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: FAKE SUPPORT TICKET
-- ==========================================
local function phase_support()
    blast(colors.black, colors.white)
    center(2,"SUPPORT TICKET #"..math.random(10000,99999).." — FILED BY YOU")
    fillRow(3,"=",colors.gray,colors.black)
    local ticket={
        "Subject: Need Help URGENT Please Read",
        "",
        "Dear Mojang/Admin/Anyone,",
        "",
        "I am writing to report several issues with",
        "your game that are definitely the game's fault:",
        "",
        "1. The lava keeps hurting me even though I",
        "   didn't want it to.",
        "",
        "2. The skeleton aimed at me specifically.",
        "   I have no proof but I know.",
        "",
        "3. My diamonds were in my inventory and now",
        "   they are in the lava. Refund please.",
        "",
        "4. The creeper had no warning sound.",
        "   (There was a warning sound.)",
        "",
        "5. I should not have died. I had 2 hearts.",
        "   The zombie had more than 2 damage.",
        "   This seems unfair.",
        "",
        "Please respond within 3-5 business days.",
        "I will be filing further appeals in the",
        "meantime (this is my 11th ticket).",
        "",
        "Regards, A Paying Customer",
        "(Note: I have never paid for Minecraft)",
    }
    local row=4
    for _,line in ipairs(ticket) do
        if row>=h then break end
        m.setTextColor(line=="" and colors.black or colors.lightGray)
        tw(2,row,line:sub(1,w-2),0.008)
        row=row+1
        os.sleep(0.06)
    end
    os.sleep(0.5)
    m.setTextColor(colors.red)
    center(h-1,"STATUS: CLOSED — MARKED 'SKILL ISSUE' — NOT ELIGIBLE FOR REFUND")
    os.sleep(3)
end
 
-- ==========================================
-- PHASE: REBOOT COUNTDOWN
-- ==========================================
local function phase_reboot()
    blast(colors.black, colors.red)
    center(math.floor(h/2)-2,"CRITICAL MEMORY LEAK: COPE.EXE")
    center(math.floor(h/2),"REBOOTING CONFIDENCE CORE...")
    center(math.floor(h/2)+2,"ETA: GEOLOGICAL TIMESCALE")
    os.sleep(2)
    blast(colors.black, colors.white)
    for i=5,0,-1 do
        m.clear()
        center(math.floor(h/2)-1,"REINITIALIZING BRAIN IN "..i.."...")
        center(math.floor(h/2)+1,genTripleInsult())
        os.sleep(1)
    end
end
 
-- ==========================================
-- ALL PHASES — SHUFFLED EVERY CYCLE
-- ==========================================
local phases={
    phase_bsod, phase_dox, phase_virusscan, phase_history,
    phase_discord, phase_achievements, phase_roast, phase_taskmanager,
    phase_progress, phase_conspiracy, phase_scoreboard, phase_matrix,
    phase_rip, phase_dvd, phase_warden, phase_ticker, phase_seizure,
    phase_eulogy, phase_loading, phase_livechat, phase_speedrun,
    phase_support, phase_reboot,
}
 
local function visualLoop()
    while true do
        for i=#phases,2,-1 do
            local j=math.random(1,i)
            phases[i],phases[j]=phases[j],phases[i]
        end
        for _,phase in ipairs(phases) do
            local ok,err=pcall(phase)
            if not ok then
                blast(colors.red,colors.white)
                center(math.floor(h/2),"ERR: "..tostring(err):sub(1,w-6))
                os.sleep(1)
            end
        end
    end
end
 
-- ==========================================
-- BOOT SEQUENCE
-- ==========================================
blast(colors.black,colors.red)
center(math.floor(h/2)-2,"XYNIA BRAINROT ENGINE v3.0")
center(math.floor(h/2),"INITIALIZING PSYCHOLOGICAL DAMAGE...")
center(math.floor(h/2)+2,"NO SURVIVORS. NO MERCY. NO CHILL.")
os.sleep(2.5)
 
parallel.waitForAny(visualLoop, audioLoop)
 
