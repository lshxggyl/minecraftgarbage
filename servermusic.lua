-- ============================================================
-- XYNIA'S WEAPONIZED BRAINROT ENGINE  v7.0
-- "DIAL AT 12, MONITOR IN FEDERAL PROTECTION" EDITION
-- RATED 18+ FOR LANGUAGE, PROFANITY, PSYCHOLOGICAL DAMAGE,
-- CRIMES AGAINST TASTE, AND CRIMES AGAINST GAMING ITSELF
-- 75 PHASES + 7 TICKER SEGMENTS OF PURE CONCENTRATED SUFFERING
-- ============================================================

local m = peripheral.find("monitor")
if not m then
    print("NO MONITOR FOUND.")
    print("You absolute fucking walnut.")
    print("Cannot commit psychological crimes without hardware.")
    print("Plug the goddamn thing in and try again.")
    return
end

local speakers = {peripheral.find("speaker")}
if #speakers == 0 then
    print("No speakers found. Coward setup.")
    print("Visual suffering only, as a treat.")
end

m.setTextScale(1)
term.redirect(m)
local w, h = m.getSize()

math.randomseed(os.time())

-- ============================================================
-- CORE RENDERING: x-aware clipping so NOTHING EVER OVERFLOWS
-- ============================================================
-- clip to absolute monitor width
local function clip(s)
    return tostring(s):sub(1, w)
end

-- clip accounting for starting column (THE ACTUAL FIX)
local function clipAt(s, x)
    local avail = math.max(0, w - math.max(1, x) + 1)
    return tostring(s):sub(1, avail)
end

local function center(y, text)
    text = clip(text)
    local x = math.max(1, math.floor((w - #text) / 2) + 1)
    if y >= 1 and y <= h then
        m.setCursorPos(x, y)
        m.write(text)
    end
end

local function blast(bg, fg)
    m.setBackgroundColor(bg or colors.black)
    m.setTextColor(fg or colors.white)
    m.clear()
end

-- typewriter: FIXED to never overflow
local function tw(x, y, text, speed)
    x = math.max(1, x)
    y = math.max(1, math.min(h, y))
    text = clipAt(text, x)
    if #text == 0 then return end
    m.setCursorPos(x, y)
    for i = 1, #text do
        m.write(text:sub(i, i))
        os.sleep(speed or 0.05)
    end
end

-- instant write: FIXED to never overflow
local function put(x, y, text)
    x = math.max(1, x)
    y = math.max(1, math.min(h, y))
    text = clipAt(text, x)
    if #text == 0 then return end
    m.setCursorPos(x, y)
    m.write(text)
end

local function fillRow(y, char, fg, bg)
    if y < 1 or y > h then return end
    m.setBackgroundColor(bg or colors.black)
    m.setTextColor(fg or colors.white)
    m.setCursorPos(1, y)
    m.write(string.rep(char or "-", w))
end

local function box(x1, y1, x2, y2, fg)
    m.setTextColor(fg or colors.white)
    x1 = math.max(1, x1); x2 = math.min(w, x2)
    y1 = math.max(1, y1); y2 = math.min(h, y2)
    for row = y1, y2 do
        for col = x1, x2 do
            m.setCursorPos(col, row)
            if row == y1 or row == y2 then m.write("-")
            elseif col == x1 or col == x2 then m.write("|")
            else m.write(" ") end
        end
    end
end

-- progress bar that actually fits
local function progressBar(y, label, speed)
    if y < 1 or y > h then return end
    local maxLbl = math.max(1, math.floor(w * 0.42))
    local lbl = label:sub(1, maxLbl)
    m.setTextColor(colors.white)
    tw(2, y, lbl .. " [", speed)
    local barStart = 2 + #lbl + 2
    local barW = math.max(1, math.min(8, w - barStart - 6))
    m.setTextColor(colors.lime)
    for i = 1, barW do
        if barStart + i - 1 <= w then
            m.setCursorPos(barStart + i - 1, y)
            m.write("=")
            os.sleep(speed or 0.045)
        end
    end
    m.setTextColor(colors.white)
    put(barStart + barW, y, "]")
    m.setTextColor(colors.red)
    put(barStart + barW + 1, y, "FAIL")
end

-- scrolling ticker: step=1, proper speed
local function scrollLine(y, text, fg)
    y = math.max(1, math.min(h, y))
    m.setTextColor(fg or colors.white)
    for startX = w, 1 - #text, -1 do
        m.setCursorPos(1, y)
        m.write(string.rep(" ", w))
        local dx = math.max(1, startX)
        local str = text
        if startX < 1 then str = str:sub(2 - startX) end
        m.setCursorPos(dx, y)
        m.write(str:sub(1, w - dx + 1))
        os.sleep(0.062)
    end
end

-- ============================================================
-- DICTIONARIES OF ETERNAL DISRESPECT
-- ============================================================
local adj = {
    -- Classic
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
    "HUNGER-DENYING","ARMOR-OPTIONAL","HELMET-ALLERGIC","SHIELD-FORGETTING",
    "FURNACE-BAFFLED","COMPASS-WORSHIPPING","MAP-ILLITERATE","CHUNK-BLIND",
    "BIOME-LOST","CAVE-FEARING","GRAVITY-SURPRISED","SUFFOCATION-PRONE",
    "DROWNING-PRONE","CACTUS-ADJACENT","MAGMA-STEPPING","NOTCH-FORSAKEN",
    "MOJANG-ABANDONED","TERMINALLY-COOKED","GALAXY-ROTTED",
    "UNIRONICALLY-BAD","DEMONSTRABLY-COOKED","MEASURABLY-DOGSHIT",
    "PROVABLY-BOTTOM-TIER","ACADEMICALLY-HOPELESS","PHILOSOPHICALLY-LOST",
    "SPIRITUALLY-GRIEFED","EXISTENTIALLY-NOOB","HISTORICALLY-BAD",
    "MATHEMATICALLY-COOKED","ASTRONOMICALLY-BAD","BIOLOGICALLY-NPC",
    "PHYSICALLY-CHALLENGED-BY-GRAVITY",
    -- New elite tier
    "MOUTH-BREATHING","KNUCKLE-DRAGGING","PASTE-EATING",
    "GOLDFISH-MEMORIED","SENTIENT-PARTICIPATION-TROPHY",
    "DISAPPOINTINGLY-ALIVE","TECHNICALLY-PRESENT","BARELY-CONSCIOUS",
    "FUNCTIONALLY-USELESS","AGGRESSIVELY-MEDIOCRE","VIOLENTLY-BAD",
    "HORRENDOUSLY-COOKED","IRREPARABLY-BROKEN","FUNDAMENTALLY-CURSED",
    "ORGANICALLY-BAD","NATURALLY-TERRIBLE","PATHOLOGICALLY-SHIT",
    "ACUTELY-DOGSHIT","SEVERELY-LACKING","PROFOUNDLY-LOST",
    "CRITICALLY-UNCOOL","DANGEROUSLY-UNAWARE","LETHALLY-BAD",
    "FATALLY-COOKED","MAGNIFICENTLY-AWFUL","SPECTACULARLY-SHIT",
    "GLORIOUSLY-TERRIBLE","HEROICALLY-BAD","LEGENDARILY-COOKED",
    "EPICALLY-DOGSHIT","MYTHICALLY-AWFUL","COSMICALLY-BAD",
    "ASTONISHINGLY-BAD","BEWILDERINGLY-SHIT","INEXPLICABLY-AWFUL",
    "UNFATHOMABLY-COOKED","INCOMPREHENSIBLY-BAD","INEFFABLY-DOGSHIT",
    "PASSIONATELY-AWFUL","ENTHUSIASTICALLY-SHIT","CLINICALLY-COOKED",
    "MEDICALLY-CONCERNING","WORRYINGLY-DOGSHIT","CONCERNINGLY-BAD",
    "ALARMINGLY-USELESS","SHOCKINGLY-INCOMPETENT",
    "AWARD-WINNINGLY-TERRIBLE","PROFESSIONALLY-INCOMPETENT",
    "FULLY-COMMITTED-TO-BEING-BAD","HISTORICALLY-UNPRECEDENTED-SHIT",
    "GENUINELY-IMPRESSIVE-IN-A-BAD-WAY","PEER-REVIEWED-TRASH",
    "DOUBLE-BLIND-AWFUL","CONTROLLED-STUDY-CONFIRMED-BAD",
    "REPRODUCIBLY-SHIT","STATISTICALLY-CERTAIN-TO-FAIL",
    "PEER-REVIEWED-AND-CERTIFIED-DOGSHIT",
    "OBJECTIVELY-MEASURABLY-ACTUALLY-BAD",
    "PROVABLY-AND-DEMONSTRABLY-COOKED",
    "EMPIRICALLY-VERIFIED-SKILL-ISSUE",
    "SCIENTIFICALLY-CONFIRMED-TERRIBLE",
}

local noun = {
    -- Classic
    "GAMER","LAVA DIVER","CREEPER SNACK","DIRT HUT ARCHITECT",
    "GRAVEL EATER","NPC","BOT","VILLAGE IDIOT","SILVERFISH VICTIM",
    "VOID HOPPER","WARDEN FODDER","GHAST TARGET","WALKING CHEST",
    "DISAPPOINTMENT","ERROR 404","KEYBOARD TURNER",
    "LOOT PINATA","CLOWN","CREEPER MAGNET","ARROW COLLECTOR",
    "TNT ACCIDENT SURVIVOR","ZOMBIE FOOD","SAND PHILOSOPHER",
    "NETHERITE DREAMER","TORCH SKIPPER","BED IGNORER",
    "FALL DAMAGE RESEARCHER","LAVA BUCKET REGRET","PORTAL TOURIST",
    "PHANTOM TARGET","PILLAGER PINATA","DEEP DARK TOURIST",
    "SCULK ACTIVATOR","FURNACE STARER","PISTON CASUALTY",
    "HOGLIN HUGGER","ENDERMAN EYE CONTACT MAKER","BEE PUNCHER",
    "AXOLOTL DROWNER","ANCIENT CITY TOURIST (DEAD)","MACE DROPPER",
    -- New elite nouns
    "SELF-INFLICTED DISASTER","WALKING COPE MACHINE",
    "AMBULATORY FAILURE","SENTIENT DIRT BLOCK","BIPEDAL MISTAKE",
    "UPRIGHT DISAPPOINTMENT","MOBILE CATASTROPHE",
    "BREATHING RESPAWN SCREEN","ORGANIC SKILL DEFICIT",
    "FLESH-BASED NPC","CARBON-BASED SHIT PLAYER",
    "VERIFIED BOTTOM FRAGGER","CERTIFIED GRIEF MAGNET",
    "REGISTERED CLOWN","FULLY QUALIFIED FAILURE",
    "CAREER UNDERPERFORMER","PERSISTENT LITTLE GREMLIN",
    "TENACIOUS DISASTER","COMMITTED CATASTROPHE",
    "DEDICATED DUMBASS","ENTHUSIASTIC NOOB","SPIRITED DISASTER",
    "GENUINE PIECE OF WORK","AUTHENTIC SHITSHOW",
    "HUMAN-SHAPED COLLECTION OF MISTAKES",
    "WALKING AD FOR PEACEFUL MODE",
    "BREATHING REASON THE ADMIN DRINKS",
    "ORGANIC CAUSE OF SERVER RESTART",
    "AMBULATORY CASE STUDY IN WHAT NOT TO DO",
    "LIVING PROOF TUTORIALS ARE NECESSARY",
    "GERALD-THE-PIG-LEVEL GAMEPLAY HAVER",
    "BASEMENT-DWELLING SKILL-ISSUE MACHINE",
    "CHRONICALLY-OFFLINE DECISION MAKER",
    "DOCUMENTED LAVA ENTHUSIAST",
    "ESTABLISHED VOID RESEARCHER",
    "CERTIFIED DIRT SOMMELIER",
    "LICENSED GRAVEL TRUTHER",
    "ACCREDITED CREEPER DIPLOMAT (FAILED)",
    "DISTINGUISHED CORPSE RUNNER",
    "CELEBRATED UNBAN APPEAL AUTHOR",
}

local fake_history = {
    "how to un-tame a wolf",
    "why are villagers running from me",
    "how to get sharpness 5 on dirt",
    "minecraft unban appeal template",
    "how to convince admins i wasnt xraying",
    "free minecoins generator 2026 working no virus",
    "why did my iron golem kill me",
    "how to build a roof in minecraft",
    "is it safe to drink poison in minecraft",
    "how to undo creeper explosion",
    "where did my diamonds go i had diamonds",
    "how to make friends in smp",
    "what does the crafting table do",
    "how do i place blocks tutorial",
    "is herobrine real 2026 proof video",
    "how to breathe underwater without helmet on",
    "why does lava hurt me",
    "how to win minecraft",
    "does dirt grow diamonds if you water it",
    "how to delete the void minecraft",
    "how to befriend warden gently",
    "how to undo dying in minecraft",
    "is iron better than wood",
    "what is a nether and why",
    "why is skeleton targeting me specifically",
    "refund policy for minecraft death",
    "why does everything keep killing me",
    "minecraft tips for absolute beginners me",
    "how long to get good at minecraft realistic",
    "is 600 deaths in one week normal for adults",
    "how to make netherite without mining at all",
    "can i tame a creeper if im nice to it",
    "what does the shift key do in minecraft",
    "how to sprint tutorial",
    "is using f3 cheating legally speaking",
    "what are coordinates used for",
    "why do i keep falling in holes i dug",
    "minecraft is rigged against me personally evidence",
    "can i sue a skeleton for emotional damages",
    "my base is gone what are my options legally",
    "how to fake screenshot for unban appeal guide",
    "how to cry less when dying repeatedly",
    "how do speedrunners do it so fast asking for me",
    "how to apologize to a village after burning it",
    "am i bad at minecraft online quiz",
    "minecraft therapy services near me",
    "how to get diamonds from the surface sky",
    "what does enchanting table do exactly",
    "what is a shield for in minecraft",
    "how far down is bedrock exactly",
    "what is below bedrock is it nothing",
    "why is the sky red in the nether is that ok",
    "what is the nether for do i have to go",
    "how to avoid the nether entirely please",
    "whats the point of the end dimension",
    "do i have to fight the ender dragon personally",
    "minecraft for people who are genuinely bad at it",
    "how to get good at pvp overnight please",
    "pvp tips for someone with zero kills ever",
    "is it normal to cry when losing items in a game",
    "grief counseling for minecraft item loss",
    "how to process losing diamonds to lava emotionally",
    "stages of grief minecraft death",
    "minecraft anonymous support group online",
    "am i addicted to dying in minecraft quiz",
    "why does the same lava keep finding me",
    "is the warden supposed to be that loud",
    "how to run away from warden effectively guide",
    "can the warden swim i need to know urgently",
    "is creative mode cheating if nobody is watching",
    "how to secretly switch to creative mode mid survival",
    "how to explain minecraft death to a therapist",
    "how to explain netherite loss to your partner",
    "is it normal to argue with skeletons out loud",
    "minecraft rage therapy techniques 2026",
    "when should i quit minecraft forever asking for me",
    "how to get revenge on a creeper emotionally",
    "how many dirt blocks is too many dirt blocks",
    "how to store 14000 blocks of dirt efficiently",
    "can you win an argument with the void",
    "how to convince yourself its not a skill issue",
    "it is a skill issue how to cope with that",
    "how to quit minecraft i keep relaunching",
    "i think i might be the villain of the smp",
    "how to rebrand after being the smp villain",
    "do admins read private messages yes or no urgent",
    "how to make a friend in minecraft never done it",
    "what do friends do in minecraft exactly",
    "is gerald the pig smarter than me quiz",
    "gerald the pig quiz results are bad what now",
    "chicken defeated me in combat what are my rights",
    "can a chicken be banned from a server legally",
    "how to stop a chicken from making eye contact",
    "the chicken knows something i dont how to tell",
    "my dirt cube got griefed how to cope",
    "how many dirt cubes is too many dirt cubes",
    "is living in a dirt cube a red flag",
    "dirt cube interior design tips 2026",
    "how to make a dirt cube bigger with more dirt",
    "i have 40000 dirt what is wrong with me",
    "why do i collect so much dirt all the time",
    "am i okay dirt minecraft quiz",
    "the void called how to ignore the void",
    "the void left a voicemail what does it want",
    "void voicemail said see you soon is that bad",
    "how the fuck to avoid lava seriously",
    "why am i so goddamn bad at everything",
    "how to stop being a complete piece of shit player",
    "fucking minecraft tutorial for absolute morons",
    "why do i deserve all this shit happening",
    "am i retarded or is this game rigged personally",
    "can lava be sued for discrimination",
    "how to not be a worthless fucking waste of air",
    "why does the asshole warden keep killing me",
    "creeper diplomacy fails every fucking time why",
    "why is a goddamn chicken better than me",
    "my pig is smarter than me what do i do",
    "how to cope with being absolute dogshit",
    "why do i keep making the same fucking mistakes",
    "can i refund my skill deficit",
    "is there a game mode for completely fucked people",
    "how to explain failing at a game to myself",
    "why am i this fucking incompetent",
    "what the fuck is actually wrong with me",
}

local fake_dms = {
    "Bro plz give my stuff back",
    "I swear it was lag",
    "Can u light up my cave Im scared",
    "How do you craft a chest again I forgot",
    "Admin teleport me Im stuck in a hole I dug",
    "I lost my iron pick it was my only one please",
    "Stop killing me I literally have nothing left",
    "Who took my 14 dirt blocks I need those",
    "Why did you fill my house with lava thats mean",
    "I only had 3 hearts that was not fair at all",
    "Ive been in this cave for 47 minutes now",
    "The zombies keep finding my hidey hole",
    "I think herobrine is following me in singleplayer",
    "My dog died please come to the funeral I made a grave",
    "I named my pig Gerald now I cannot eat pork",
    "The creeper was provoked you have to believe me",
    "How many planks does a house need at minimum",
    "Please ban the skeleton I have a screenshot",
    "Is it normal to cry when your stuff despawns",
    "My unban appeal got denied AGAIN fourth time",
    "Can you vouch for me in the appeal please",
    "I had full iron and lost to a single zombie",
    "The warden heard me breathing through my mic",
    "I built a house but forgot windows its dark",
    "Someone griefed my dirt hut I am devastated",
    "If I give you 2 wheat and a bone will you help",
    "Why does everyone have netherite and I have wood",
    "This is my 6th account this month they ban me",
    "Can you show me how to make a sword I forgot again",
    "I tried to ride a creeper it did not work at all",
    "Is pvp supposed to be this one-sided always",
    "At what point does it stop being a skill issue",
    "I read a wiki article and made it worse",
    "I joined a faction and got kicked in 4 minutes",
    "Do you think I will ever actually get good",
    "I dont wanna quit I just wanna die less often",
    "My mom says go to bed but we are mid-raid",
    "Do you ever feel like minecraft hates you",
    "The server said I was clearly not ready for this",
    "How do you not die so much all the time",
    "Whats the trick to not falling in lava every time",
    "I feel like the game is watching me specifically",
    "The ender dragon looked at me like it knew me",
    "I accidentally punched the admin how do I explain",
    "I have 400 dirt and genuinely no plan whatsoever",
    "Is there a mode where mobs are less murdery",
    "What does the ender eye do I threw all 12 mine",
    "I crafted a hoe by accident three times now",
    "Can we be friends I promise I wont be a liability",
    "I know I keep dying but I feel like Im getting worse",
    "The void found me again I do not know how it found me",
    "I told the admin it was lag but it was not lag",
    "The admin knows it was not lag he has logs",
    "Do the logs show everything like everything everything",
    "I need you to tell me the logs dont show everything",
    "Hey so the logs show everything apparently",
    "Im building something special it is a dirt cube",
    "The dirt cube is done I am going to live in it",
    "The dirt cube has been griefed I am not okay",
    "I tried to make a friend today it was a zombie",
    "The zombie was not friendly I was surprised",
    "My kill death ratio is 0.003 is that okay",
    "I died to a chicken I dont want to talk about it",
    "Actually I do want to talk about it the chicken won",
    "I reported the chicken to the admin",
    "The admin said chickens cannot be banned",
    "The chicken is still here we make eye contact",
    "I think the chicken remembers what happened",
    "The chicken is watching me build my second dirt cube",
    "The chicken just clucked it was judgmental",
    "The chicken and I have reached an uneasy peace",
    "The chicken broke the peace I should not have trusted it",
    "I trusted the chicken and this is what happened",
    "The chicken has my stuff now I cannot explain how",
    "Gerald the pig is outperforming me this is fine",
    "Gerald has more kills than me I am going to be sick",
    "I think Gerald should take my spot on the server",
    "Gerald agrees with this assessment apparently",
    "Gerald has applied for my whitelist spot",
    "The admin is considering Geralds application",
    "Gerald got approved I need a moment",
    "Gerald has my account now this seems fair actually",
    "Dude why the fuck do you suck so much",
    "Holy shit you are actually incompetent",
    "I just watched you die to the same lava AGAIN",
    "What the absolute fuck was that",
    "How are you this fucking bad at a game",
    "Bro did you seriously just punch the chicken",
    "The chicken is going to destroy you I swear",
    "You know what youre actually fucking hopeless",
    "I cannot watch this anymore this is painful",
    "Why do you keep doing the same stupid shit",
    "The admin is losing his mind over your deaths",
    "We have a death counter just for you",
    "Your shit is legendary here in the worst way",
    "Honestly youre kind of the servers mascot",
    "The mascot of absolute fucking failure",
    "Did you seriously try to negotiate with a creeper",
    "The creeper explosion was your fault not lag",
    "Everyone has the logs stop making shit up",
    "Your unban appeals are physically painful to read",
    "They keep getting rejected because youre actually bad",
    "Not because youre being targeted youre just shit",
    "The void didnt target you you walked into it",
    "The void was just chilling you invited yourself",
    "Jesus Christ dude just install peaceful mode",
    "Nothing is changing if youre still this fucking useless",
    "Gerald the pig is making us all look bad standing next to you",
    "The fucking chicken has more server respect than you",
    "Even the mobs are embarrassed for you at this point",
    "Admin said you single handedly justified a grief rollback",
    "Your dirt cubes are getting wiped weekly now",
    "This is the servers charity project at this point",
}

local conspiracy_theories = {
    "Your base coords sold to 3 rival factions",
    "The warden does not hate everyone. Just you.",
    "Your ping is high because you are bad. Not the server.",
    "Herobrine is real and he pities you specifically.",
    "The pillagers have your coords and are concerned.",
    "Your iron golem filed a restraining order against you.",
    "The villagers gossip about you. Every day.",
    "The ender dragon recognized you and audibly sighed.",
    "Your wolf died on purpose. It chose death over you.",
    "The skeleton changed its target specifically to you.",
    "Your farm is sentient. It has demands. You haven't read them.",
    "The nether portal has been rerouting itself to spite you.",
    "Dream watched your gameplay footage and wept openly.",
    "Endermen hold annual conferences about you specifically.",
    "The creeper family knows where you respawn.",
    "Server logs: a folder named 'This Guy Again'.",
    "Your chunks load slower because the server is tired of you.",
    "The respawn screen is your most-visited location.",
    "Notch coded a struggling-player alert. You trigger it 24/7.",
    "The stronghold was never in that direction.",
    "You caused the grief-detection plugin to be created.",
    "The admin's folder of screenshots: 'Exhibit A through ZZZZ'.",
    "The wandering trader actively routes around your coordinates.",
    "Your crafting history was submitted to a medical journal.",
    "The bats are not neutral. They observe and report back.",
    "You disturbed that ancient city. 8000 years of silence.",
    "The dragon has more kills on this server than you do.",
    "That gravel was load-bearing. You caved the entire cave.",
    "Your skin was reported to Mojang by a passing enderman.",
    "The blaze was afraid of you for 0.3 seconds. Got over it.",
    "Server TPS tanks every time you open your inventory.",
    "The iron golem you killed was the village's therapist.",
    "Same lava. It tracked you. Found you. Took your stuff.",
    "Your XP bar drops on bad decisions. Always empty. Always.",
    "The phantom was born specifically from YOUR sleep debt.",
    "Every time you die, a villager gains 1 IQ point.",
    "The wither knows your name. It said it. Out loud.",
    "The void does not pull everyone with equal force. Just you.",
    "The entire server has a running bet on your next death cause.",
    "Current favorite: 'own dirt block, somehow, no explanation'.",
    "Gerald the pig has more server clout than you do now.",
    "The admin uses your death count as his WiFi password.",
    "The lava has a nickname for you. It's not flattering.",
    "The stronghold was nearby. You turned the wrong direction.",
    "The endermen call you 'the one who stares'. With contempt.",
    "You are Case Study 7 in the admin's server management guide.",
    "The skeleton that killed you has a name. It named itself after you.",
    "The chicken does not forgive. The chicken does not forget.",
    "Gerald has been quietly accumulating your items for weeks.",
    "The void has your home coordinates saved.",
    "Mojang is actively making the game harder just for you.",
    "Your IP address is flagged as 'skill issue' in the core code.",
    "The random number generator is biased against fucking you.",
    "Lava literally seeks you out. It has your scent.",
    "Every skeleton in the server has your face as target practice.",
    "Creepers specifically request to raid your area.",
    "The warden can hear your exact thoughts. They are shit.",
    "Phantoms have your sleep schedule memorized. No sleep.",
    "The void is sentient. It knows you personally. Hates you.",
    "Admin has a folder just titled YOUR FUCKUPS (47GB).",
    "Your death compilation video is used in staff meetings.",
    "As an example of what not to do. Ever.",
    "The server's lag spikes correlate exactly with your respawns.",
    "When you are not online the server runs at 20TPS.",
    "When you join it instantly drops to 2TPS.",
    "The server literally suffers when you exist on it.",
    "Your PC fan is louder when you play. The game knows.",
    "Mojang monitors your account specifically for new bugs.",
    "Your deathlog is used in Java error classes now.",
    "You have inspired three new admin plugins.",
    "All designed to contain your fuckery specifically.",
    "The respawn screen added a special zone for your name.",
    "It loads first. As a priority.",
    "Gerald the pig actually has admin access to the server.",
    "Gerald runs the economy. Gerald is winning.",
    "The chicken submitted a formal complaint. It was 93 pages.",
    "The chicken case is now criminal. Your fault.",
    "The void made a TikTok account. It is about you.",
    "@thevoid_hatesu is trending. It is you.",
    "The server literally has a #you-fucked-up-again channel.",
    "It updates every time you spawn.",
    "Admin bets money on your next death time.",
    "The payout is better than the weekly lottery.",
    "You are funding the admin's retirement through pure incompetence.",
    "The chicken is saving for a house from your donations.",
    "The chicken has a better 401k than you.",
    "Gerald is going to college on your failure tuition.",
}

local fake_achievements = {
    {n="How Did We Get Here?",     d="Every effect. Dirt hut. Zero plan."},
    {n="Taking Inventory",          d="Opened inventory. That is the bar."},
    {n="Who Is Cutting Onions?",    d="Base lost to creeper. 9th this month."},
    {n="Cover Me in Debris",        d="Netherite in lava. Overworld. HOW."},
    {n="Adventure Time",            d="Touched grass. Immediately went back."},
    {n="Serious Dedication",        d="Crafted a hoe. Tombstone: Had A Hoe."},
    {n="Is It a Bird?",             d="Died to phantom watched 90 seconds."},
    {n="The End?",                  d="Fell in void reaching portal. Twice."},
    {n="Free the End",              d="One-shot by dragon. Pre-lap. Silence."},
    {n="Arbalistic",                d="Missed every shot. Mob was stationary."},
    {n="Star Trader",               d="16 emeralds for 1 dirt. No regrets."},
    {n="A Throwaway Joke",          d="Only trident thrown into lava. Gone."},
    {n="Sniper Duel",               d="Headshot by skeleton. Render distance."},
    {n="Getting Wood",              d="Punched a tree. That's it. Nothing."},
    {n="We Need to Go Deeper",      d="Entered nether. Died. Left confused."},
    {n="Hidden in the Depths",      d="Found deep dark. Woke warden. Dead."},
    {n="Friend in Me",              d="Tamed a wolf. Wolf died. Grief: long."},
    {n="When Pigs Fly",             d="Rode pig off cliff. Your idea entirely."},
    {n="Subspace Bubble",           d="Lost in nether. More lost finding exit."},
    {n="The Haggler",               d="Negotiated with a pillager. Died."},
    {n="Sticky Situation",          d="Stepped in cobweb. Died in cobweb."},
    {n="Who's the Pillager Now",    d="Raided a village. Raided back. Worse."},
    {n="Hot Topic",                 d="Built in nether. On magma. Purpose."},
    {n="Feels Like Home",           d="More time at respawn than in world."},
    {n="Enchanter",                 d="Used enchanting. Got Bane Arthropods."},
    {n="Cover Me With Diamonds",    d="Died in full diamond. To a bat. HOW."},
    {n="Withering Heights",         d="Spawned wither in own base. Accident."},
    {n="The Deep End",              d="Drowned in 2-block puddle. Unexplained."},
    {n="The Dirt Cube",             d="Built a dirt cube. Moved in. Content."},
    {n="Chicken Chaser",            d="Lost combat to chicken. Disputed it."},
    {n="Gerald's Rival",            d="Competed with Gerald. Gerald won."},
    {n="Diplomatic Incident",       d="Punched the iron golem. On purpose."},
    {n="Speed is Key",              d="Fell in same lava twice in 30 seconds."},
    {n="I Am Speed",                d="Same lava. Three times. One minute."},
    {n="Not Today",                 d="Logged off as warden extended its arm."},
    {n="Ringing Endorsement",       d="Gerald applied for your server spot."},
    {n="Promotion",                 d="Gerald got your spot. You watched."},
    {n="Acceptance",                d="You agreed it was fair. It was fair."},
}

local fake_errors = {
    "KERNEL_SKILL_ISSUE",
    "BRAINCELL_PAGE_FAULT",
    "IRQL_NOT_LESS_OR_EQUAL_TO_SKILL",
    "CRITICAL_COPE_FAILURE",
    "DRIVER_OVERRAN_STACK_OF_BAD_PLAYS",
    "SYSTEM_THREAD_EXCEPTION_NOT_HANDLED",
    "MEMORY_CORRUPTION_BY_STUPIDITY",
    "BAD_POOL_CALLER_BAD_AT_GAME",
    "INACCESSIBLE_BOOT_DEVICE_INACCESSIBLE_SKILL",
    "DPC_WATCHDOG_VIOLATION_OF_DECENCY",
    "PAGE_FAULT_IN_NONPAGED_SKILL_AREA",
    "CLOCK_WATCHDOG_TIMEOUT_OF_PATIENCE",
    "MANUALLY_INITIATED_SKILL_ISSUE",
    "WHEA_UNCORRECTABLE_PLAY",
    "VIDEO_FATAL_ERROR_IN_JUDGMENT",
    "KMODE_EXCEPTION_NOT_HANDLED_EVER",
    "APC_INDEX_MISMATCH_WITH_REALITY",
    "CRITICAL_STRUCTURE_CORRUPTION",
    "HYPERVISOR_ERROR_IN_DECISION_MAKING",
    "ATTEMPTED_WRITE_TO_READONLY_SKILL",
    "REFERENCE_TO_BRAIN_NOT_FOUND",
    "UNEXPECTED_STORE_EXCEPTION_DYING_AGAIN",
    "FATAL_SYSTEM_ERROR_IN_YOUR_PLAYS",
    "THREAD_STUCK_IN_LAVA_AGAIN",
    "POWER_STATE_FAILURE_TO_BE_GOOD",
    "DRIVER_CORRUPTED_POOL_OF_TALENT",
    "BAD_OBJECT_HEADER_BAD_OBJECT_PLAYER",
    "EMPTY_THREAD_WHERE_SKILL_SHOULD_BE",
    "SYSTEM_SERVICE_EXCEPTION_TO_EVERYTHING",
    "VOID_PROXIMITY_FATAL_ATTRACTION_ERROR",
    "FUCKED_UP_CORE_DUMP_SYSTEM_FAILURE",
    "CRITICAL_SHIT_DECISION_ERROR",
    "GODDAMN_MEMORY_LEAK_IN_BRAIN",
    "FUCK_UP_EXCEPTION_NOT_CAUGHT",
    "SHIT_PILE_BUFFER_OVERFLOW",
    "COCKUP_PARAMETER_ERROR",
    "FUCKWIT_PROCESS_TERMINATED",
    "ASS_CLOWN_MEMORY_CORRUPTION",
    "BULLSHIT_EXCEPTION_THROWN",
    "DICK_WAFFLE_THREAD_FAILURE",
    "TWAT_KERNEL_PANIC_IMMINENT",
    "SHIT_REFERENCE_POINTER_NULL",
    "FUCKHEAD_STACK_SMASHING_DETECTED",
    "RETARD_FLAG_NOT_SET",
    "ASSMONGER_RESOURCE_EXHAUSTED",
    "COCKSWAGGLE_DEADLOCK_DETECTED",
}

local fake_processes = {
    "minecraft.exe","hopium_pump.dll","skill_issue.sys",
    "cope.bat","delete_skills.exe","refund_request.exe",
    "dirt_palace.dll","keyboard_gamer.exe","lava_walk.bat",
    "void_tourism.sys","XRay_legit.dll","admin_please.exe",
    "unban_appeal_v11.docx","tutorial_skipped.dll",
    "gravel_denier.sys","bed_ignorer.bat","torch_skipper.exe",
    "hotbar_roulette.sys","sprint_toggler.bat",
    "fall_damage_surprise.exe","enchant_starer.dll",
    "furnace_watcher.sys","creeper_diplomat.exe",
    "skeleton_negotiator.dll","warden_hugger.bat",
    "lava_trust.exe","diamonds_where.sys",
    "xp_where.dll","respawn_cached.exe",
    "inventory_chaos.sys","chest_avoider.dll",
    "grass_touching.exe (NEVER RUNS)",
    "skill_acquisition.dll (NOT FOUND)",
    "self_awareness.exe (0KB NEVER LAUNCHED)",
    "cope_infinite_loop.sys",
    "gerald_fan_club.exe",
    "alt_account_v6.bat",
    "lava_friendship.dll",
    "void_tour_booking.exe",
    "chicken_diplomat.exe (FAILED)",
    "dirt_hoarding_scheduler.sys",
    "unban_attorney.exe (IMAGINARY)",
    "fuck_up_manager.exe (CRITICAL)",
    "bullshit_compiler.dll (ALWAYS ON)",
    "shit_decision_engine.sys (OVERDRIVE)",
    "asshole_coordinator.bat (100% USAGE)",
    "fuckwit_process_multiplier.exe (MAXIMUM)",
    "dogshit_optimizer.dll (PERMANENTLY BROKEN)",
    "absolute_idiot_kernel.sys (FATAL CRASH LOOP)",
    "cock_up_monitor.exe (WATCHING YOU FAIL)",
    "failure_multiplier.dll (x999999)",
    "incompetence_accelerator.bat (FULL SPEED)",
    "braincell_eater.exe (STARVING)",
    "skill_destroyer.sys (OBLITERATION MODE)",
    "respect_eraser.dll (OPERATION SUCCESSFUL)",
    "dignity_vacuum.exe (EMPTY)",
    "hope_killer.bat (EXTINCT)",
    "future_destroyer.sys (ACTIVATED)",
    "sweat_producer.dll (HYPERDRIVE)",
    "panic_inducer.exe (MAXIMUM VOLUME)",
    "ragequit_timer.bat (COUNTDOWN)",
    "despair_amplifier.sys (BOOSTED)",
}

local colors_list = {
    colors.red, colors.orange, colors.yellow, colors.lime,
    colors.lightBlue, colors.cyan, colors.purple, colors.magenta,
    colors.pink, colors.white,
}

local ascii_skull = {
    "   ___   ",
    "  /   \\  ",
    " | o o | ",
    " |  ^  | ",
    " | --- | ",
    "  \\___/  ",
}

local function rnd(t) return t[math.random(1, #t)] end
local function genInsult()  return rnd(adj) .. " " .. rnd(noun) end
local function genDouble()  return rnd(adj) .. ", " .. rnd(adj) .. " " .. rnd(noun) end
local function genTriple()  return "CERTIFIED " .. rnd(adj) .. ", " .. rnd(adj) .. " " .. rnd(noun) end

-- ============================================================
-- ============================================================
-- ============================================================
-- AUDIO ENGINE: STREAMING + GC TRAP FALLBACK
-- ============================================================
--
-- PRIMARY:  Streams DFPWM audio from a self-hosted Python server
--           running on your PC.  Drop any music file in the server's
--           music/ folder; it transcodes via ffmpeg automatically.
--
-- FALLBACK: If the server isn't reachable, plays the GameCube startup
--           trap remix using CC's built-in note synthesis instead.
--
-- SETUP:
--   1. Run music_server.py on your PC (needs ffmpeg in PATH).
--   2. Set SERVER below to your PC's local IP, e.g.:
--        "http://192.168.1.42:4800"
--      (the server prints the exact line to copy on startup)
--   3. Requires CC:Tweaked >= 1.100.0  (adds speaker.playAudio +
--      cc.audio.dfpwm).  Check with: print(CC_VERSION) in a terminal.
-- ============================================================
local function audioLoop()
    if #speakers == 0 then while true do os.sleep(1) end end

    --- ── CONFIG ──────────────────────────────────────────────────────
    local SERVER  = "https://residency-muster-bulge.ngrok-free.dev"
    local VOLUME  = 3.0   -- Max this out so we know it works
    local CHUNK   = 16 * 1024

    -- ── HELPERS ─────────────────────────────────────────────────────
    local function checkServer()
        local ok = http.get(SERVER .. "/status", {["ngrok-skip-browser-warning"]="true"})
        if ok then ok.close(); return true end
        return false
    end

    local function getTracks()
        local r = http.get(SERVER .. "/tracks", {["ngrok-skip-browser-warning"]="true"})
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
        local res, err = http.get(url, {["ngrok-skip-browser-warning"]="true"}, true)
        
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
                -- Math for signed 8-bit
                if b > 127 then b = b - 256 end
                pcm[i] = b
            end

            -- THE FIX: Do NOT wait for the buffer to empty. 
            -- Just yield 2 ticks so it drains slightly, then top it back up.
            while not speakers[1].playAudio(pcm, VOLUME) do
                os.sleep(0.1) 
            end
        end

        res.close()
        speakers[1].stop()
    end
        end

        res.close()
        
        -- Drain the last few milliseconds before loading the next track
        os.pullEvent("speaker_audio_empty")
    end

    -- ── GC TRAP FALLBACK ────────────────────────────────────────────
    -- Used when the music server isn't running.
    -- Full GameCube startup jingle (4 phases) then infinite trap loop.

    local function n(inst, vol, pitch)
        for _, s in pairs(speakers) do
            pcall(function()
                s.playNote(inst, vol, math.max(0, math.min(24, pitch)))
            end)
        end
    end

    local t = 0.107  -- 16th note at 140 BPM

    local function gc_slam()
        n("basedrum",3.0,8); n("bass",3.0,8)
        n("bit",1.5,8); n("didgeridoo",2.0,8)
        os.sleep(t*7)
    end

    local function gc_pings()
        for _,pd in ipairs({{p=8,v=1.4},{p=12,v=1.65},{p=15,v=1.9}}) do
            n("chime",pd.v,pd.p); n("iron_xylophone",pd.v*0.4,pd.p)
            os.sleep(t*1.5)
            n("chime",pd.v+0.1,pd.p); n("iron_xylophone",pd.v*0.45,pd.p)
            os.sleep(t*2.5)
        end
        os.sleep(t)
    end

    local function gc_arpeggio()
        local seq={{p=8,v=2.0,gap=t*3},{p=12,v=2.1,gap=t*2.5},
                   {p=15,v=2.3,gap=t*2},{p=20,v=2.5,gap=t*1.5}}
        for _,e in ipairs(seq) do
            n("chime",e.v,e.p); n("iron_xylophone",0.8,e.p)
            if e.p>=15 then n("bell",e.v-0.8,e.p) end
            os.sleep(e.gap)
        end
    end

    local function gc_ding()
        n("chime",3.0,24); n("bell",2.5,24)
        n("iron_xylophone",2.0,24); n("pling",1.3,24)
        os.sleep(t*20)
    end

    local function gc_hook()
        n("chime",1.8,15); n("iron_xylophone",0.6,15); os.sleep(t*2)
        n("chime",2.0,20); n("bell",1.3,20); n("iron_xylophone",0.8,20); os.sleep(t*2)
        n("chime",2.5,24); n("bell",2.0,24); n("iron_xylophone",1.3,24); os.sleep(t*4)
    end

    local kick  = {1,0,0,0, 0,0,1,0, 1,0,0,1, 0,0,0,0}
    local snare = {0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0}

    local function fallbackBeat()
        gc_slam(); gc_pings(); gc_arpeggio(); gc_ding()
        local bar = 0
        while true do
            bar = bar + 1
            local is_hook = (bar%8==5)
            local is_roll = (bar%4==0)
            for step=1,16 do
                n("hat", step%4==1 and 0.9 or 0.55, 12)
                if kick[step]==1 then
                    n("basedrum",3.0,8); n("bass",2.8,8); n("bit",0.5,8)
                end
                if snare[step]==1 then n("snare",2.2,12) end
                if is_hook and step==9 then gc_hook(); break
                elseif is_roll and step==14 then
                    n("hat",1.0,16); os.sleep(0.05)
                    n("hat",1.0,16); os.sleep(0.05)
                    n("hat",1.0,16)
                else os.sleep(t) end
            end
        end
    end

    -- ── MAIN ────────────────────────────────────────────────────────
    os.sleep(0.5)   -- let visual loop start first

    if not checkServer() then
        print("[music] Server not found — using GC trap fallback")
        fallbackBeat()
        return
    end

    print("[music] Connected to music server at " .. SERVER)

    while true do
        local tracks = getTracks()

        if #tracks == 0 then
            print("[music] No tracks found — retrying in 15s")
            os.sleep(15)
        else
            -- Shuffle
            for i=#tracks,2,-1 do
                local j=math.random(1,i)
                tracks[i],tracks[j]=tracks[j],tracks[i]
            end
            for _,track in ipairs(tracks) do
                print("[music] Now playing: " .. track)
                streamTrack(track)
            end
        end
    end
end
-- ============================================================
-- PHASE: BSOD
-- ============================================================
local function phase_bsod()
    blast(colors.blue, colors.white)
    local mid = math.floor(h / 2)
    center(math.max(1, mid - 4), ":(")
    os.sleep(0.5)
    center(math.max(1, mid - 2), "PC encountered YOU and gave up.")
    center(math.max(1, mid - 1), "All of this is your fault.")
    os.sleep(0.6)
    for pct = 0, 100, math.random(2, 5) do
        center(math.max(1, mid + 1), pct .. "% cataloguing your mistakes  ")
        os.sleep(0.08)
    end
    center(math.max(1, mid + 1), "100% done. Embarrassing.")
    os.sleep(0.6)
    m.setTextColor(colors.lightGray)
    center(math.max(1, mid + 3), "Stop code: " .. rnd(fake_errors))
    center(math.max(1, mid + 4), "Process: " .. rnd(fake_processes))
    center(math.max(1, mid + 5), "Remedy: Touch grass. You won't.")
    os.sleep(5)
end

-- ============================================================
-- PHASE: FAKE DOX
-- ============================================================
local function phase_dox()
    blast(colors.black, colors.green)
    tw(2, 2, "[XYNIA NET INTRUSION v6.66]", 0.022)
    os.sleep(0.5)
    tw(2, 4, "FETCHING VICTIM DATA...", 0.025)
    os.sleep(0.7)
    local rows = {
        "IPv4: 192.168." .. math.random(0,5) .. "." .. math.random(2,254),
        "IPv6: fe80::dead:beef:" .. math.random(1000,9999) .. ":cafe",
        "MAC: 00:1A:2B:3C:4D:" .. math.random(10,99),
        "PC: SKILL-ISSUE-PC-" .. math.random(1000,9999),
        "BASE: X:" .. math.random(-9999,9999) .. " Z:" .. math.random(-9999,9999),
        "STASH: X:" .. math.random(-9999,9999) .. " Y:7",
        "DEATHS TODAY: " .. math.random(8,99),
        "K/D RATIO: 0.0" .. math.random(0,9),
    }
    local r = 5
    for _, l in ipairs(rows) do
        if r >= h - 4 then break end
        tw(2, r, l, 0.02)
        r = r + 1
        os.sleep(0.12)
    end
    os.sleep(0.4)
    m.setTextColor(colors.red)
    r = r + 1
    local uploads = {
        "POSTING TO #public-announcements...",
        "SELLING TO " .. math.random(3,8) .. " FACTIONS...",
        "SUBMITTING TO r/minecraftfails...",
        "EMAILING ADMIN WITH HIGHLIGHTS...",
        "ARCHIVING ON WAYBACK MACHINE...",
    }
    for _, u in ipairs(uploads) do
        if r >= h then break end
        tw(2, r, (">> " .. u), 0.028)
        r = r + 1
        os.sleep(0.55)
    end
    m.setTextColor(colors.yellow)
    if r <= h then tw(2, r, ">> DONE. CONSEQUENCES INCOMING. COPE.", 0.03) end
    os.sleep(4)
end

-- ============================================================
-- PHASE: BROWSER HISTORY
-- ============================================================
local function phase_history()
    blast(colors.blue, colors.white)
    center(2, "-- BROWSER HISTORY: EXPOSED --")
    fillRow(3, "-", colors.gray, colors.blue)
    local shuf = {}
    for _, v in ipairs(fake_history) do shuf[#shuf+1] = v end
    for i = #shuf, 2, -1 do
        local j = math.random(1, i)
        shuf[i], shuf[j] = shuf[j], shuf[i]
    end
    local row = 4
    for _, entry in ipairs(shuf) do
        if row >= h then break end
        m.setTextColor(rnd(colors_list))
        tw(2, row, ("> " .. entry), 0.012)
        row = row + 1
        os.sleep(0.15)
    end
    os.sleep(3.5)
end

-- ============================================================
-- PHASE: DISCORD DM LEAK
-- ============================================================
local function phase_discord()
    blast(colors.black, colors.magenta)
    center(2, "-- LEAKED DMs: ALL OF THEM --")
    local shuf = {}
    for _, v in ipairs(fake_dms) do shuf[#shuf+1] = v end
    for i = #shuf, 2, -1 do
        local j = math.random(1, i)
        shuf[i], shuf[j] = shuf[j], shuf[i]
    end
    local row = 4
    for _, dm in ipairs(shuf) do
        if row >= h - 1 then break end
        m.setTextColor(colors.white)
        tw(2, row, ("You: " .. dm), 0.012)
        row = row + 1
        if row >= h then break end
        m.setTextColor(colors.lightGray)
        local hr = math.random(1, 12)
        local mn = string.format("%02d", math.random(0, 59))
        local ap = math.random(0,1) == 0 and "AM" or "PM"
        tw(2, row, ("  " .. hr .. ":" .. mn .. " " .. ap .. " - Left on read"), 0.009)
        row = row + 1
        os.sleep(0.35)
    end
    os.sleep(3.5)
end

-- ============================================================
-- PHASE: ROAST GENERATOR
-- ============================================================
local function phase_roast()
    blast(colors.black, colors.white)
    for i = 1, 40 do
        m.clear()
        m.setTextColor(rnd(colors_list))
        center(math.floor(h/2) - 3, "OFFICIAL CLASSIFICATION:")
        m.setTextColor(colors.white)
        center(math.floor(h/2) - 1, "YOU ARE DECLARED A")
        m.setTextColor(colors.red)
        center(math.floor(h/2) + 1, genTriple())
        m.setTextColor(colors.lightGray)
        center(math.floor(h/2) + 3, "-- The Minecraft Tribunal")
        os.sleep(0.22)
    end
    os.sleep(2)
end

-- ============================================================
-- PHASE: MATRIX RAIN
-- ============================================================
local function phase_matrix()
    blast(colors.black, colors.lime)
    local words = {
        "L","F","NOOB","RIP","GG","COPE","RATIO","MALDING",
        "CLIPPED","VOIDED","SKILL?","WHY?","LMAO","DEAD",
        "AGAIN","REALLY?","BRO","OMG","WTF","???","LMFAO",
        "REKT","LOLOL","OMFG","YIKES","OOF","BRUTAL","HOWWW",
        "WHY","SIGH","ISSUE","F","RATIO","L","GERALD","CHICKEN",
        "LAVA","VOID","DIRT","COPE","SKILL","DEAD AGAIN",
    }
    for i = 1, 1800 do
        local rx = math.random(1, w)
        local ry = math.random(1, h)
        m.setCursorPos(rx, ry)
        m.setTextColor(rnd(colors_list))
        local r = math.random(1, 20)
        if r > 17 then
            put(rx, ry, genInsult())
        elseif r > 13 then
            put(rx, ry, rnd(words))
        else
            put(rx, ry, tostring(math.random(0, 1)))
        end
        os.sleep(0.002)
    end
    os.sleep(1)
end

-- ============================================================
-- PHASE: DVD BOUNCE
-- ============================================================
local function phase_dvd()
    blast(colors.black, colors.white)
    local bx = math.random(1, math.max(1, math.floor(w/2)))
    local by = math.random(1, math.max(1, h - 2))
    local dx, dy = 1, 1
    for i = 1, 800 do
        m.setBackgroundColor(colors.black)
        m.clear()
        bx = bx + dx
        by = by + dy
        local txt
        if     i % 100 == 0 then txt = genTriple()
        elseif i % 40  == 0 then txt = genDouble()
        else                      txt = genInsult() end
        txt = txt:sub(1, math.max(1, math.floor(w * 0.7)))
        local tlen = #txt
        if bx <= 1 or bx + tlen >= w then dx = -dx end
        if by <= 1 or by >= h then dy = -dy end
        bx = math.max(1, math.min(math.max(1, w - tlen), bx))
        by = math.max(1, math.min(h, by))
        m.setTextColor(rnd(colors_list))
        put(bx, by, txt)
        os.sleep(0.02)
    end
end

-- ============================================================
-- PHASE: SKULL / YOU DIED
-- ============================================================
local function phase_rip()
    blast(colors.black, colors.white)
    local mw = math.max(1, math.floor(w/2) - 4)
    local mh = math.max(1, math.floor(h/2) - 4)
    for flash = 1, 8 do
        m.setTextColor(flash % 2 == 0 and colors.white or colors.red)
        for i, line in ipairs(ascii_skull) do
            local y = math.max(1, mh + i - 1)
            if y <= h then put(mw, y, line) end
        end
        os.sleep(0.1)
        blast(colors.black, colors.white)
        os.sleep(0.06)
    end
    m.setTextColor(colors.red)
    for i, line in ipairs(ascii_skull) do
        local y = math.max(1, mh + i - 1)
        if y <= h then put(mw, y, line) end
    end
    local baseY = mh + #ascii_skull
    local causes = {
        "Your own fault","Definitely lag","Gravity (skill issue)",
        "A choice you made","You","Hubris",
        "The void called. You answered.",
        "The chicken","Technically the lava",
        "Gravel. It was gravel.",
        "A decision made 4 minutes ago",
        "Overconfidence","Underconfidence","Everything",
        "Physics","Spite","The universe","Gerald, indirectly",
        "You walked into it","Willful ignorance",
        "A failure to look down","Orange is apparently invisible to you",
    }
    if baseY + 1 <= h then m.setTextColor(colors.white); center(baseY + 1, "YOU DIED") end
    if baseY + 2 <= h then m.setTextColor(colors.red); center(baseY + 2, genDouble()) end
    if baseY + 3 <= h then
        m.setTextColor(colors.lightGray)
        center(baseY + 3, "Score: " .. math.random(-99999, -1))
    end
    if baseY + 4 <= h then
        center(baseY + 4, "Cause: " .. rnd(causes))
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: VIRUS SCAN
-- ============================================================
local function phase_virusscan()
    blast(colors.black, colors.green)
    tw(2, 2, "XYNIA THREAT SCANNER v9.0", 0.022)
    os.sleep(0.6)
    tw(2, 4, ("Target: C:\\Users\\" .. rnd(adj) .. "_GAMER"), 0.018)
    os.sleep(0.6)
    local threats = {
        {"SkillIssue.exe",      "CRIT - W64.NoobWare"},
        {"HopiumPump.dll",      "HIGH - Cope Injection"},
        {"XRay_NotCheat.jar",   "CRIT - It Is Cheating"},
        {"freecoins2026.exe",   "CRIT - Trojan.Brainworm"},
        {"DeleteSystem32.bat",  "CRIT - Self Destruction"},
        {"DirtHouseBldr.sys",   "LOW  - Aesthetic Crime"},
        {"LavaWalker.dll",      "HIGH - Gravity Denial"},
        {"KeyboardTurner.exe",  "MED  - 2009 Combat Style"},
        {"Cope_F2P.exe",        "HIGH - Advanced Cope"},
        {"UnbanApeal_v11.docx", "MED  - Delusional Engine"},
        {"GravelTruster.sys",   "HIGH - Physics Denial"},
        {"VoidJumper.bat",      "HIGH - Sends you to void"},
        {"AdminPlease.exe",     "MED  - Plea Broadcast"},
        {"DiamondInLava.log",   "INFO - Death log (14GB)"},
        {"AltAcctCreator.bat",  "HIGH - Ban Evasion Tool"},
        {"GeraldFanclub.exe",   "LOW  - Pig-based Cope"},
        {"LavaFriend.dll",      "CRIT - Suicidal Pathing"},
        {"ChickenDiplomat.exe", "FAIL - All negotiations failed"},
    }
    local row = 6
    for _, t in ipairs(threats) do
        if row >= h - 1 then break end
        m.setTextColor(colors.white)
        tw(2, row, (">> " .. t[1]), 0.012)
        m.setTextColor(colors.red)
        tw(2, row + 1, ("   [" .. t[2] .. "]"), 0.012)
        row = row + 2
        os.sleep(0.15)
    end
    os.sleep(0.7)
    m.setTextColor(colors.red)
    center(h, "QUARANTINE FAILED. SKILL ISSUE TOO DEEP.")
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: TASK MANAGER
-- ============================================================
local function phase_taskmanager()
    blast(colors.black, colors.white)
    center(1, "TASK MANAGER: YOUR BRAIN")
    fillRow(2, "-", colors.gray, colors.black)
    m.setTextColor(colors.lightGray)
    put(2, 3, "PROCESS          CPU  STATUS")
    fillRow(4, "-", colors.gray, colors.black)
    local procs = {
        {"cope.exe",        "97%", "NOT RESPONDING"},
        {"skill.dll",       "0%",  "NOT FOUND"},
        {"braincells.sys",  "0%",  "CRITICAL LOW"},
        {"touch_grass.exe", "0%",  "NEVER LAUNCHED"},
        {"dirt_palace.exe", "45%", "RUNNING (barely)"},
        {"xray_client.jar", "12%", "LEGIT (not legit)"},
        {"unban_v11.docx",  "8%",  "11TH ATTEMPT"},
        {"hopium.exe",      "55%", "NOT RESPONDING"},
        {"minecraft.exe",   "99%", "NOT RESPONDING"},
        {"parents_trust",   "0%",  "TERMINATED"},
        {"self_aware.exe",  "0%",  "NEVER INSTALLED"},
        {"map_reading.dll", "0%",  "CORRUPTED"},
        {"bed_usage.exe",   "0%",  "NEVER EXECUTED"},
        {"lava_trust.dll", "100%", "RUNNING (WHY)"},
        {"void_avoid.sys",  "0%",  "DISABLED"},
        {"death_log.exe",   "2%",  "LOG FILE: 14GB"},
        {"respawn.dll",     "89%", "ALWAYS ACTIVE"},
        {"dignity.sys",     "0%",  "FILE MISSING"},
        {"friends.dll",     "0%",  "LIST EMPTY"},
        {"wins.log",        "0%",  "FILE EMPTY (0B)"},
        {"gerald_fan.exe",  "3%",  "RUNNING (sad)"},
        {"chicken_cope.bat","5%",  "RUNNING"},
        {"dirt_hoard.sys",  "1%",  "DISK FULL (dirt)"},
    }
    local row = 5
    for _, p in ipairs(procs) do
        if row >= h then break end
        local isBad = p[3] == "NOT RESPONDING" or p[3] == "NOT FOUND"
        m.setTextColor(isBad and colors.red or colors.white)
        local line = string.format("%-16s %-5s %s", p[1]:sub(1,16), p[2], p[3])
        tw(2, row, line, 0.005)
        row = row + 1
        os.sleep(0.08)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: PROGRESS BARS OF SHAME
-- ============================================================
local function phase_progress()
    blast(colors.black, colors.white)
    center(2, "DIAGNOSTICS: YOU (God Help Us)")
    os.sleep(0.8)
    local checks = {
        "Checking skill level",
        "Verifying braincell count",
        "Locating redeeming quality",
        "Searching for game sense",
        "Attempting to find single W",
        "Looking for non-dirt plays",
        "Confirming basic awareness",
        "Checking lava avoidance",
        "Scanning for map knowledge",
        "Testing hunger bar awareness",
        "Verifying torch placement",
        "Checking if bed was ever used",
        "Reviewing crafting knowledge",
        "Auditing death cause variety",
        "Checking for touch of grass",
        "Locating shred of self-awareness",
        "Scanning for chicken diplomacy",
        "Verifying Gerald understanding",
    }
    local row = 4
    for _, check in ipairs(checks) do
        if row >= h - 1 then break end
        progressBar(row, check, 0.022)
        row = row + 2
        os.sleep(0.12)
    end
    os.sleep(0.8)
    m.setTextColor(colors.red)
    center(h, "DIAGNOSIS: TERMINAL. NO CURE EXISTS.")
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: SCOREBOARD OF ETERNAL SHAME
-- ============================================================
local function phase_scoreboard()
    blast(colors.black, colors.white)
    center(2, ("STATS: " .. genInsult()))
    fillRow(3, "=", colors.gray, colors.black)
    local stats = {
        {"Creeper deaths",       math.random(80, 999)},
        {"Lava deaths",          math.random(60, 700)},
        {"Fall damage deaths",   math.random(100, 900)},
        {"Own TNT deaths",       math.random(10, 300)},
        {"Skeleton deaths",      math.random(90, 1500)},
        {"Void deaths",          math.random(20, 400)},
        {"Suffocation deaths",   math.random(5, 200)},
        {"Cactus deaths (HOW)",  math.random(3, 150)},
        {"Drowned on surface",   math.random(5, 100)},
        {"Own fire deaths",      math.random(5, 80)},
        {"Chicken deaths",       math.random(1, 20)},
        {"Death by bat (wow)",   math.random(0, 5)},
        {"Diamonds lost to lava",math.random(200, 9999)},
        {"Dirt blocks placed",   math.random(5000, 99999)},
        {"Unban appeals filed",  math.random(5, 60)},
        {"Times claimed lag",    math.random(500, 9999)},
        {"Times actually lagging",math.random(0, 3)},
        {"Friends made",         math.random(0, 2)},
        {"Friends kept",         0},
        {"Times improved",       0},
        {"Total wins",           0},
        {"Times gg and meant it",0},
        {"Rating (out of 100)",  math.random(0, 3)},
    }
    local row = 4
    for _, s in ipairs(stats) do
        if row >= h then break end
        m.setTextColor(rnd(colors_list))
        tw(2, row, (s[1] .. ": " .. s[2]), 0.007)
        row = row + 1
        os.sleep(0.07)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: CONSPIRACY BOARD
-- ============================================================
local function phase_conspiracy()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.red)
    center(2, "*** CLASSIFIED INTEL: YOU ***")
    fillRow(3, "-", colors.red, colors.black)
    local shuf = {}
    for _, v in ipairs(conspiracy_theories) do shuf[#shuf+1] = v end
    for i = #shuf, 2, -1 do
        local j = math.random(1, i)
        shuf[i], shuf[j] = shuf[j], shuf[i]
    end
    local row = 4
    for _, ct in ipairs(shuf) do
        if row >= h then break end
        m.setTextColor(rnd(colors_list))
        tw(2, row, ("- " .. ct), 0.015)
        row = row + 2
        os.sleep(0.42)
    end
    os.sleep(3.5)
end

-- ============================================================
-- PHASE: ACHIEVEMENTS
-- ============================================================
local function phase_achievements()
    blast(colors.black, colors.white)
    center(2, "ACHIEVEMENT UNLOCKED (somehow)")
    os.sleep(0.8)
    local shuf = {}
    for _, v in ipairs(fake_achievements) do shuf[#shuf+1] = v end
    for i = #shuf, 2, -1 do
        local j = math.random(1, i)
        shuf[i], shuf[j] = shuf[j], shuf[i]
    end
    for _, ach in ipairs(shuf) do
        if h < 6 then break end
        local sy = math.max(2, math.min(h - 3, math.random(2, h - 3)))
        box(1, sy, w, sy + 2, colors.yellow)
        m.setTextColor(colors.yellow)
        center(sy, (">>> " .. ach.n))
        m.setTextColor(colors.lightGray)
        center(sy + 1, ach.d)
        os.sleep(2)
        blast(colors.black, colors.white)
        center(2, "ACHIEVEMENT UNLOCKED (somehow)")
        os.sleep(0.18)
    end
end

-- ============================================================
-- PHASE: SEIZURE PROTOCOL
-- ============================================================
local function phase_seizure()
    local msgs = {
        "WHAT THE FUCK ARE YOU DOING",
        "HOW ARE YOU THIS BAD",
        "STOP DYING CHALLENGE: FAILED",
        "ARE YOU ACTUALLY EVEN TRYING",
        "THIS IS PAINFUL TO WITNESS",
        "PLEASE. PLEASE JUST STOP.",
        "THE VOID WANTED YOU THERE",
        "L + RATIO + FELL IN LAVA",
        "SKILL ISSUE: FULLY CONFIRMED",
        "GET OFF THE COMPUTER",
        "IS THIS A JOKE TO YOU",
        "WHO GAVE YOU A PICKAXE",
        "THE CREEPER BEGGED YOU TO STOP",
        "JUST LOG OFF DUDE",
        "I AM GENUINELY BEGGING YOU",
        "THE LAVA MISSES YOU ALREADY",
        "WE BOTH KNOW YOU'RE GOING BACK",
        "GERALD PLAYS BETTER THAN THIS",
        "THE CHICKEN IS EMBARRASSED FOR YOU",
        "THE DIRT CUBE WAS NOT ENOUGH",
        "NOTHING HAS WORKED. NOTHING WILL.",
    }
    for i = 1, 250 do
        blast(rnd(colors_list), colors.black)
        local r = math.random(1, 6)
        if r == 1 then
            center(math.floor(h/2), genTriple())
        elseif r == 2 then
            center(math.floor(h/2) - 1, genInsult())
            center(math.floor(h/2) + 1, genInsult())
        elseif r == 3 then
            center(math.floor(h/2), rnd(msgs))
        elseif r == 4 then
            center(math.floor(h/2), genDouble())
        elseif r == 5 then
            center(math.floor(h/2) - 1, "ABSOLUTE")
            center(math.floor(h/2) + 1, genInsult())
        else
            center(math.floor(h/2), "WHAT IN THE ACTUAL FUCK")
        end
        os.sleep(0.01)
        blast(colors.black, rnd(colors_list))
        center(math.floor(h/2), ("ABSOLUTE " .. genInsult()))
        os.sleep(0.01)
    end
end

-- ============================================================
-- PHASE: NEWS TICKER
-- ============================================================
-- ============================================================
-- TICKER HELPER + 7 THEMED BREAKING NEWS SEGMENTS
-- Each plays 5-6 headlines then exits, so they feel like
-- short news flashes rather than one marathon scroll.
-- ============================================================
local function runTicker(label, headlines)
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.red)
    center(1, "*** " .. label .. " ***")
    -- pick 5-6 random headlines from the pool
    local pool = {}
    for _, v in ipairs(headlines) do pool[#pool+1] = v end
    for i = #pool, 2, -1 do
        local j = math.random(1, i)
        pool[i], pool[j] = pool[j], pool[i]
    end
    local count = math.min(#pool, math.random(5, 7))
    for i = 1, count do
        local row = math.random(2, h)
        scrollLine(row, "  >>>  " .. pool[i] .. "  <<<  ", rnd(colors_list))
    end
end

-- SEGMENT 1: DEATH DESK
local function phase_ticker_deaths()
    runTicker("DEATH DESK - LIVE", {
        "LOCAL PLAYER DIES AGAIN - CLAIMS LAG (LOGS: NO LAG)",
        "PLAYER SETS PERSONAL BEST: " .. math.random(8,30) .. " DEATHS IN ONE HOUR",
        "DEATH #" .. math.random(300,999) .. " RECORDED - ADMIN SIGHS AUDIBLY",
        "PLAYER DIES TO CACTUS - SOMEHOW - EXPERTS BAFFLED",
        "SAME SKELETON KILLS PLAYER FOR " .. math.random(4,20) .. "TH CONSECUTIVE TIME",
        "PLAYER DIES BEFORE ADMIN FINISHES TYPING 'CAREFUL'",
        "PHANTOM ATTACK SURVIVOR 'I WAS GONNA SLEEP' (0 SLEEPS THIS WEEK)",
        "PLAYER KILLED BY OWN TORCH PLACEMENT - SCIENCE SILENT",
        "DEATH BY BAT CONFIRMED - ENTIRE SERVER WITNESSES IT",
        "PLAYER SUFFOCATES IN DIRT CUBE - THEIR OWN DIRT CUBE",
        "FALL DAMAGE CLAIMS PLAYER WHO WAS 'JUST LOOKING' AT CLIFF",
        "DROWNED IN PUDDLE - TWO BLOCKS DEEP - NO COMMENT FROM PLAYER",
        "PLAYER DIES TO OWN TNT - CLAIMS CREEPER INVOLVED - NO CREEPER FOUND",
        "PLAYER KILLED BY CHICKEN - CORONER CONFIRMS - CHICKEN DECLINES INTERVIEW",
        "RESPAWN SCREEN BECOMES PLAYER'S PRIMARY RESIDENCE THIS WEEK",
        "PLAYER RUNS TOWARD EXPLOSION SOUND - DIES - SHOCKED",
        "SCIENTIST CONFIRMS: PLAYER IS ACTIVELY GETTING WORSE OVER TIME",
        "NETHERITE ARMOUR LOST IN LAVA - IN THE OVERWORLD - HOW",
        "PLAYER DIES WHILE CRAFTING ANOTHER HOE - TRAGIC IRONY",
    })
end

-- SEGMENT 2: THE GERALD / CHICKEN SITUATION
local function phase_ticker_gerald()
    runTicker("GERALD & CHICKEN BUREAU", {
        "GERALD THE PIG OUTRANKS PLAYER ON ALL METRICS - OFFICIAL",
        "GERALD APPLIES FOR PLAYER'S WHITELIST SPOT - ADMIN CONSIDERING",
        "GERALD APPROVED - BETTER K/D RATIO CITED AS PRIMARY FACTOR",
        "CHICKEN DEFEATS PLAYER IN 1V1 - REMATCH REQUEST DENIED BY CHICKEN",
        "CHICKEN AND GERALD FORMALISE ALLIANCE - PLAYER NOT INVITED",
        "ALLIANCE DIRECTS FULL RESOURCES TOWARD ONE TARGET: THE PLAYER",
        "GERALD HAS MORE SERVER DIAMONDS THAN THE PLAYER - NOT CLOSE",
        "CHICKEN FILES FORMAL GRIEVANCE WITH ADMIN - 93 PAGE DOCUMENT",
        "ADMIN READS CHICKEN DOCUMENT - AGREES WITH MOST OF IT",
        "PLAYER SPOTS CHICKEN - RETREATS - CHICKEN DOES NOT PURSUE (DOESN'T NEED TO)",
        "CHICKEN STANDOFF ENTERS WEEK " .. math.random(2,8) .. " - NO END IN SIGHT",
        "CHICKEN DEMANDS WHEAT - PLAYER OFFERS DIRT - CHICKEN OFFENDED",
        "GERALD GIVEN PLAYER'S ACCOUNT ACCESS - GERALD DECLINES (HAS STANDARDS)",
        "PLAYER NAMES HOG 'GERALD 2' - ORIGINAL GERALD ISSUES STATEMENT",
        "GERALD'S STATEMENT: 'I HAVE CONCERNS' - PUBLISHED IN FULL",
        "CHICKEN SEEN MEASURING PLAYER'S DIRT CUBE - INTENTIONS UNCLEAR",
        "GERALD HOSTS SERVER MEETING - PLAYER NOT INVITED - PRODUCTIVE",
        "ANNUAL GERALD APPRECIATION DAY ANNOUNCED - PLAYER NOT MENTIONED",
        "CHICKEN WINS SERVER MVPE AWARD (MOST VALUABLE POULTRY ENTITY)",
        "PLAYER VOTED 'LEAST LIKELY TO IMPROVE' FOR 3RD CONSECUTIVE MONTH",
    })
end

-- SEGMENT 3: ADMIN DESK / LOGS / APPEALS
local function phase_ticker_admin()
    runTicker("ADMIN DESK - BREAKING", {
        "UNBAN APPEAL #" .. math.random(8,55) .. " DENIED - ADMIN QUOTES 'PLEASE STOP SENDING THESE'",
        "SERVER LOGS CONFIRM: ZERO LAG DURING ANY OF THE " .. math.random(300,900) .. " DEATHS",
        "ADMIN OPENS SCREENSHOT FOLDER - FOLDER TITLED 'THIS FUCKING GUY'",
        "FOLDER SIZE: " .. math.random(4,47) .. "GB - GROWING DAILY",
        "PLAYER'S IP ADDRESS FLAGGED AS 'CHRONICALLY MISGUIDED' IN SERVER CONFIG",
        "ADMIN INSTALLS DEDICATED PLUGIN JUST TO TRACK THIS ONE PLAYER",
        "PLUGIN CRASHES UNDER LOAD - DEATH COUNT TOO HIGH FOR 32-BIT INTEGER",
        "ADMIN PATCHES PLUGIN - UPGRADES TO 64-BIT INTEGER - JUST IN CASE",
        "GRIEF DETECTION LOG: " .. math.random(80,300) .. "% OF ENTRIES ARE THIS PLAYER",
        "PLAYER FILES COMPLAINT ABOUT THE GRIEF LOG - COMPLAINT ADDED TO GRIEF LOG",
        "UNBAN APPEAL CITES 'LAG' AS CAUSE - ADMIN PASTES LOG SHOWING NO LAG",
        "PLAYER CLAIMS LOG IS DOCTORED - ADMIN SENDS ORIGINAL - PLAYER OFFLINE",
        "ADMIN CREATES DEDICATED #you-died-again CHANNEL - GETS 200 MESSAGES DAY ONE",
        "SERVER RULES UPDATED: RULE 14 ADDED - NAMED AFTER SPECIFIC INCIDENT",
        "INCIDENT NOT DESCRIBED IN RULE 14 - TOO EMBARRASSING TO DOCUMENT",
        "ADMIN SUPPORT TICKET VOLUME UP " .. math.random(200,800) .. "% - ONE PLAYER RESPONSIBLE",
        "PLAYER'S APPEAL FORM NOW AUTO-FILLS 'SKILL ISSUE' IN REASON FIELD",
        "ADMIN BETS ON PLAYER DEATH CAUSE - WINNINGS FUND SERVER UPGRADES",
    })
end

-- SEGMENT 4: LAVA / VOID / NETHER INCIDENTS
local function phase_ticker_lava()
    runTicker("LAVA & VOID CORRESPONDENT", {
        "LAVA CLAIMS DIAMOND HAUL - " .. math.random(5,64) .. " DIAMONDS LOST - OWNER BLAMES GAME",
        "SAME LAVA FINDS PLAYER FOR " .. math.random(4,12) .. "TH TIME - SCIENTISTS CANNOT EXPLAIN",
        "LAVA RELEASES STATEMENT: 'WE DIDN'T GO TO THEM'",
        "VOID SENDS PLAYER FORMAL WRITTEN NOTICE: 'SEE YOU SOON'",
        "PLAYER RESPONDS TO VOID: 'NOT TODAY' - VOID: 'IT IS TODAY'",
        "VOID CONFIRMED CORRECT - PLAYER CONFIRMED IN VOID",
        "NETHER PORTAL GRANTED REASSIGNMENT AWAY FROM PLAYER'S COORDS",
        "PORTAL CITES 'HOSTILE WORK ENVIRONMENT' IN TRANSFER REQUEST",
        "PLAYER ARGUES WITH LAVA - LAVA DOES NOT RESPOND - WINS ANYWAY",
        "LAVA NICKNAMES PLAYER - NICKNAME NOT SUITABLE FOR BROADCAST",
        "PLAYER WALKS INTO LAVA WHILE READING SIGN THAT SAYS DO NOT",
        "SIGN SPECIFICALLY SAID DO NOT WALK INTO LAVA - PLAYER WALKED INTO LAVA",
        "PLAYER FALLS INTO VOID ATTEMPTING TO THROW SOMETHING INTO VOID",
        "IRONY NOTED - PLAYER DID NOT NOTE THE IRONY",
        "NETHER EXPEDITION FAILS IN " .. math.random(8,90) .. " SECONDS - NEW RECORD",
        "LAVA FORMALLY REQUESTS PLAYER STOP VISITING - PLAYER CANNOT STOP",
        "VOID OPENS LOYALTY PROGRAMME FOR FREQUENT FALLERS - PLAYER: GOLD MEMBER",
        "MAGMA BLOCK INJURY REPORT: PLAYER CONFUSED IT FOR REGULAR STONE AGAIN",
        "FIRE DAMAGE CLAIM: PLAYER 'DID NOT KNOW FIRE SPREADS' - " .. math.random(3,15) .. "TH TIME",
    })
end

-- SEGMENT 5: DIRT / BASE / SERVER ECONOMY
local function phase_ticker_dirt()
    runTicker("DIRT & ECONOMY WATCH", {
        "PLAYER HAS " .. math.random(10000,99999) .. " DIRT BLOCKS - NO PLAN - SITUATION DEVELOPING",
        "SERVER ECONOMY DESTABILISED - TOO MUCH DIRT IN CIRCULATION - ONE SOURCE",
        "DIRT CUBE GRIEFED AGAIN - OWNER REBUILDING - SAME DESIGN - LEARNING: NONE",
        "PLAYER INSISTS NEW DIRT CUBE IS 'COMPLETELY DIFFERENT' - IT IS NOT",
        "DIRT CUBE STRUCTURAL ASSESSMENT: FAILING - PLAYER UNCONCERNED",
        "ARCHITECT REVIEWS DIRT CUBE - WEEPS - REFUSES TO COMMENT FURTHER",
        "PLAYER ADDS SECOND FLOOR TO DIRT CUBE - FLOOR IS ALSO DIRT",
        "PLANNING PERMISSION DENIED FOR DIRT CUBE - BUILT ANYWAY",
        "COUNCIL ORDERS DEMOLITION - CREEPER ALREADY HANDLED IT",
        "PLAYER COMMISSIONS DIRT CUBE EXPANSION - BUDGET: DIRT",
        "INTERIOR DESIGNER VISITS DIRT CUBE - DOES NOT RETURN",
        "DIRT CUBE LISTED ON TRIPADVISOR - AVERAGE RATING: 1.1 STARS",
        "TOP REVIEW: 'THE FLOOR WAS A HOLE. I FELL IN THE FLOOR.'",
        "PLAYER DESCRIBES BASE AS 'RUSTIC' - ADMIN DESCRIBES IT AS 'A VIOLATION'",
        "VILLAGE ISSUES RESTRAINING ORDER - PLAYER MUST STAY 50 BLOCKS AWAY",
        "STRONGHOLD SEARCH ENTERS DAY " .. math.random(3,21) .. " WITH ZERO LEADS",
        "PLAYER STILL WALKING IN WRONG DIRECTION - CONFIDENT ABOUT IT",
        "IRON GOLEM RETIRES EARLY - CITES 'MORAL INJURY' - PLAYER NAMED IN STATEMENT",
    })
end

-- SEGMENT 6: SPORTS DESK (play-by-play style)
local function phase_ticker_sports()
    runTicker("SMP SPORTS DESK", {
        "PLAYER LOSES 1V1 TO MOB TIER: CHICKEN - ODDS WERE " .. math.random(1,5) .. ":1 AGAINST",
        "SEASON STATS: " .. math.random(300,999) .. " DEATHS / 0 WINS - ANALYSTS CALL IT 'HISTORIC'",
        "KILL/DEATH RATIO DROPS TO 0.00" .. math.random(1,9) .. " - NEW PERSONAL WORST",
        "PLAYER FINISHES LAST IN EVERY SERVER CATEGORY - PODIUM SWEEP",
        "COMMENTATOR FALLS SILENT WATCHING PLAYER'S LAST RUN - 47 SECONDS",
        "REPLAY SHOWS PLAYER SAW THE LAVA - WALKED IN ANYWAY - ANALYSTS BAFFLED",
        "HALF-TIME STATS: " .. math.random(5,25) .. " DEATHS - " .. math.random(0,1) .. " KILLS - 1 HOE (ACCIDENTAL)",
        "POST-MATCH INTERVIEW: PLAYER BLAMES LAG - INTERVIEWER SHOWS LOGS",
        "PLAYER DISQUALIFIED FROM OWN SPEEDRUN FOR DYING TOO MUCH",
        "DEATH MONTAGE SUBMITTED TO SERVER HALL OF SHAME - ACCEPTED IMMEDIATELY",
        "RIVAL FACTIONS STOP FIGHTING EACH OTHER TO WATCH PLAYER DIE",
        "TRUCE HOLDS FOR " .. math.random(10,60) .. " MINUTES - EVERYONE WATCHING SAME PLAYER",
        "PLAYER RANKED LAST ON EVERY LEADERBOARD INCLUDING ONES THEY AREN'T ON",
        "DRAFT PICK VALUE: NEGATIVE - TEAMS PAYING TO NOT HAVE PLAYER",
        "MVP AWARD GOES TO GERALD THE PIG - UNANIMOUS - PLAYER RECEIVED 0 VOTES",
        "CHICKEN RECEIVES HONOURABLE MENTION - PLAYER NOT MENTIONED",
        "SEASON FINALE: PLAYER VS THE LAVA - LAVA WINS - AS ALWAYS - FINAL SCORE " .. math.random(300,999) .. "-0",
    })
end

-- SEGMENT 7: WEIRD SCIENCE / LATE BREAKING
local function phase_ticker_weird()
    runTicker("LATE BREAKING // WEIRD SCIENCE", {
        "SCIENTISTS CONFIRM: PLAYER IS ACTIVELY GETTING WORSE WITH EXPERIENCE",
        "PEER-REVIEWED STUDY: PLAYER'S DECISION-MAKING 'STATISTICALLY IMPLAUSIBLE'",
        "RESEARCHERS CANNOT REPRODUCE PLAYER'S LEVEL OF BADNESS IN LAB CONDITIONS",
        "UNIVERSITY NAMES AWARD AFTER PLAYER - GIVEN ANNUALLY FOR WORST GAMEPLAY",
        "STUDY FINDS PLAYER'S CRAFTING HISTORY 'MEDICALLY INTERESTING'",
        "GEOLOGISTS DATE PLAYER'S GRUDGE AGAINST LAVA TO APPROX. " .. math.random(6,48) .. " MONTHS",
        "THERMODYNAMICS PROFESSOR REVIEWS PLAYER'S LAVA INTERACTIONS - RETIRES",
        "PHILOSOPHER PUBLISHES PAPER ON PLAYER'S REPEATED IDENTICAL DECISIONS",
        "PAPER TITLED: 'HOPE, EVIDENCE, AND THE COMPLETE ABSENCE OF LEARNING'",
        "PSYCHOLOGIST DOCUMENTS PLAYER'S RELATIONSHIP WITH DENIAL - 400 PAGES",
        "400 PAGES NOT ENOUGH - SEQUEL ANNOUNCED - PLAYER STILL PLAYING",
        "BREAKING: PLAYER STILL IN THE CAVE FROM LAST WEEK",
        "UPDATE: PLAYER FOUND A WAY OUT - WALKED INTO LAVA ON WAY OUT",
        "CONSPIRACY THEORISTS SUGGEST LAVA IS SENTIENT AND TARGETING PLAYER",
        "LAVA DECLINES TO CONFIRM OR DENY - DOES NOT NEED TO",
        "MOJANG ENGINEERS BAFFLED BY PLAYER'S ABILITY TO FIND NEW WAYS TO DIE",
        "NEW WAY FOUND TODAY: TECHNICALLY UNDOCUMENTED - PATCH INCOMING",
        "VOID PURCHASES BILLBOARD NEAR PLAYER'S BASE: 'SEE YOU SOON'",
        "PLAYER COMPLAINS BILLBOARD IS OMINOUS - VOID: 'THAT WAS THE POINT'",
    })
end

-- ============================================================
-- PHASE: EULOGY
-- ============================================================
local function phase_eulogy()
    blast(colors.black, colors.white)
    m.setTextColor(colors.lightGray)
    center(2, "IN MEMORIAM")
    center(3, string.rep("-", math.min(14, w)))
    os.sleep(0.8)
    local lines = {
        "We gather to mourn the inventory",
        ("of " .. genInsult() .. "."),
        ("Lost to lava on " .. os.date("%A") .. "."),
        "",
        "Survived by:",
        math.random(200,9000) .. " dirt blocks.",
        "1 leather boot (the left one).",
        "A half-written unban appeal.",
        "Zero diamonds.",
        "",
        "The diamonds chose the lava.",
        "We understand why.",
        "",
        "Please learn to avoid lava.",
        "It is orange. It glows. Loudly.",
        "It has always been there.",
        "It is not new.",
        "",
        "Rest in pieces.",
        "Score: " .. math.random(-99999, -100),
        "Witnesses: none. Nobody came.",
        "",
        "Gerald the pig sends regards.",
        "The chicken does not.",
        "The chicken never will.",
    }
    local row = 4
    for _, line in ipairs(lines) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(colors.white)
            center(row, line)
            row = row + 1
        end
        os.sleep(0.22)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: WARDEN WARNING
-- ============================================================
local function phase_warden()
    blast(colors.black, colors.red)
    center(2, "WARDEN PROXIMITY ALERT")
    os.sleep(0.8)
    m.setTextColor(colors.orange)
    local warden = {
        "    _____    ",
        "   /     \\   ",
        "  | O   O |  ",
        "  |   ^   |  ",
        "  | ----- |  ",
        "  |       |  ",
        "   \\_____/   ",
    }
    for i, line in ipairs(warden) do
        if 2 + i <= h then center(2 + i, line); os.sleep(0.15) end
    end
    os.sleep(0.8)
    local wmsg = {
        "You placed a torch.",
        "It heard you.",
        "It always hears you.",
        "It is never not hearing you.",
        "It knows your breathing.",
        "It has learned your schedule.",
        "It waits. It is patient.",
        "Unlike you.",
        "It does not fall in lava.",
        "Unlike you.",
    }
    local row = math.max(2, h - #wmsg)
    for _, msg in ipairs(wmsg) do
        if row >= 1 and row <= h then
            m.setTextColor(colors.white)
            center(row, msg)
            row = row + 1
            os.sleep(0.4)
        end
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: LOADING SCREEN OF DOOM
-- ============================================================
local function phase_loading()
    blast(colors.black, colors.white)
    center(2, ("LOADING: " .. genInsult() .. "'S GAME"))
    local tasks = {
        "Importing bad decisions",
        "Allocating cope buffer",
        "Loading dirt textures (90%)",
        "Connecting to denial server",
        "Resetting death counter (again)",
        "Fetching respawn coordinates",
        "Calibrating lava magnetism",
        "Compiling skeleton aim data (you)",
        "Building creeper routing (target: you)",
        "Mounting inventory chaos module",
        "Establishing unban pipeline v11",
        "Loading admin block list (you: listed)",
        "Syncing gravel physics (harmful)",
        "Preparing void coordinates (yours)",
        "Packaging skill issue report (14GB)",
        "Initializing phantom spawner",
        "Scheduling next creeper encounter",
        "Archiving " .. math.random(400,999) .. " previous deaths",
        "Notifying Gerald of session start",
        "Informing chicken of your location",
    }
    local row = 4
    for _, task in ipairs(tasks) do
        if row >= h - 1 then break end
        m.setTextColor(colors.lightGray)
        tw(2, row, (task .. "..."), 0.015)
        m.setTextColor(colors.red)
        if w - 5 >= 1 then put(math.max(1, w - 5), row, " FAIL") end
        row = row + 1
        os.sleep(0.13)
    end
    os.sleep(0.8)
    m.setTextColor(colors.red)
    center(h, "ABORTED. SKILL PREREQUISITES NOT MET.")
    os.sleep(4)
end

-- ============================================================
-- PHASE: LIVE SERVER CHAT
-- ============================================================
local function phase_livechat()
    blast(colors.black, colors.white)
    center(1, "[ SERVER CHAT - UNCENSORED ]")
    fillRow(2, "-", colors.gray, colors.black)
    local names = {
        "xX_ProGamer","CreeperHunter99","AdminSteve",
        "DiamondMiner64","ServerBot","SMP_Veteran",
        "GrindMode2026","BuildMaster","LegitNotXray",
        "NightOwlSMP","HerobrineFan","GeraldThePig",
    }
    local msgs = {
        "who keeps dying at spawn lmaooo",
        "bro fell in lava AGAIN",
        "how does someone die this much",
        "I think we have a bot",
        "no thats just [PLAYER]",
        "LMAOOO they did it again",
        "can we get a death counter plugin",
        "base coords got leaked btw",
        "not hard to find. its a dirt cube.",
        "I feel bad. nope. I dont.",
        "fought the warden with a wooden sword",
        "was it enchanted at least",
        "no.",
        "...respect. tiny amount.",
        "no wait. not respect.",
        "F","F","F","F (but respectfully)",
        "bro built a house with no windows",
        "bro built a house with no door",
        "it was just a cube. of dirt.",
        "they named their pig Gerald",
        "they cannot eat pork now",
        "Gerald is outliving the player",
        "Gerald is a better gamer",
        "give Gerald admin",
        "Gerald would not fall in that lava",
        "Gerald has never died to lava",
        "Gerald has more server clout",
        "the player asked me what lava does",
        "I said it kills you",
        "they said how much",
        "I said all of your health",
        "they said ill be fine",
        "they were not fine",
        "admin welfare check please",
        "theyve been in that cave for 2 days",
        "I checked. they cannot get out.",
        "the cave is one block deep.",
        "they forgot you could dig sideways.",
        "Im going to cry",
        "Im actually crying right now",
        "the chicken incident is escalating",
        "the chicken took their stuff",
        "we dont know how. the chicken just has it.",
        "Gerald and the chicken have formed an alliance",
        "against [PLAYER]",
        "this is the best server Ive ever been on",
        "and the saddest. simultaneously.",
        "bless them.",
    }
    local row = 3
    for i = 1, math.min(#msgs, h - 3) do
        if row >= h then break end
        local name = rnd(names)
        m.setTextColor(rnd(colors_list))
        local prefix = ("<" .. name .. "> "):sub(1, 16)
        put(2, row, prefix)
        m.setTextColor(colors.white)
        put(2 + #prefix, row, msgs[i])
        row = row + 1
        os.sleep(0.28)
    end
    os.sleep(4)
end

-- ============================================================
-- PHASE: SPEEDRUN TIMER
-- ============================================================
local function phase_speedrun()
    blast(colors.black, colors.white)
    center(2, "SPEEDRUN #" .. math.random(40, 300) .. " - LIVE")
    fillRow(3, "-", colors.gray, colors.black)
    local splits = {
        {"Punch tree",       "0:00.42", false},
        {"Get crafting tbl", "0:01.90", false},
        {"Get wood",         "0:03.11", false},
        {"Find cave",        "0:24.60", false},
        {"Get iron",         "2:14.30", false},
        {"Smelt iron",       "3:01.00", false},
        {"Find lava",        "3:01.03", false},
        {"Make water bucket","DEAD",    true},
        {"Respawn",          "+4:22",   true},
        {"Find cave again",  "DEAD",    true},
        {"Craft table again","AGAIN",   true},
        {"Touch lava again", "DEAD",    true},
        {"Respawn again",    "+8:44",   true},
        {"Same lava. Again", "DEAD",    true},
        {"Respawn (3rd)",    "+13:06",  true},
        {"Give up entirely", "FINAL",   true},
    }
    local row = 4
    for _, s in ipairs(splits) do
        if row >= h then break end
        m.setTextColor(s[3] and colors.red or colors.lime)
        local line = string.format("%-16s %s", s[1]:sub(1,16), s[2])
        tw(2, row, line, 0.012)
        row = row + 1
        os.sleep(0.22)
    end
    os.sleep(0.8)
    m.setTextColor(colors.red)
    center(h, "FINAL TIME: DNF. CAUSE: EXISTING.")
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: SUPPORT TICKET
-- ============================================================
local function phase_support()
    blast(colors.black, colors.white)
    center(2, "TICKET #" .. math.random(10000, 99999) .. " - 11TH FILED")
    fillRow(3, "=", colors.gray, colors.black)
    local ticket = {
        "To: Mojang/Admin/Anyone Please",
        "Re: Lava discrimination",
        "",
        "I write to report issues that are",
        "definitely NOT my fault:",
        "",
        "1. Lava keeps hurting me.",
        "   (I did not consent to this.)",
        "2. Skeleton aims at me personally.",
        "   (Evidence: vibes.)",
        "3. Diamonds went into the lava.",
        "   Refund: yes please. Urgent.",
        "4. Creeper made no warning sound.",
        "   (It did make a sound.)",
        "5. I had 2 hearts. Zombie had",
        "   more than 2 damage. Unfair.",
        "6. The chicken. It knows things.",
        "   I cannot elaborate. It knows.",
        "7. Gerald applied for my spot.",
        "   The admin is considering it.",
        "   This cannot happen.",
        "",
        "Please respond within 3-5 days.",
        "Regards, A Paying Customer",
        "(Note: I have never paid.)",
    }
    local row = 4
    for _, line in ipairs(ticket) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(colors.lightGray)
            tw(2, row, line, 0.017)
            row = row + 1
        end
        os.sleep(0.06)
    end
    os.sleep(0.8)
    m.setTextColor(colors.red)
    center(h, "CLOSED: SKILL ISSUE. NO REFUND.")
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: REBOOT
-- ============================================================
local function phase_reboot()
    blast(colors.black, colors.red)
    local mid = math.floor(h / 2)
    center(math.max(1, mid - 2), "MEMORY LEAK: COPE.EXE")
    center(math.max(1, mid), "REBOOTING CONFIDENCE...")
    center(math.max(1, mid + 2), "ETA: GEOLOGICAL TIMESCALE")
    os.sleep(3.5)
    blast(colors.black, colors.white)
    for i = 5, 0, -1 do
        m.clear()
        center(math.max(1, mid - 1), "REBOOT IN " .. i .. "...")
        center(math.max(1, mid + 1), genTriple())
        os.sleep(1)
    end
end

-- ============================================================
-- PHASE: TWITCH CHAT SIMULATOR
-- ============================================================
local function phase_twitchchat()
    blast(colors.black, colors.purple)
    center(1, "XYNIACRAFT LIVE - 847 VIEWERS")
    fillRow(2, "-", colors.gray, colors.black)
    local chatters = {
        "pogchamp69","sadge_forever","lulw_watcher",
        "monkaS_haver","omegaLUL_lord","copium_huffer",
        "actual_chat","painchamp_live","peepoSad_real",
        "KKona_enjoyer","GeraldThePig_fan","lava_appreciator",
    }
    local chatmsgs = {
        "OMEGALUL","Clap","LUL","LULW","Sadge","monkaS",
        "KEKW","PogO","FeelsBadMan","copium","bro what","HOW",
        "LMAO","actual garbage","ff15","gg ez","KEKW KEKW KEKW",
        "hardstuck dirt hut","uninstall","bro fell again LULW",
        "the lava AGAIN","the SAME lava","monkaGIGA","PepeLaugh",
        "he doesnt know PepeLaugh","NOOOO KEKW","5Head avoidance",
        "imagine","WeirdChamp","been watching 3hrs. same lava.",
        "GG EZ","THEY DID NOT","NO WAY","they did","Sadge",
        "F","F","F","F","F","F","F",
        "skill diff","diff diff diff","enormous diff",
        "what is bro doing","came back from nap same run",
        "speedrunning death%","world record death% wr",
        "have they killed ANYTHING at all",
        "creeper had a family LULW","the warden has a name for them",
        "Gerald the pig has more kills Clap",
        "give Gerald a keyboard Clap",
        "the chicken. THE CHICKEN. monkaS",
        "they saw the chicken. they ran.",
        "the chicken is chasing them now LULW",
        "the chicken is winning",
        "CHICKEN WINS KEKW",
        "Gerald and the chicken are ALLIED",
        "gerald+chicken vs player",
        "player has no chance omegaLUL",
        "Im done. Im completely done.",
        "this is the greatest stream",
        "and the saddest stream",
        "simultaneously",
    }
    local row = 3
    for i = 1, math.min(70, h - 3) do
        if row >= h then break end
        local name = rnd(chatters)
        m.setTextColor(rnd(colors_list))
        local prefix = (name .. ": "):sub(1, 16)
        put(2, row, prefix)
        m.setTextColor(colors.white)
        put(2 + #prefix, row, rnd(chatmsgs))
        row = row + 1
        os.sleep(0.17)
    end
    os.sleep(4)
end

-- ============================================================
-- PHASE: REDDIT POST (AITA)
-- ============================================================
local function phase_reddit()
    blast(colors.black, colors.orange)
    m.setTextColor(colors.orange)
    center(2, "r/AmITheAsshole")
    fillRow(3, "-", colors.orange, colors.black)
    m.setTextColor(colors.white)
    local score = math.random(-9999, -100)
    center(4, "[" .. score .. "] AITA for blaming")
    center(5, "teammates again after dying")
    center(6, "to lava for the " .. math.random(5,30) .. "th time")
    fillRow(7, "-", colors.gray, colors.black)
    local comments = {
        "YTA. Obviously.",
        "YTA. Its lava. Always been lava.",
        "YTA. The lava has feelings.",
        "NTA wait yes TA. Massive TA.",
        "INFO: how is this still happening",
        "INFO: what do you think lava does",
        "YTA - lava is orange and it glows",
        "You are the lava's villain arc.",
        "YTA and the lava sends regards",
        "Gentle YTA: touch grass.",
        "Hard YTA: you specifically.",
        "I had to look away. YTA.",
        "Not a doctor but: YTA",
        "Certified YTA international council",
        "Studied this for my thesis. YTA.",
        "The skeleton agrees. YTA.",
        "The creeper agrees. Also YTA.",
        "Gerald disagrees. Still YTA.",
        "Gerald says vote YTA anyway.",
        "The chicken has no comment.",
        "The chicken's silence is damning.",
        "Even Gerald. Especially Gerald.",
    }
    local row = 8
    for _, c in ipairs(comments) do
        if row >= h then break end
        m.setTextColor(rnd(colors_list))
        tw(2, row, c, 0.015)
        row = row + 1
        os.sleep(0.2)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: PATCH NOTES (YOU-SPECIFIC)
-- ============================================================
local function phase_patchnotes()
    blast(colors.black, colors.cyan)
    center(2, "PATCH NOTES - YOU-SPECIFIC HOTFIX")
    fillRow(3, "-", colors.gray, colors.black)
    local notes = {
        "[NERF] Lava now 50% more effective vs you",
        "[NERF] Skeletons +200% accuracy vs you",
        "[NERF] Creeper range +500% near your base",
        "[NERF] Gravel falls toward you specifically",
        "[NERF] Your inventory: dirt only",
        "[BUFF] Void pull increased near your coords",
        "[BUFF] Warden can now smell your regret",
        "[BUFF] Phantoms get 3x speed vs you",
        "[FIX] Fixed bug where you could survive falls",
        "[FIX] Lava warning sound removed (your account)",
        "[ADD] New death message: Again? Really?",
        "[ADD] Server auto-mutes you on each death",
        "[ADD] Admins gain XP from your death events",
        "[ADD] Scoreboard: Most Deaths. You're first.",
        "[ADD] Gerald: officially promoted above you",
        "[ADD] Chicken: unkillable within 10 blocks of you",
        "[REM] Peaceful mode removed (your account only)",
        "[REM] Keep inventory removed (your account only)",
        "[REM] Water no longer extinguishes your fires",
        "[REM] The dirt cube: designated grief target",
    }
    local row = 4
    for _, n in ipairs(notes) do
        if row >= h then break end
        local tag = n:sub(2, 5)
        m.setTextColor(
            tag == "NERF" and colors.red or
            tag == "BUFF" and colors.lime or
            tag == "FIX " and colors.yellow or
            tag == "ADD]" and colors.cyan or
            colors.orange
        )
        tw(2, row, n, 0.014)
        row = row + 1
        os.sleep(0.14)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: PSYCHIATRIC EVALUATION
-- ============================================================
local function phase_psych()
    blast(colors.black, colors.white)
    center(2, "PSYCH EVALUATION RESULTS")
    center(3, ("Patient: " .. genInsult()))
    fillRow(4, "=", colors.gray, colors.black)
    local findings = {
        "PRESENTING CONCERNS:",
        "Lava 'keeps finding patient'.",
        "Skeleton 'aims personally'.",
        "Filed " .. math.random(5,40) .. " unban appeals.",
        "Claims lag during all deaths.",
        "Logs confirm: no lag. Ever.",
        "",
        "COGNITIVE ASSESSMENT:",
        "Cannot identify lava on viewing.",
        "Or on subsequent viewings.",
        "Crafts hoe repeatedly. Unprompted.",
        "Believes creepers can be reasoned with.",
        "Named a pig. Now cannot eat pork.",
        "Gerald (pig) is doing better.",
        "The chicken is a source of anxiety.",
        "",
        "DIAGNOSIS:",
        "Chronic Cope Disorder (advanced)",
        "Acute Skill Deficiency Syndrome",
        "Lava Proximity Compulsion",
        "Pathological Blame Externalization",
        "Gerald Dependency (secondary)",
        "Chicken-Induced Stress Disorder",
        "",
        "PROGNOSIS: Poor. Very poor.",
        "RECOMMENDATION: Peaceful mode.",
        "RESPONSE: Thats cheating.",
        "REVISED: Uninstall.",
    }
    local row = 5
    for _, line in ipairs(findings) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(line:sub(-1) == ":" and colors.yellow or colors.lightGray)
            tw(2, row, line, 0.017)
            row = row + 1
        end
        os.sleep(0.08)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: YELP REVIEWS (OF THEIR BASE)
-- ============================================================
local function phase_yelp()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(2, "YELP: YOUR BASE")
    m.setTextColor(colors.yellow)
    center(3, "1/5 stars (" .. math.random(200,900) .. " reviews)")
    fillRow(4, "-", colors.gray, colors.black)
    local reviews = {
        {"DiamondMiner64", "1* - Its dirt. Just dirt."},
        {"CreeperHunter99", "1* - Walls: dirt. Roof: dirt."},
        {"WardenFan2026",   "1* - No windows. No door. 4 dirt."},
        {"GrindMode",       "1* - Called it a base. Its a cube."},
        {"AdminSteve",      "1* - Structural & aesthetic crimes."},
        {"NightOwl",        "2* - At least it has a chest."},
        {"BuildMaster",     "1* - The chest was also dirt."},
        {"xX_ProGamer",     "1* - Visited. Cried. Left."},
        {"LocalVillager",   "1* - Collapsed on me. Inside."},
        {"Notch_Real",      "1* - I am so sorry. For all of this."},
        {"Gerald_ThePig",   "5* - Smells like home. Perfect."},
        {"TheChicken",      "5* - Adequate for my needs."},
        {"TheVoid",         "5* - Very accessible. 10/10."},
    }
    local row = 5
    for _, r in ipairs(reviews) do
        if row >= h then break end
        m.setTextColor(colors.cyan)
        local name = (r[1] .. ":"):sub(1, 16)
        put(2, row, name)
        m.setTextColor(
            r[1] == "Gerald_ThePig" and colors.lime or
            r[1] == "TheChicken" and colors.lime or
            r[1] == "TheVoid" and colors.lime or
            colors.red
        )
        put(2 + #name, row, r[2])
        row = row + 1
        os.sleep(0.25)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: HOROSCOPE (ALL TERRIBLE)
-- ============================================================
local function phase_horoscope()
    blast(colors.black, colors.purple)
    center(2, "YOUR MINECRAFT HOROSCOPE")
    center(3, "The stars have spoken. Its bad.")
    fillRow(4, "-", colors.purple, colors.black)
    local signs = {
        "Aries","Taurus","Gemini","Cancer","Leo","Virgo",
        "Libra","Scorpio","Sagittarius","Capricorn","Aquarius","Pisces",
    }
    local readings = {
        "Mercury is retrograde in your base.",
        "The stars indicate lava today.",
        "Venus aligns with your inventory loss.",
        "Your ruling planet is the void.",
        "Jupiter predicts skeleton encounter.",
        "The moon is full. Warden is louder.",
        "Cosmic forces demand you fall again.",
        "Saturn says: touch grass. You wont.",
        "The universe is working against you.",
        "Stars confirm: definitely your fault.",
        "Alignment: die to cactus today.",
        "Celestial bodies weep for your hotbar.",
        "The cosmos are embarrassed for you.",
        "Mars predicts death before breakfast.",
        "Your aura is the color of dirt.",
        "Lucky item: nothing. Lucky mob: none.",
        "Avoid water. And lava. And gravel.",
        "Avoid mobs, nether, and decisions.",
        "Avoid being awake near lava. Always.",
        "Gerald has a better horoscope.",
        "The chickens stars: aligned. Yours: no.",
        "The void has a good feeling about today.",
        "You do not.",
    }
    local row = 5
    m.setTextColor(colors.yellow)
    center(row, "Sign: " .. rnd(signs))
    row = row + 2
    for _, r in ipairs(readings) do
        if row >= h then break end
        m.setTextColor(rnd(colors_list))
        tw(2, row, r, 0.019)
        row = row + 1
        os.sleep(0.25)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: LAST WILL AND TESTAMENT
-- ============================================================
local function phase_will()
    blast(colors.black, colors.white)
    m.setTextColor(colors.lightGray)
    center(2, "LAST WILL AND TESTAMENT")
    center(3, ("of " .. genInsult()))
    fillRow(4, "=", colors.gray, colors.black)
    local will_lines = {
        "Of questionable mind and",
        "zero remaining inventory:",
        "",
        ("To the server: " .. math.random(200,9000) .. " dirt blocks."),
        "Im sorry. There are so many.",
        "They have no value of any kind.",
        "",
        "To my killer: the one leather boot.",
        "The left one. You earned it.",
        "",
        "To Gerald the pig: everything else.",
        "Gerald is a better player than me.",
        "Gerald should have my account.",
        "Gerald should replace me.",
        "Gerald would not fall in that lava.",
        "",
        "To the lava: well played.",
        "You have always won.",
        "Every single time.",
        "",
        "To the chicken: I respect you.",
        "I did not think I would say that.",
        "",
        "Signed: [PLAYER]",
        "Witnessed by: nobody. Nobody came.",
    }
    local row = 5
    for _, line in ipairs(will_lines) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(colors.white)
            center(row, line)
            row = row + 1
        end
        os.sleep(0.2)
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: TOS VIOLATION NOTICE
-- ============================================================
local function phase_tos()
    blast(colors.black, colors.red)
    center(2, "TERMS OF SERVICE VIOLATION")
    center(3, "Notice #" .. math.random(1000, 9999))
    fillRow(4, "=", colors.red, colors.black)
    local violations = {
        "Sec 4.2: Repeated lava death",
        ("  (Max: 3. Your count: " .. math.random(50,700) .. ")"),
        "",
        "Sec 7.1: Filing false lag claims",
        ("  (" .. math.random(300,9000) .. " violations. Logs say: no lag.)"),
        "",
        "Sec 9.4: Unban appeal spam",
        ("  (Limit: 1. Your total: " .. math.random(6,55) .. ")"),
        "",
        "Sec 11.0: Base aesthetic crime",
        "  (Standard: not purely dirt.)",
        "",
        "Sec 14.3: Dirt accumulation",
        ("  (Limit: 500. You have: " .. math.random(5000,99999) .. ")"),
        "",
        "Sec 22.1: Punching iron golem",
        "  (Do not. You did. Twice.)",
        "",
        "Sec 31.7: Waking ancient city",
        "  (We asked you not to. Twice.)",
        "",
        "Sec 44.0: Chicken incidents (see file)",
        "  (The file is 47 pages.)",
        "",
        "PENALTY:",
        "  Public scoreboard listing.",
        "  Gerald receives your account.",
    }
    local row = 5
    for _, line in ipairs(violations) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(line:sub(1, 3) == "Sec" and colors.yellow or colors.lightGray)
            tw(2, row, line, 0.017)
            row = row + 1
        end
        os.sleep(0.1)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: JOB APPLICATION REJECTION
-- ============================================================
local function phase_job()
    blast(colors.black, colors.white)
    center(2, "APPLICATION: REJECTED")
    center(3, "Role: Minecraft Player")
    fillRow(4, "-", colors.gray, colors.black)
    local letter = {
        "Dear Applicant,",
        "",
        ("After reviewing " .. math.random(20,60) .. "hrs footage"),
        ("and " .. math.random(200,900) .. " deaths observed,"),
        "we cannot offer you the role.",
        "",
        "Areas of critical concern:",
        "- Lava avoidance: none detected",
        "- Skeleton awareness: none detected",
        "- Map reading: none detected",
        "- Basic survival: insufficient",
        "- Unban appeal quality: very poor",
        "- Dirt accumulation: excessive",
        "- Chicken relations: catastrophic",
        "- Gerald the pig: more qualified",
        "",
        "Alternative roles available:",
        "- Gravel Tester",
        "- Lava Quality Assurance",
        "- Death Screen Analyst",
        "- Dirt Inventory Manager",
        "- Gerald Support Staff",
        "",
        "We wish you well.",
        "(We do not wish you well.)",
        "",
        "The Minecraft HR Department",
    }
    local row = 5
    for _, line in ipairs(letter) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(line:sub(1,1) == "-" and colors.red or colors.lightGray)
            tw(2, row, line, 0.016)
            row = row + 1
        end
        os.sleep(0.08)
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: STAR RATING
-- ============================================================
local function phase_stars()
    blast(colors.black, colors.yellow)
    center(2, "COMMUNITY RATING: YOU")
    os.sleep(0.8)
    local cats = {
        {"PvP Skill",         math.random(0, 1)},
        {"Base Quality",      math.random(0, 1)},
        {"Lava Avoidance",    0},
        {"Skeleton Diplomacy",0},
        {"Map Reading",       0},
        {"Inventory Org.",    math.random(0, 1)},
        {"Teamwork",          0},
        {"Unban Appeals",     10},
        {"Dirt Hoarding",     10},
        {"Death Frequency",   10},
        {"Delusion Level",    10},
        {"Chicken Relations", 0},
        {"Gerald Relations",  10},
        {"Overall",           math.random(0, 1)},
    }
    local row = 4
    for _, cat in ipairs(cats) do
        if row >= h then break end
        local stars = ""
        local blanks = ""
        for i = 1, math.min(cat[2], 10) do stars = stars .. "*" end
        for i = cat[2] + 1, 10 do blanks = blanks .. "." end
        m.setTextColor(
            cat[2] >= 8 and colors.red or
            cat[2] >= 5 and colors.orange or
            cat[2] >= 2 and colors.yellow or colors.lime
        )
        local lbl = (cat[1] .. ":"):sub(1, 16)
        put(2, row, lbl)
        put(19, row, (stars .. blanks .. " " .. cat[2] .. "/10"))
        row = row + 1
        os.sleep(0.25)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: EMAIL INBOX
-- ============================================================
local function phase_email()
    blast(colors.black, colors.white)
    center(2, "INBOX (" .. math.random(200,999) .. " UNREAD)")
    fillRow(3, "-", colors.gray, colors.black)
    local emails = {
        {"UNBAN-NOREPLY", "Appeal #" .. math.random(5,55) .. " - DENIED"},
        {"Admin@server",   "RE: The TNT Incident. We know."},
        {"Skeleton@nether","RE: You. We need to talk."},
        {"Creeper@smp",    "RE: Your base. Delicious."},
        {"Warden@deep",    "I can hear you typing this."},
        {"Lava@always",    "Thanks for visiting. Again."},
        {"Gerald@pigpen",  "I have your diamond pickaxe."},
        {"Void@below",     "See you soon. - The Void"},
        {"Admin@server",   "RE: RE: RE: RE: Please stop."},
        {"Gravel@ceiling", "Your fault. Always yours."},
        {"Server@log",     "Total deaths: " .. math.random(400,999)},
        {"Phantom@sky",    "RE: Please sleep. The Phantoms"},
        {"Golem@village",  "Do not come back. The Golem"},
        {"Notch@mojang",   "I see you. Im sorry. Notch"},
        {"TheChicken",     "I know what you did."},
        {"Nether@portal",  "RE: Reassignment - APPROVED"},
        {"Admin@server",   "RE: Your dirt. Remove it."},
        {"Gerald@pigpen",  "RE: Your account. I want it."},
        {"Void@below",     "RE: Soon is now. Come on down."},
        {"Enderman@end",   "Stop making eye contact. STOP."},
        {"TheChicken",     "RE: I know. I will always know."},
        {"Gerald@pigpen",  "RE: The admin said yes."},
        {"Gerald@pigpen",  "RE: See you never. Gerald."},
    }
    local row = 4
    for _, email in ipairs(emails) do
        if row >= h then break end
        m.setTextColor(colors.cyan)
        local sender = (email[1] .. ":"):sub(1, 16)
        put(2, row, sender)
        m.setTextColor(colors.white)
        put(2 + #sender, row, email[2])
        row = row + 1
        os.sleep(0.19)
    end
    os.sleep(4)
end

-- ============================================================
-- PHASE: GOOGLE SEARCH RESULTS
-- ============================================================
local function phase_google()
    blast(colors.black, colors.white)
    m.setTextColor(colors.cyan)
    center(2, "Google")
    fillRow(3, "-", colors.gray, colors.black)
    local query = rnd({
        "how to not be bad at minecraft",
        "is 600 deaths normal for one week",
        "how to befriend a chicken",
        "chicken took my stuff legally",
        "can gerald the pig have my account",
        "void keeps finding me why",
        "am i the problem on my smp",
        "unban appeal template formal",
        "lava avoidance tips beginners",
        "is it normal to name your pig",
    })
    m.setTextColor(colors.white)
    center(4, "Results for: " .. query)
    m.setTextColor(colors.lightGray)
    center(5, "About " .. math.random(1000,9999) .. " results (0.00" .. math.random(1,9) .. " seconds)")
    fillRow(6, "-", colors.gray, colors.black)
    local results = {
        {
            "WikiHow: How to Not Be Bad",
            "Step 1: Stop being bad. Step 2: Good. (You failed step 1.)"
        },
        {
            "Reddit: r/Minecraft - Am I terrible?",
            "Top comment: Yes. 47,000 upvotes. No debate."
        },
        {
            "YouTube: Minecraft Tutorial for Adults",
            "Duration: 4hrs. Comments: 'this guys player is worse'"
        },
        {
            "Minecraft Wiki: Lava - Minecraft Wiki",
            "Lava hurts you. Do not touch it. It is still hot."
        },
        {
            "Support Forum: Unban Appeal Help",
            "Thread locked after " .. math.random(5,55) .. " appeals from same IP."
        },
        {
            "GeraldThePig.com: Official Site",
            "Gerald is accepting applications for your server spot."
        },
        {
            "TheChicken.net: I Know What You Did",
            "The chicken has a website now. It is about you."
        },
    }
    local row = 7
    for _, r in ipairs(results) do
        if row >= h - 1 then break end
        m.setTextColor(colors.lightBlue)
        tw(2, row, r[1], 0.012)
        row = row + 1
        if row >= h then break end
        m.setTextColor(colors.lightGray)
        tw(2, row, r[2], 0.008)
        row = row + 1
        os.sleep(0.3)
    end
    os.sleep(4)
end

-- ============================================================
-- PHASE: FORTUNE COOKIES FROM HELL
-- ============================================================
local function phase_fortune()
    blast(colors.black, colors.yellow)
    center(2, "YOUR FORTUNE")
    center(3, string.rep("-", math.min(14, w)))
    local fortunes = {
        "You will fall in lava again today.",
        "The lava has been waiting for you.",
        "A great opportunity awaits: a hole in the ground.",
        "Your skeleton problem will not improve.",
        "The void is patient. You are not.",
        "Today you will craft a hoe again.",
        "Someone will take your stuff. The chicken.",
        "Gerald will surpass you before Friday.",
        "You are the main character of the wrong story.",
        "A new adventure awaits. It ends in lava.",
        "Lucky numbers: -9999, 0, and your K/D ratio.",
        "A close friend will help you: they are a pig.",
        "Change is coming. Your dirt cube will be griefed.",
        "You will find diamonds today: in the lava.",
        "The stars say: log off. The stars are right.",
        "A stranger will approach you. It is a creeper.",
        "You are uniquely special. Unusually bad.",
        "Better days are ahead. Not for you. For Gerald.",
        "Trust your instincts. Your instincts are wrong.",
        "The path forward is clear: it is into lava.",
        "New friendships await. One is a chicken. Be careful.",
        "Your lucky dirt count: " .. math.random(1000, 99999),
        "Do not make any decisions today. Or ever.",
        "You will receive good news: the warden went away.",
        "The good news ends there.",
        "Your unban appeal will succeed: it will not.",
        "Today is a day for fresh starts. The lava is fresh.",
        "The chicken forgives. (The chicken does not forgive.)",
    }
    local mid = math.floor(h / 2)
    for i = 1, 20 do
        m.clear()
        m.setTextColor(colors.yellow)
        center(2, "YOUR FORTUNE")
        center(3, string.rep("-", math.min(14, w)))
        m.setTextColor(rnd(colors_list))
        local f = rnd(fortunes)
        -- split fortune across two lines if long
        if #f > w - 4 then
            local half = math.floor(#f / 2)
            local split = f:find(" ", half) or half
            center(mid - 1, f:sub(1, split - 1))
            center(mid + 1, f:sub(split + 1))
        else
            center(mid, f)
        end
        m.setTextColor(colors.lightGray)
        center(h - 1, "Lucky numbers: -" .. math.random(1,9999))
        os.sleep(2.5)
    end
    os.sleep(1)
end

-- ============================================================
-- PHASE: FAKE POLICE REPORT
-- ============================================================
local function phase_police()
    blast(colors.black, colors.white)
    center(2, "INCIDENT REPORT #" .. math.random(10000,99999))
    fillRow(3, "=", colors.gray, colors.black)
    local report = {
        "Date: " .. os.date("%A"),
        "Reporting officer: Admin_Steve",
        "Incident type: Self-inflicted",
        "",
        "SUMMARY OF EVENTS:",
        "",
        "At approximately who-cares o'clock,",
        "the subject approached a body of lava.",
        "The subject was warned by:",
        " - The orange glow",
        " - The hissing sound",
        " - Three signs reading DO NOT",
        " - A fence placed by the admin",
        " - Verbal warning from 2 players",
        " - Gerald the pig, who stepped aside",
        "",
        "The subject entered the lava.",
        "Diamonds lost: " .. math.random(5,64),
        "Subject's explanation: it was lag.",
        "Lag log for that period: none.",
        "",
        "CHARGES:",
        "Crimes against common sense: guilty.",
        "Wasting admin time: guilty.",
        "Excessive unban appeals: guilty.",
        "Dirt cube ordinance violation: guilty.",
        "",
        "VERDICT: Skill issue. No fine.",
        "         (You have no diamonds to fine.)",
    }
    local row = 4
    for _, line in ipairs(report) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(line:sub(1,1) == " " and colors.lightGray or colors.white)
            tw(2, row, line, 0.014)
            row = row + 1
        end
        os.sleep(0.07)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: FAKE THERAPY SESSION
-- ============================================================
local function phase_therapy()
    blast(colors.black, colors.white)
    center(2, "THERAPY SESSION TRANSCRIPT")
    center(3, ("Patient: " .. genInsult()))
    fillRow(4, "-", colors.gray, colors.black)
    local session = {
        "T: How are you feeling today?",
        "P: The lava found me again.",
        "T: How did the lava find you?",
        "P: I walked into it.",
        "T: Why did you walk into it?",
        "P: It was definitely lag.",
        "T: The logs show no lag.",
        "P: The logs are wrong.",
        "T: ...Okay. Tell me about Gerald.",
        "P: Gerald is my pig. He is better",
        "   at Minecraft than I am.",
        "T: How does that make you feel?",
        "P: Gerald applied for my spot.",
        "T: And?",
        "P: The admin approved it.",
        "T: ...How does THAT make you feel?",
        "P: Honestly? Fair. It was fair.",
        "T: Progress. What about the chicken?",
        "P: The chicken knows something.",
        "T: What does it know?",
        "P: I cannot tell you.",
        "T: Is it because you dont know?",
        "P: ...Yes.",
        "T: We are out of time.",
        "P: Can I file an unban appeal",
        "   in here? Just while Im here.",
        "T: This is a therapy office.",
        "P: Is that a no?",
        "T: That is absolutely a no.",
    }
    local row = 5
    for _, line in ipairs(session) do
        if row >= h then break end
        m.setTextColor(line:sub(1,2) == "T:" and colors.cyan or colors.white)
        tw(2, row, line, 0.015)
        row = row + 1
        os.sleep(0.12)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: FAKE AUCTION OF THEIR INVENTORY
-- ============================================================
local function phase_auction()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.yellow)
    center(2, "AUCTION: YOUR ENTIRE INVENTORY")
    m.setTextColor(colors.orange)
    center(3, "Starting bids: very low")
    fillRow(4, "-", colors.gray, colors.black)
    local items = {
        {"64x Dirt",              math.random(0,2),   math.random(0,3)},
        {"64x Dirt",              math.random(0,2),   math.random(0,3)},
        {"64x Dirt",              math.random(0,2),   math.random(0,3)},
        {"64x Dirt",              math.random(0,2),   math.random(0,3)},
        {"1x Leather Boot (L)",   math.random(0,5),   math.random(1,8)},
        {"1x Wooden Sword",       math.random(0,3),   math.random(1,5)},
        {"1x Hoe (why)",          0,                  0},
        {"Stack of Gravel",       0,                  0},
        {"Unban Appeal (draft)",  0,                  0},
        {"IOU from Gerald",       0,                  0},
        {"Hurt feelings",         0,                  0},
        {"400 More Dirt",         math.random(0,1),   math.random(0,2)},
        {"Gerald's Leftovers",    math.random(2,10),  math.random(5,15)},
    }
    local row = 5
    for _, item in ipairs(items) do
        if row >= h then break end
        m.setTextColor(item[2] == 0 and colors.red or colors.white)
        local startB = "Start: " .. item[2] .. "g"
        local soldB  = "Sold: " .. item[3] .. "g"
        local name = item[1]:sub(1, math.max(1, w - 18))
        put(2, row, name)
        put(math.max(1, w - 15), row, startB)
        put(math.max(1, w - 7), row, soldB)
        row = row + 1
        os.sleep(0.28)
    end
    os.sleep(0.8)
    m.setTextColor(colors.yellow)
    center(h - 1, "TOTAL RAISED: " .. math.random(3,14) .. " gold")
    center(h, "GERALD RAISED MORE LAST WEEK")
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: DATING PROFILE ROAST
-- ============================================================
local function phase_dating()
    blast(colors.black, colors.pink)
    m.setTextColor(colors.pink)
    center(2, "DATING PROFILE REVIEW")
    fillRow(3, "-", colors.pink, colors.black)
    local profile = {
        "Name: " .. genInsult(),
        "Age: Old enough to know better",
        "Location: Dirt cube (renting)",
        "Hobbies:",
        " - Falling in lava (main hobby)",
        " - Filing unban appeals",
        " - Collecting dirt (not by choice)",
        " - Losing to chickens",
        " - Not sleeping (hence phantoms)",
        "Bio:",
        " I am a passionate player who",
        " enjoys the outdoors (the nether)",
        " and meeting new people (creepers).",
        " My pig Gerald says Im a good person.",
        " Gerald may be biased.",
        " Gerald has my diamonds.",
        "Looking for:",
        " Someone who won't fall in lava.",
        " (Not me. Someone else.)",
        "Review: 0 matches found.",
        "Reason: Lava incident track record.",
        "Gerald has 7 matches. Just saying.",
    }
    local row = 4
    for _, line in ipairs(profile) do
        if row >= h then break end
        m.setTextColor(line:sub(1,1) == " " and colors.lightGray or colors.white)
        tw(2, row, line, 0.015)
        row = row + 1
        os.sleep(0.1)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: FUCK UP COMPILATION
-- ============================================================
local function phase_fuckups()
    blast(colors.black, colors.red)
    center(2, "YOUR GREATEST FUCK UPS: A COMPILATION")
    fillRow(3, "-", colors.red, colors.black)
    local fuckups = {
        "Punched tree with -3 IQ energy",
        "Fell down the hole you dug. Twice.",
        "Gravel. You trusted gravel. GRAVEL.",
        "Fought skeleton with wooden fucking sword",
        "Said lava was orange? Was surprised orange=hot",
        "Built base entirely from dirt. ALL OF IT.",
        "Spent 4 hours mining: yielded dirt",
        "Fell in same lava 47 times. SAME LAVA.",
        "Negotiated with creeper. Creeper won.",
        "Tried to tame chicken. Chicken tamed you instead.",
        "Punched iron golem IN FRONT OF ADMIN",
        "Lost full diamond set to skeleton with no armor",
        "Dug straight down. Got shocked it didn't work.",
        "Confused spawn point with home base",
        "Set your respawn in the nether. Why.",
        "Tried to cross nether lava lake. With wood.",
        "Said Herobrine isn't real. You made him sad.",
        "Slept 0 times. Got murdered by phantoms.",
        "Woke ancient city in deepest cave. On purpose.",
        "Punched warden. Warden was not impressed.",
        "Your 47 page chicken incident report",
        "Lost account to Gerald. LOST IT.",
        "Got beaten in combat by a bat",
        "Tried to farm without dirt somehow",
        "Collected 40000 dirt for... reason?",
        "Named your pig Gerald. Now addicted.",
        "Gerald applied for YOUR spot. He got it.",
        "Filed 27 unban appeals in one week",
        "Claimed lag while logs showed zero lag",
        "Admin made a screenshot folder just for you",
        "Your death montage is 6 hours long",
        "Server has betting pool on next death cause",
        "They use your plays in admin training",
        "For what NOT to do. Ever.",
        "Your IP has been logged as 'Problem Player'",
        "You are case study in server guide",
        "Title: The Worst We've Seen",
    }
    local row = 4
    for _, fuckup in ipairs(fuckups) do
        if row >= h then break end
        m.setTextColor(rnd(colors_list))
        tw(2, row, (">> FUCKUP: " .. fuckup), 0.012)
        row = row + 1
        os.sleep(0.15)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: SWEAR JAR AUDIT
-- ============================================================
local function phase_swearjar()
    blast(colors.black, colors.cyan)
    center(2, "SWEAR JAR AUDIT - YOUR EXPENSE REPORT")
    fillRow(3, "-", colors.cyan, colors.black)
    local jar = {
        {"Saying fuck",            math.random(2000, 9999), "fuck"},
        {"Saying shit",            math.random(1500, 8999), "shit"},
        {"Saying goddamn",         math.random(800, 6999), "goddamn"},
        {"Saying ass",             math.random(500, 4999), "ass"},
        {"Saying bitch",           math.random(300, 3999), "bitch"},
        {"Saying cunt",            math.random(200, 2999), "cunt"},
        {"Saying cock",            math.random(400, 3999), "cock"},
        {"Swearing at creeper",    math.random(100, 999), "times"},
        {"Swearing at lava",       math.random(500, 4999), "times"},
        {"Swearing at skeleton",   math.random(200, 1999), "times"},
        {"Swearing at warden",     math.random(10, 500), "times"},
        {"Swearing at chicken",    math.random(50, 999), "times"},
        {"Swearing at Gerald",     math.random(1, 10), "times (unlikely)"},
        {"Swearing at self",       math.random(2000, 9999), "times"},
        {"Rage quitting profanities", math.random(500, 4999), "per session"},
    }
    local total = 0
    local row = 4
    for _, item in ipairs(jar) do
        if row >= h - 2 then break end
        m.setTextColor(rnd(colors_list))
        local line = string.format("%-25s %6d %s", item[1]:sub(1, 25), item[2], item[3])
        tw(2, row, line, 0.010)
        total = total + item[2]
        row = row + 1
        os.sleep(0.12)
    end
    m.setTextColor(colors.yellow)
    fillRow(row + 1, "-", colors.yellow, colors.black)
    center(row + 2, ("TOTAL OWED: $" .. (total * 0.25)))
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: PAIN AND SUFFERING INSURANCE CLAIM
-- ============================================================
local function phase_insurance()
    blast(colors.black, colors.white)
    center(2, "INSURANCE CLAIM: PAIN & SUFFERING")
    fillRow(3, "=", colors.gray, colors.black)
    local claim = {
        "Claim #" .. math.random(10000, 99999),
        "Claimant: " .. genInsult(),
        "Incident Type: Existing On Server",
        "Frequency: Fucking constant",
        "",
        "DETAILED DESCRIPTION OF SUFFERING:",
        " - Lava-related trauma (recurring)",
        " - Skeleton-induced PTSD",
        " - Chicken-based anxiety disorder",
        " - Void-proximity fear disorder",
        " - Warden-adjacent nightmares",
        " - Gerald-induced inadequacy complex",
        " - General existential dread",
        " - Pervasive sense of hopelessness",
        "",
        "FINANCIAL DAMAGES:",
        " - Diamonds lost: Incalculable",
        " - Emotional damage: Immeasurable",
        " - Self-esteem: $0 value",
        " - Sanity: Can't put a price on it",
        " - Account reputation: Negative $9999",
        "",
        "REQUESTED COMPENSATION:",
        " - Full server refund: $0 (never paid)",
        " - Gerald's diamond stash",
        " - Chicken relocation fund",
        " - Therapy sessions: Infinite",
        " - New identity: Approved",
        "",
        "CLAIM STATUS: **REJECTED**",
        "REASON: Skill issue not covered under policy",
    }
    local row = 4
    for _, line in ipairs(claim) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(line:sub(1,1) == " " and colors.lightGray or colors.white)
            tw(2, row, line, 0.014)
            row = row + 1
        end
        os.sleep(0.07)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: ANGRY LETTER FROM SERVER OWNER
-- ============================================================
local function phase_angrymail()
    blast(colors.black, colors.red)
    center(2, "CERTIFIED FUCKING LETTER FROM ADMIN")
    fillRow(3, "-", colors.red, colors.black)
    local letter = {
        "Listen you absolute fuckwit.",
        "",
        "I am DONE. FUCKING DONE WITH YOUR SHIT.",
        "",
        "Every single goddamn day it is the same bullshit.",
        "You die. You blame lag. THE LOGS SAY DIFFERENT.",
        "",
        "You have died " .. math.random(400, 999) .. " times this month.",
        "To THE SAME FUCKING LAVA.",
        "IN THE SAME FUCKING SPOT.",
        "THAT YOU DUG YOURSELF.",
        "",
        "Your bases get griefed because they are",
        "FUCKING DIRT BLOCKS. FOUR DIRT WALLS.",
        "",
        "You are actively making the server WORSE.",
        "Your dirt is causing lag.",
        "YOUR FUCKING DIRT.",
        "",
        "I am ONE MORE DEATH AWAY from banning you personally.",
        "I mean it. Not a joke anymore.",
        "If you die one more time to lava",
        "I am IP banning your entire household.",
        "",
        "STAY AWAY FROM FUCKING LAVA.",
        "It is LITERALLY ORANGE.",
        "It HISSES at you.",
        "It GLOWS.",
        "WHAT DO YOU NEED???",
        "",
        "And that fucking chicken.",
        "DO NOT FIGHT THE CHICKEN.",
        "YOU WILL LOSE. YOU ALWAYS LOSE.",
        "The chicken is 8/8. You are 0/infinite.",
        "",
        "Gerald is now a server moderator.",
        "Gerald has admin rights.",
        "Gerald answers to nobody.",
        "ESPECIALLY NOT TO YOU.",
        "",
        "Your unban appeals are rejected automatically now.",
        "I wrote a bot. It takes 0.5 seconds.",
        "The bot laughs. I laugh. Gerald laughs.",
        "Even the chicken clucks dismissively.",
        "",
        "This is your final warning.",
        "Make it fucking count.",
        "",
        "Regards (no regards),",
        "Admin Steve",
        "(Furious beyond measure)",
    }
    local row = 4
    for _, line in ipairs(letter) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(line:sub(1,1) == " " and colors.lightGray or colors.red)
            tw(2, row, line, 0.013)
            row = row + 1
        end
        os.sleep(0.06)
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: WARRANTY
local function phase_warranty()
    blast(colors.black, colors.white)
    center(2, "WARRANTY VOID NOTICE")
    center(3, "Ref #" .. math.random(10000,99999))
    fillRow(4, "=", colors.red, colors.black)
    local notice = {
        "Dear Customer,",
        "",
        "Your warranty on: MINECRAFT ACCOUNT",
        "has been voided due to the following",
        "user-inflicted damages:",
        "",
        "1. Lava-based diamond disposal",
        ("   (Incidents: " .. math.random(50,700) .. ")"),
        "",
        "2. Unauthorized creeper negotiation",
        "   (Results: always the same)",
        "",
        "3. Voluntary void entry",
        ("   (Incidents: " .. math.random(20,400) .. ")"),
        "",
        "4. Structural dirt accumulation",
        ("   (" .. math.random(5000,99999) .. " blocks. Why.)"),
        "",
        "5. Gerald (pig) surpassing player",
        "   (Warranty does not cover this)",
        "",
        "6. The chicken incident (see file)",
        "",
        "Your account is now: void-voided.",
        "Gerald has been notified.",
        "Gerald says: finally.",
    }
    local row = 5
    for _, line in ipairs(notice) do
        if row >= h then break end
        if line == "" then
            row = row + 1
        else
            m.setTextColor(line:sub(1,1) == " " and colors.lightGray or colors.white)
            tw(2, row, line, 0.016)
            row = row + 1
        end
        os.sleep(0.08)
    end
    os.sleep(4.5)
end


-- ============================================================
-- PHASE: LINKEDIN PROFILE ROAST
-- ============================================================
local function phase_linkedin()
    blast(colors.black, colors.lightBlue)
    m.setTextColor(colors.lightBlue)
    center(2,"LinkedIn Profile")
    fillRow(3,"-",colors.lightBlue,colors.black)
    m.setTextColor(colors.white)
    center(4,clip(genInsult()))
    m.setTextColor(colors.lightGray)
    center(5,"Minecraft Player | Lava Specialist")
    center(6,"Dirt Industry | Open to Work")
    fillRow(7,"-",colors.gray,colors.black)
    local bullets = {
        "EXPERIENCE:",
        "Dying Professionally - "..math.random(2,8).." years",
        " * Fell in lava "..math.random(100,999).." times",
        " * Filed "..math.random(6,60).." unban appeals",
        " * Built "..math.random(3,15).." dirt cubes",
        " * Crafted "..math.random(5,30).." accidental hoes",
        " * Negotiated with creeper (always failed)",
        " * Lost full netherite "..math.random(2,15).." times",
        "",
        "SKILLS (endorsed by nobody):",
        " * Dirt collection (expert, verified)",
        " * Dying repeatedly (certified)",
        " * Blaming lag (fluent, logs contradict)",
        " * Unban appeal writing (prolific/wrong)",
        " * Hoe crafting (accidental/compulsive)",
        "",
        "ENDORSEMENTS:",
        " Gerald the pig: 47 endorsements",
        " The Chicken: 0 (refuses, won't explain)",
        " The Void: endorsed 'Lava Proximity'",
        " The Lava: endorsed 'Frequent Visiting'",
        " Admin: endorsed nothing (logged off)",
        "",
        "REFERENCES: None. Nobody came.",
    }
    local row=8
    for _,b in ipairs(bullets) do
        if row>=h then break end
        m.setTextColor(b:sub(1,1)=="*" and colors.lime or
                       b=="" and colors.black or colors.white)
        tw(2,row,b,0.013)
        row=row+1
        os.sleep(0.05)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: TRIPADVISOR REVIEWS OF THEIR BASE
-- ============================================================
local function phase_tripadvisor()
    blast(colors.black, colors.green)
    m.setTextColor(colors.green)
    center(2,"TripAdvisor: The Dirt Cube")
    m.setTextColor(colors.yellow)
    center(3,"1/5  ("..math.random(100,500).." reviews)")
    fillRow(4,"-",colors.gray,colors.black)
    local reviews = {
        {n="DiamondMiner64", s="1/5", r="Arrived. It was dirt. Left."},
        {n="GrindMode2026",  s="1/5", r="No roof. Rained inside. Angry."},
        {n="BuildMaster_UK", s="1/5", r="The floor was a hole. I fell."},
        {n="NightOwlSMP",    s="1/5", r="Called it a suite. 4 dirt blocks."},
        {n="WardenFan",      s="1/5", r="No windows. Screamed. Left."},
        {n="AdminSteve",     s="1/5", r="Condemned it twice. Still up."},
        {n="xX_ProGamer",   s="1/5", r="Wept openly. Drove 6 hours."},
        {n="LocalCreeper",  s="5/5", r="Delicious. Will revisit soon."},
        {n="Gerald_Pig",    s="5/5", r="Cozy. Mine now. 5 stars."},
        {n="TheChicken",    s="5/5", r="Adequate. I live here now."},
        {n="TheLava",       s="5/5", r="Exceptional access. Very close."},
        {n="TheVoid",       s="5/5", r="Extremely convenient. See you."},
        {n="Notch_Real",    s="1/5", r="I made this game. I am sorry."},
    }
    local row=5
    for _,rv in ipairs(reviews) do
        if row>=h then break end
        m.setTextColor(colors.cyan)
        local nm=(rv.n..":"):sub(1,14)
        put(2,row,nm)
        local pos=rv.s=="5/5"
        m.setTextColor(pos and colors.lime or colors.red)
        put(2+#nm,row,rv.s.." - "..rv.r)
        row=row+1
        os.sleep(0.2)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: GLASSDOOR REVIEW (BEING YOUR TEAMMATE)
-- ============================================================
local function phase_glassdoor()
    blast(colors.black, colors.lime)
    m.setTextColor(colors.lime)
    center(2,"Glassdoor: Being Your Teammate")
    m.setTextColor(colors.yellow)
    center(3,"1.1 / 5  ("..math.random(50,200).." reviews)")
    fillRow(4,"-",colors.gray,colors.black)
    local items = {
        "PROS:",
        " * Occasionally logs on",
        " * Sometimes says hello before dying",
        " * Free entertainment (constant deaths)",
        " * Great for morale by comparison",
        " * Gerald the pig is lovely actually",
        "",
        "CONS:",
        " * Dies constantly. Every. Session.",
        " * Blames lag. There is no lag.",
        " * Forgot how to craft a sword again",
        " * Took shared iron. Lost to lava.",
        " * Woke a warden at 2am our time",
        " * Grief log is 14 pages about them",
        " * Calls team meetings to discuss",
        "   whether their death was their fault",
        " * It always was",
        " * Every single time",
        " * Filed 6 complaints against the lava",
        "   Lava is not staff",
        "",
        "RECOMMEND THIS TEAMMATE?",
        " No: 312 votes",
        " Yes: 0 votes",
        " Gerald abstained (pig, legally)",
    }
    local row=5
    for _,item in ipairs(items) do
        if row>=h then break end
        m.setTextColor(item:sub(1,1)=="*" and colors.white or
                       item=="" and colors.black or colors.yellow)
        tw(2,row,item,0.013)
        row=row+1
        os.sleep(0.06)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: NEWSPAPER OBITUARY
-- ============================================================
local function phase_obituary()
    blast(colors.black, colors.white)
    m.setTextColor(colors.lightGray)
    center(2,"THE MINECRAFT GAZETTE")
    center(3,"Obituaries Section")
    fillRow(4,"=",colors.gray,colors.black)
    local lines = {
        "INVENTORY PASSED AWAY",
        "",
        "The beloved inventory of",
        clip(genInsult().."."),
        "Departed "..os.date("%A")..".",
        "It was "..math.random(12,240).." items old.",
        "",
        "The inventory is survived by nothing.",
        "There was nothing left.",
        "Not even the accidental hoe.",
        "Actually wait. There was the hoe.",
        "Nobody knows why. Even now.",
        "",
        "In lieu of flowers, the family",
        "requests you stop walking into",
        "the bright orange glowing liquid.",
        "It has been there the entire time.",
        "You have seen it before.",
        "You have seen it "..math.random(50,700).." times.",
        "Yet here we fucking are.",
        "",
        "No memorial service will be held",
        "because you will die again tomorrow",
        "and we cannot afford the flowers.",
        "",
        "Gerald the pig will say a few words.",
        "The chicken will not attend.",
        "The lava sends its warmest regards.",
        "The void is already waiting.",
    }
    local row=5
    for _,line in ipairs(lines) do
        if row>=h then break end
        if line=="" then row=row+1
        else
            m.setTextColor(colors.white)
            center(row,line)
            row=row+1
        end
        os.sleep(0.19)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: AMAZON REVIEW OF THEIR GAMEPLAY
-- ============================================================
local function phase_amazon()
    blast(colors.black, colors.orange)
    m.setTextColor(colors.orange)
    center(2,"Amazon Customer Reviews")
    center(3,"Product: Your Gameplay")
    m.setTextColor(colors.yellow)
    center(4,"1.1/5  ("..math.random(200,2000).." verified reviews)")
    fillRow(5,"-",colors.gray,colors.black)
    local reviews = {
        {s="1*",n="DiamondMiner64",  r="Arrived broken. Cannot be fixed."},
        {s="1*",n="VerifiedBuyer",   r="Fell in lava on delivery. 1 star."},
        {s="1*",n="AdminSteve",      r="As described: completely shit."},
        {s="1*",n="GrindMode",       r="Not as advertised. Much worse."},
        {s="1*",n="BuildMaster",     r="Died to a bat. One single bat."},
        {s="1*",n="CreeperHunter",   r="Complained the entire time."},
        {s="1*",n="SkeletonOfficial",r="Easy target. Will shoot again."},
        {s="5*",n="GeraldThePig",    r="Makes me look incredible. 5/5."},
        {s="5*",n="TheLava",         r="Loyal customer. Excellent. 5/5."},
        {s="5*",n="TheChicken",      r="Satisfying. 5 stars. No regrets."},
        {s="5*",n="TheVoid",         r="10/10 would consume again."},
        {s="1*",n="Notch_Real",      r="I am so, so sorry. 1 star."},
    }
    local row=6
    for _,rv in ipairs(reviews) do
        if row>=h then break end
        local pos=rv.s=="5*"
        m.setTextColor(pos and colors.lime or colors.red)
        put(2,row,rv.s)
        m.setTextColor(colors.cyan)
        put(5,row,(rv.n..":"):sub(1,16))
        m.setTextColor(colors.white)
        put(5+math.min(16,#rv.n)+2,row,rv.r)
        row=row+1
        os.sleep(0.22)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: CRAIGSLIST AD FOR THEIR BASE
-- ============================================================
local function phase_craigslist()
    blast(colors.black, colors.white)
    m.setTextColor(colors.cyan)
    center(2,"Craigslist - Real Estate")
    fillRow(3,"-",colors.gray,colors.black)
    m.setTextColor(colors.yellow)
    center(4,"FOR SALE: Dirt Cube")
    center(5,"Asking: 0 emeralds (firm)")
    fillRow(6,"-",colors.gray,colors.black)
    local desc = {
        "1BR dirt cube in lava-adjacent",
        "neighbourhood. Motivated seller.",
        "(Seller is in the lava.)",
        "",
        "FEATURES:",
        " * 4 walls (authentic dirt)",
        " * Roof: missing, bring your own",
        " * Door: conceptual only",
        " * Windows: 0 (very dark/secure)",
        " * Floor: dirt (also ceiling)",
        " * Lava proximity: excellent",
        " * Void proximity: concerning",
        " * Previous tenant: in the lava",
        "",
        "RECENTLY RENOVATED by a creeper.",
        "Character retained (rubble).",
        "Structural report: not great.",
        "Still technically standing.",
        "",
        "PETS: Pig (Gerald) included.",
        "Chicken haunts property.",
        "Chicken cannot be removed.",
        "We have tried. It is still there.",
        "",
        "CONTACT: [PLAYER] (if still alive)",
        "VIEWS: "..math.random(3,8).." (all admin)",
    }
    local row=7
    for _,line in ipairs(desc) do
        if row>=h then break end
        if line=="" then row=row+1
        else
            m.setTextColor(line:sub(1,1)=="*" and colors.white or colors.lightGray)
            tw(2,row,line,0.012)
            row=row+1
        end
        os.sleep(0.06)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: IT HELPDESK TICKET
-- ============================================================
local function phase_helpdesk()
    blast(colors.black, colors.white)
    center(2,"IT HELPDESK TICKET #"..math.random(10000,99999))
    fillRow(3,"=",colors.gray,colors.black)
    local ticket = {
        "Priority: CRITICAL (again)",
        "Category: User Error (confirmed)",
        "Assigned to: Nobody (volunteer basis)",
        "",
        "ISSUE:",
        "'The lava keeps hurting me.'",
        "'I don't know why it keeps happening.'",
        "",
        "TROUBLESHOOTING:",
        "Step 1: Told user not to touch lava.",
        "User acknowledged. Touched lava.",
        "",
        "Step 2: Placed warning signs.",
        "User read signs. Fell in lava.",
        "",
        "Step 3: Built fence around lava.",
        "User climbed fence. Into lava.",
        "",
        "Step 4: Relocated all nearby lava.",
        "User found new lava. Immediately.",
        "",
        "Step 5: Removed all lava in area.",
        "User went to nether. Fell in lava.",
        "",
        "RESOLUTION: Impossible.",
        "Root cause: user is the problem.",
        "Ticket status: CLOSED (forever).",
        "Escalated to: Gerald.",
        "Gerald declined. Cannot blame Gerald.",
    }
    local row=4
    for _,line in ipairs(ticket) do
        if row>=h then break end
        if line=="" then row=row+1
        else
            m.setTextColor(line:sub(1,4)=="Step" and colors.yellow or
                           line:sub(1,4)=="User" and colors.red or colors.lightGray)
            tw(2,row,line,0.014)
            row=row+1
        end
        os.sleep(0.07)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: NATURE DOCUMENTARY
-- ============================================================
local function phase_documentary()
    blast(colors.black, colors.white)
    m.setTextColor(colors.yellow)
    center(2,"NATURE DOCUMENTARY")
    m.setTextColor(colors.lightGray)
    center(3,"Narrated by Sir David Attenborough")
    fillRow(4,"-",colors.gray,colors.black)
    local narration = {
        "Here we observe the creature",
        "in its natural habitat:",
        "a small cube made entirely of dirt.",
        "It built this. On purpose.",
        "",
        "Notice how it approaches the lava.",
        "It has seen this lava before.",
        "Many, many times.",
        "Each time: genuinely surprised.",
        "Every. Single. Time.",
        "",
        "The creature has a companion.",
        "A pig named Gerald.",
        "Gerald is the dominant one.",
        "This is not in dispute.",
        "Gerald has accepted the role.",
        "",
        "A chicken approaches.",
        "The creature freezes.",
        "Something happened between them.",
        "The details remain classified.",
        "The chicken remembers everything.",
        "",
        "The creature steps into the lava.",
        "The lava is not surprised.",
        "The lava is never surprised.",
        "The lava has learned to expect this.",
        "The lava has come to enjoy it.",
        "",
        "Gerald watches from a safe distance.",
        "Gerald has never touched the lava.",
        "Gerald will never touch the lava.",
        "Gerald is better than all of us.",
        "We could learn from Gerald.",
        "We choose not to.",
    }
    local row=5
    for _,line in ipairs(narration) do
        if row>=h then break end
        if line=="" then row=row+1
        else
            m.setTextColor(colors.white)
            center(row,line)
            row=row+1
        end
        os.sleep(0.26)
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: PROGRESS REPORT / REPORT CARD
-- ============================================================
local function phase_reportcard()
    blast(colors.black, colors.white)
    center(2,"MINECRAFT PROGRESS REPORT")
    center(3,"Student: "..clip(genInsult()))
    fillRow(4,"=",colors.gray,colors.black)
    local grades = {
        {"Lava Avoidance",       "F",   "Falls in lava. Consistently."},
        {"Skeleton Awareness",   "F",   "Awareness: zero. Results: death."},
        {"Inventory Mgmt",       "F+",  "14 dirt. Sorted by nothing."},
        {"Crafting Knowledge",   "D-",  "Can craft hoe. Keeps doing it."},
        {"Map Reading",          "F",   "Never once consulted a map."},
        {"PvP Combat",           "F",   "Lost to a chicken. Documented."},
        {"Base Design",          "F",   "Dirt cube. No further comment."},
        {"Teamwork",             "D",   "Blames teammates every time."},
        {"Appeal Writing",       "C+",  "Prolific. Incorrect. Prolific."},
        {"Dirt Hoarding",        "A+",  math.random(5000,99999).." blocks. Astonishing."},
        {"Death Frequency",      "A+",  math.random(400,999).." deaths. Honour roll."},
        {"Cope Production",      "A+",  "World-class. Prodigious output."},
        {"Self-Awareness",       "F",   "Not present. Not even a trace."},
        {"Gerald (the pig)",     "A",   "Gerald thriving. Unlike you."},
        {"Overall",              "F",   "No improvement detected ever."},
    }
    local row=5
    for _,g in ipairs(grades) do
        if row>=h then break end
        m.setTextColor(g[2]=="A+" and colors.lime or
                       g[2]=="A"  and colors.lime or
                       g[2]=="C+" and colors.yellow or
                       g[2]:sub(1,1)=="D" and colors.orange or colors.red)
        local subj=g[1]:sub(1,18)
        put(2,row,subj)
        put(21,row,g[2])
        m.setTextColor(colors.lightGray)
        put(25,row,g[3])
        row=row+1
        os.sleep(0.22)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: VOICEMAILS
-- ============================================================
local function phase_voicemail()
    blast(colors.black, colors.white)
    center(2,"VOICEMAIL ("..math.random(15,40).." NEW)")
    fillRow(3,"-",colors.gray,colors.black)
    local vms = {
        {"Admin",         "We need to talk about the TNT. All of it."},
        {"The Skeleton",  "Courtesy call. Left your stuff behind. Lol."},
        {"Creeper Corp.", "Thank you for your recent base donation."},
        {"Gerald",        "This is Gerald. I have all your diamonds."},
        {"The Void",      "Hey. Just checking in. See you very soon."},
        {"Warden HQ",     "*17 seconds of breathing* ...I heard you."},
        {"The Chicken",   "..."},
        {"The Chicken",   "I know."},
        {"Admin",         "RE: TNT. Also the lava. Also the chicken."},
        {"Gravel",        "Your fault. Always your fault. - Gravel"},
        {"Gerald",        "Moving into your server slot. Thanks bye."},
        {"The Lava",      "Hi. Missed you. See you tonight probably."},
        {"Phantom Co.",   "RE: Your sleep debt. It is extremely large."},
        {"The Enderman",  "Stop. Looking. At me. I can hear you."},
        {"Admin",         "Your death count broke the leaderboard."},
        {"Admin",         "Had to use a bigger integer type. Thanks."},
        {"Gerald",        "I have your account now. Thank you. Bye."},
        {"The Chicken",   "..."},
        {"The Chicken",   "You know exactly what you did. Exactly."},
        {"The Void",      "Still here. Still waiting. No rush. Bye."},
        {"Mom",           "Honey it is 3am please go to sleep."},
        {"Admin",         "Please. Just please. Stop. Please."},
    }
    local row=4
    for _,vm in ipairs(vms) do
        if row>=h then break end
        m.setTextColor(colors.cyan)
        local nm=(vm[1]..":"):sub(1,14)
        put(2,row,nm)
        m.setTextColor(colors.white)
        put(2+#nm,row,vm[2])
        row=row+1
        os.sleep(0.22)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: BREAKING NEWS INTERVIEW
-- ============================================================
local function phase_interview()
    blast(colors.black, colors.white)
    center(2,"LIVE BREAKING NEWS INTERVIEW")
    fillRow(3,"=",colors.gray,colors.black)
    local interview = {
        {"R","Sir. You fell in lava again."},
        {"P","It was lag."},
        {"R","The logs show zero lag."},
        {"P","The logs are wrong."},
        {"R","The logs are not wrong."},
        {"P","...The logs are not wrong."},
        {"R","What happened to the diamonds?"},
        {"P","They are in the lava now."},
        {"R","How many diamonds?"},
        {"P",tostring(math.random(5,64)).." diamonds."},
        {"R","How did they enter the lava?"},
        {"P","I walked into the lava."},
        {"R","You walked into the lava."},
        {"P","Yes."},
        {"R","The bright orange glowing lava."},
        {"P","Yes."},
        {"R","That was loudly hissing."},
        {"P","Yes."},
        {"R","Any final statement?"},
        {"P","I am pre-filing an unban appeal."},
        {"R","You haven't been banned."},
        {"P","Covers future incidents."},
        {"R","...We go to Gerald now."},
        {"G","Oink."},
        {"R","Gerald has more to say."},
        {"G","Oink. Oink."},
        {"R","Powerful words. Back to studio."},
        {"G","OINK. [I TOLD HIM. HE DIDN'T LISTEN.]"},
    }
    local row=4
    for _,line in ipairs(interview) do
        if row>=h then break end
        m.setTextColor(
            line[1]=="R" and colors.cyan or
            line[1]=="G" and colors.lime or
            colors.white
        )
        local who=line[1]=="R" and "REPORTER: " or
                  line[1]=="G" and "GERALD:   " or
                  "PLAYER:   "
        tw(2,row,who..line[2],0.015)
        row=row+1
        os.sleep(0.14)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: GOVERNMENT CENSUS
-- ============================================================
local function phase_census()
    blast(colors.black, colors.white)
    center(2,"OFFICIAL GOVERNMENT CENSUS")
    center(3,"Subject: "..clip(genInsult()))
    fillRow(4,"=",colors.gray,colors.black)
    local data = {
        "OCCUPATION:",
        " Listed: 'Gamer'",
        " Actual: Lava donation service",
        " GDP contribution: negative",
        "",
        "PROPERTY:",
        " Primary residence: dirt cube",
        " Secondary: the respawn screen",
        " Tertiary: inside lava (frequent)",
        " Asset value: "..math.random(0,3).." emeralds total",
        "",
        "SOCIAL CONNECTIONS:",
        " Human friends: "..math.random(0,2),
        " Pigs (named Gerald): 1",
        " Chickens (hostile): 1",
        " Void relationships: ongoing",
        " Lava relationships: complicated",
        "",
        "SKILLS DECLARATION:",
        " Declared: 'Pretty good at this'",
        " Verified: "..math.random(0,1).." skills confirmed",
        " Unban appeals: "..math.random(5,55).." filed",
        " Dirt collected: "..math.random(5000,99999).." blocks",
        "",
        "CENSUS NOTES:",
        " Subject declined to elaborate.",
        " Gerald provided most data.",
        " Gerald was more accurate.",
        " And articulate.",
        " Gerald is just better.",
    }
    local row=5
    for _,line in ipairs(data) do
        if row>=h then break end
        if line=="" then row=row+1
        else
            m.setTextColor(line:sub(-1)==":" and colors.yellow or colors.lightGray)
            tw(2,row,line,0.013)
            row=row+1
        end
        os.sleep(0.06)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: COOKING SHOW
-- ============================================================
local function phase_cookingshow()
    blast(colors.black, colors.orange)
    m.setTextColor(colors.orange)
    center(2,"COOKING WITH DISASTER")
    center(3,"A Minecraft Disaster Recipe Guide")
    fillRow(4,"-",colors.orange,colors.black)
    local recipes = {
        "RECIPE: HOW TO LOSE DIAMONDS",
        "",
        "INGREDIENTS:",
        " * 1-64 diamonds (any quality)",
        " * 1 lava lake (size: any)",
        " * 1 failure to look downward",
        " * 3 hearts of health (optional)",
        " * Absolute confidence (incorrect)",
        "",
        "METHOD:",
        " 1. Acquire diamonds painstakingly.",
        " 2. Walk toward lava confidently.",
        " 3. Ignore the orange visual cues.",
        " 4. Ignore the loud hissing sound.",
        " 5. Ignore Gerald's panicked oinking.",
        " 6. Step directly into the lava.",
        " 7. Watch your diamonds sink slowly.",
        " 8. Type 'it was lag' in chat.",
        " 9. Begin unban appeal (pre-emptively).",
        "",
        "SERVES: 0 people.",
        "PREP: "..math.random(30,180).." mins mining",
        "COOK TIME: 0.4 seconds in lava",
        "",
        "NOTE: This recipe has been made",
        tostring(math.random(5,64)).." times. Each time:",
        "somehow a complete surprise.",
        "Gerald does not make this dish.",
        "Gerald has never made this dish.",
        "Aspire to be Gerald.",
    }
    local row=5
    for _,rv in ipairs(recipes) do
        if row>=h then break end
        if rv=="" then row=row+1
        else
            m.setTextColor(rv:sub(1,1)=="*" and colors.white or
                           rv:sub(1,6)=="RECIPE" and colors.yellow or
                           rv:sub(1,3)=="ING" and colors.cyan or
                           rv:sub(1,3)=="MET" and colors.cyan or
                           rv:sub(1,4)=="SERV" and colors.cyan or
                           rv:sub(1,4)=="PREP" and colors.cyan or
                           rv:sub(1,4)=="COOK" and colors.cyan or
                           rv:sub(1,4)=="NOTE" and colors.cyan or
                           colors.lightGray)
            tw(2,row,rv,0.012)
            row=row+1
        end
        os.sleep(0.07)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: POWERPOINT PRESENTATION
-- ============================================================
local function phase_powerpoint()
    local slides = {
        {
            title="Q"..math.random(1,4).." DEATH REVIEW",
            sub="Presented by: The Admin (reluctantly)",
            body={
                "Total deaths: "..math.random(300,999),
                "Deaths by lava: "..math.random(100,500),
                "Deaths by lag*: 0",
                "(*there was no lag. Ever.)",
                "Deaths caused by skill issue: ALL",
                "YoY improvement: -"..math.random(10,40).."%",
                "Trend: worsening",
                "Gerald: doing great (unrelated)",
            }
        },
        {
            title="ROOT CAUSE ANALYSIS",
            sub="Why does this keep happening to us",
            body={
                "Hypothesis A: It's lag",
                "Result: Disproven (server logs)",
                "Hypothesis B: Bad luck",
                "Result: Disproven (consistent pattern)",
                "Hypothesis C: The game's fault",
                "Result: Disproven (others are fine)",
                "Hypothesis D: Skill issue",
                "Result: CONFIRMED. 100%. Always.",
                "Confidence interval: very confident",
                "P-value: embarrassingly small",
            }
        },
        {
            title="GOING FORWARD",
            sub="Strategic recommendations (unread)",
            body={
                "1. Stop walking into lava",
                "2. The lava will always be there",
                "3. Orange means hot. Hot means bad.",
                "4. Consider peaceful mode",
                "5. Or just quitting entirely",
                "6. Gerald endorses option 5",
                "7. The chicken endorses option 5",
                "8. We all endorse option 5",
                "9. This has been adopted",
                "   as official server policy",
            }
        },
    }
    for _,slide in ipairs(slides) do
        blast(colors.black, colors.white)
        m.setTextColor(colors.cyan)
        center(2,slide.title)
        m.setTextColor(colors.lightGray)
        center(3,slide.sub)
        fillRow(4,"-",colors.gray,colors.black)
        local row=5
        for _,b in ipairs(slide.body) do
            if row>=h then break end
            m.setTextColor(colors.white)
            tw(2,row,b,0.014)
            row=row+1
            os.sleep(0.1)
        end
        os.sleep(3.5)
    end
end

-- ============================================================
-- PHASE: COURTROOM DRAMA
-- ============================================================
local function phase_courtroom()
    blast(colors.black, colors.white)
    center(2,"MINECRAFT CRIMINAL COURT")
    center(3,"Lava v. "..clip(genInsult()))
    fillRow(4,"=",colors.gray,colors.black)
    local transcript = {
        {"JUDGE",   "Court in session. Charges?"},
        {"PROS.",   "Defendant walked into lava."},
        {"JUDGE",   "How many times?"},
        {"PROS.",   tostring(math.random(50,700)).." times, Your Honour."},
        {"JUDGE",   "Good lord."},
        {"DEF.",    "It was lag, Your Honour."},
        {"JUDGE",   "The logs show no lag."},
        {"DEF.",    "The logs are wrong."},
        {"JUDGE",   "They are not wrong."},
        {"DEF.",    "...The logs are not wrong."},
        {"PROS.",   "Exhibit A: the lava."},
        {"PROS.",   "Exhibit B: all the lost diamonds."},
        {"PROS.",   "Exhibit C: "..math.random(5,55).." unban appeals."},
        {"JUDGE",   "These appeals are addressed to the lava."},
        {"DEF.",    "I was hoping for a settlement."},
        {"JUDGE",   "The lava cannot settle. It is lava."},
        {"DEF.",    "What about Gerald?"},
        {"JUDGE",   "Gerald is a witness."},
        {"GERALD",  "Oink. [Did it. Every time. No lag.]"},
        {"JUDGE",   "Noted. And the chicken?"},
        {"CHICKEN", "..."},
        {"JUDGE",   "The chicken's silence is very damning."},
        {"JUDGE",   "Verdict: skill issue. Fully guilty."},
        {"JUDGE",   "Sentence: mandatory grass-touching."},
        {"DEF.",    "I would like to appeal."},
        {"JUDGE",   "This IS your appeal. Your 12th."},
        {"JUDGE",   "Get out of my courtroom."},
    }
    local row=5
    for _,line in ipairs(transcript) do
        if row>=h then break end
        m.setTextColor(
            line[1]=="JUDGE"   and colors.yellow or
            line[1]=="PROS."   and colors.red or
            line[1]=="GERALD"  and colors.lime or
            line[1]=="CHICKEN" and colors.orange or
            colors.white
        )
        tw(2,row,line[1]..": "..line[2],0.015)
        row=row+1
        os.sleep(0.13)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: TRANSACTION DECLINED
-- ============================================================
local function phase_declined()
    blast(colors.black, colors.red)
    center(2,"TRANSACTION DECLINED")
    fillRow(3,"=",colors.red,colors.black)
    local transactions = {
        {"1x Skill",             "0g",  "INSUFFICIENT FUNDS"},
        {"Lava Awareness",       "0g",  "ACCOUNT EMPTY"},
        {"1x Map Reading",       "1g",  "DECLINED (no brain)"},
        {"PvP Win (1 total)",    "5g",  "ITEM OUT OF STOCK"},
        {"1x Good Decision",     "2g",  "FRAUD DETECTED"},
        {"Unban Appeal",         "0g",  "REJECTED (12th one)"},
        {"1 Unit of Dignity",    "free","NO LONGER AVAILABLE"},
        {"1 Friend",             "free","DECLINED (no reason)"},
        {"Gerald's Respect",     "10g", "INSUFFICIENT SKILL"},
        {"Chicken's Forgiveness","100g","NOT FOR SALE"},
        {"Void's Mercy",         "???", "LAUGHED AT (audibly)"},
        {"1x Improvement",       "0g",  "SYSTEM ERROR"},
        {"Being Less Shit",      "0g",  "NICE TRY (declined)"},
    }
    local row=4
    m.setTextColor(colors.lightGray)
    tw(2,row,"ITEM              PRICE  STATUS",0.005)
    row=row+1
    fillRow(row,"-",colors.gray,colors.black)
    row=row+1
    for _,t in ipairs(transactions) do
        if row>=h then break end
        m.setTextColor(t[3]:find("DECLINED") and colors.red or
                       t[3]:find("REJECTED") and colors.red or
                       t[3]:find("FUND") and colors.red or
                       colors.orange)
        local line=string.format("%-17s %-6s %s",
            t[1]:sub(1,17),t[2],t[3]):sub(1,w-2)
        tw(2,row,line,0.006)
        row=row+1
        os.sleep(0.1)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: HONEST MINECRAFT MANUAL
-- ============================================================
local function phase_manual()
    blast(colors.black, colors.white)
    m.setTextColor(colors.yellow)
    center(2,"MINECRAFT: HONEST MANUAL")
    m.setTextColor(colors.lightGray)
    center(3,"Special Edition (for you specifically)")
    fillRow(4,"-",colors.gray,colors.black)
    local pages = {
        "CHAPTER 1: LAVA",
        "Lava is orange. It kills you.",
        "It is always orange. Always.",
        "Stop walking into it.",
        "You will not stop walking into it.",
        "We have accepted this about you.",
        "",
        "CHAPTER 2: CREEPERS",
        "Creepers go 'sssss' then explode.",
        "Run away from the hissing sound.",
        "You will turn toward the sound.",
        "You will look directly at it.",
        "You will die. Your fault.",
        "",
        "CHAPTER 3: THE WARDEN",
        "Do not go to the deep dark.",
        "Do not place torches down there.",
        "Do not breathe near it.",
        "Do not go there at all.",
        "You will go there.",
        "You will place 47 torches.",
        "You will breathe very loudly.",
        "Goodbye and good luck.",
        "",
        "CHAPTER 4: GERALD",
        "Gerald is a pig. Gerald is fine.",
        "Gerald is significantly better than you.",
        "Listen to Gerald.",
        "Actually follow Gerald's example.",
        "Gerald will be okay.",
        "You may not be okay.",
        "That is the end of the manual.",
    }
    local row=5
    for _,p in ipairs(pages) do
        if row>=h then break end
        if p=="" then row=row+1
        else
            m.setTextColor(p:sub(1,7)=="CHAPTER" and colors.cyan or colors.white)
            tw(2,row,p,0.014)
            row=row+1
        end
        os.sleep(0.1)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: CONFESSIONAL BOOTH
-- ============================================================
local function phase_confessional()
    blast(colors.black, colors.red)
    center(2,"THE CONFESSIONAL")
    center(3,"(anonymous. obviously you.)")
    fillRow(4,"=",colors.red,colors.black)
    local confessions = {
        "I have died to lava "..math.random(50,700).." times.",
        "I told people it was lag each time.",
        "It was not lag.",
        "I knew it was not lag.",
        "I was standing in the lava.",
        "I walked into the lava.",
        "On purpose. A few times.",
        "I genuinely cannot tell anymore.",
        "",
        "I have "..math.random(5000,99999).." blocks of dirt.",
        "I do not know why I have this.",
        "I cannot stop collecting dirt.",
        "I thought about seeking help.",
        "I collected more dirt instead.",
        "",
        "I lost full netherite to lava.",
        "I told the server it was lag.",
        "The server has the logs.",
        "The server has always had the logs.",
        "",
        "The chicken beat me in PvP.",
        "It was a chicken.",
        "I reported it.",
        "The admin laughed.",
        "The admin is still laughing.",
        "That was "..math.random(2,8).." weeks ago.",
        "",
        "Gerald is a better player than me.",
        "I have made peace with this.",
        "I have absolutely not made peace.",
    }
    local row=5
    for _,c in ipairs(confessions) do
        if row>=h then break end
        if c=="" then row=row+1
        else
            m.setTextColor(rnd(colors_list))
            tw(2,row,c,0.016)
            row=row+1
        end
        os.sleep(0.11)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: LOADING TIPS (EXTREMELY PASSIVE AGGRESSIVE)
-- ============================================================
local function phase_tips()
    local tips_list = {
        {
            hdr="DID YOU KNOW",
            body={
                "Lava is orange because it is very hot.",
                "You could not have known this.",
                "You have walked into it "..math.random(50,700).." times.",
                "The orange has always been there.",
                "The orange will always be there.",
                "It is always going to be orange.",
            }
        },
        {
            hdr="PRO TIP",
            body={
                "Beds exist. You can sleep in them.",
                "Sleeping prevents phantom spawning.",
                "Phantoms spawn from YOUR sleep debt.",
                "You have a very large sleep debt.",
                "You have never once used a bed.",
                "The phantoms are YOUR fault.",
            }
        },
        {
            hdr="FUN FACT",
            body={
                "The warden navigates entirely by sound.",
                "If you are quiet it cannot find you.",
                "You are never quiet.",
                "You placed 47 torches last time.",
                "You breathed very loudly.",
                "It always finds you. Your fault.",
            }
        },
        {
            hdr="DID YOU KNOW",
            body={
                "Shields block incoming attacks.",
                "You have never crafted a shield.",
                "They need 1 iron and 6 planks.",
                "You have "..math.random(5000,99999).." planks.",
                "You have plenty of iron too.",
                "You just never make a shield.",
            }
        },
        {
            hdr="LOADING TIP",
            body={
                "Dying is largely avoidable.",
                "Most players avoid it routinely.",
                "These players are called 'most players'.",
                "You are called 'the one who dies'.",
                "You are called this by everyone.",
                "Including Gerald. Gerald uses that name.",
            }
        },
        {
            hdr="DID YOU KNOW",
            body={
                "Gerald the pig is doing very well.",
                "Gerald has never died to lava.",
                "Gerald has never died at all.",
                "Gerald has a positive K/D ratio.",
                "Gerald is, statistically, better.",
                "Aspire to be Gerald.",
            }
        },
    }
    for _,tip in ipairs(tips_list) do
        blast(colors.black, colors.black)
        local mid=math.floor(h/2)
        m.setTextColor(colors.yellow)
        center(math.max(1,mid-3),tip.hdr)
        fillRow(math.max(1,mid-2),"-",colors.gray,colors.black)
        m.setTextColor(colors.white)
        local startRow=math.max(1,mid-1)
        for _,line in ipairs(tip.body) do
            if startRow>h then break end
            center(startRow,line)
            startRow=startRow+1
        end
        os.sleep(3.5)
    end
end

-- ============================================================
-- PHASE: FINAL BOSS MONOLOGUE
-- ============================================================
local function phase_finalboss()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(2,"THE FINAL BOSS SPEAKS")
    fillRow(3,"=",colors.red,colors.black)
    local speech = {
        "I have watched you for a long time.",
        "Since the very beginning, actually.",
        "I have watched every single death.",
        "All "..math.random(300,999).." of them.",
        "",
        "I watched you walk into lava.",
        "And again.",
        "And again.",
        "And again after that.",
        "I have never seen anything like it.",
        "I have been the final boss",
        "of this game for many years.",
        "I have seen thousands of players.",
        "Nobody walks into lava this many times.",
        "It's almost impressive.",
        "It is not impressive.",
        "But it is almost impressive.",
        "",
        "I'm not going to fight you.",
        "I don't need to fight you.",
        "The lava is handling it.",
        "The lava has always handled it.",
        "I am just here to watch.",
        "Like everyone else.",
        "Like Gerald.",
        "Like the chicken.",
        "We all watch.",
        "We have all accepted our role.",
        "",
        "Good luck.",
        "You will need it.",
        "You always need it.",
        "It never helps.",
        "Nothing has ever helped.",
        "But genuinely: good luck.",
    }
    local row=4
    for _,line in ipairs(speech) do
        if row>=h then break end
        if line=="" then row=row+1
        else
            m.setTextColor(rnd(colors_list))
            tw(2,row,line,0.018)
            row=row+1
        end
        os.sleep(0.14)
    end
    os.sleep(5)
end



-- ============================================================
-- PHASE: GROUP CHAT (friends reacting in real time)
-- ============================================================
local function phase_groupchat()
    blast(colors.black, colors.black)
    m.setTextColor(colors.green)
    center(1,"Group Chat: xynia smp lads")
    fillRow(2,"-",colors.gray,colors.black)
    local names = {"dave","callum","josh","meg","tom","soph","rory","el"}
    local msgs = {
        {"bro","did u just die to a bat"},
        {"","a single bat"},
        {"","one (1) bat"},
        {"lol","LMAOOOO"},
        {"bro","how"},
        {"","HOW"},
        {"","i watched it happen"},
        {"","i watched the bat find you"},
        {"","the bat looked CONFUSED"},
        {"bro","please tell me someone clipped that"},
        {"lol","already uploaded"},
        {"","it has 47 views in 4 minutes"},
        {"","mostly from admin"},
        {"admin","(admin has entered the chat)"},
        {"admin","i have seen many things on this server"},
        {"admin","i was not prepared for the bat"},
        {"admin","no one could have been prepared for the bat"},
        {"bro","are you okay though"},
        {"","genuinely"},
        {"","because the bat"},
        {"lol","THE BAT DIDNT EVEN AGGRO NATURALLY"},
        {"","you PUNCHED it first"},
        {"","why did you punch the bat"},
        {"bro","what were you hoping would happen"},
        {"","what was the plan"},
        {"admin","there was no plan"},
        {"admin","ive seen the logs"},
        {"admin","there has never been a plan"},
        {"lol","gerald has a plan though"},
        {"","gerald always has a plan"},
        {"","gerald is doing so well"},
        {"bro","we love gerald"},
        {"","protect gerald"},
        {"lol","gerald would never punch a bat"},
        {"admin","gerald has never punched a bat"},
        {"admin","for the record"},
        {"bro","classic gerald"},
        {"","anyway"},
        {"","you gonna log back on"},
        {"lol","theyre already back on"},
        {"","they died again"},
        {"","different bat"},
        {"admin","(admin has left the chat)"},
    }
    local row = 3
    for _,msg in ipairs(msgs) do
        if row >= h then break end
        local who = msg[1]
        local txt  = msg[2]
        if who == "" then
            m.setTextColor(colors.lightGray)
            put(6, row, txt)
        elseif who == "admin" then
            m.setTextColor(colors.red)
            put(2, row, "[admin] " .. txt)
        else
            m.setTextColor(rnd(colors_list))
            local name = rnd(names)
            put(2, row, name .. ": " .. txt)
        end
        row = row + 1
        os.sleep(0.22)
    end
    os.sleep(4)
end

-- ============================================================
-- PHASE: GAME SHOW (Who Wants To Be A Millionaire-style)
-- Player gets every minecraft basic wrong
-- ============================================================
local function phase_gameshow()
    blast(colors.black, colors.blue)
    m.setTextColor(colors.yellow)
    center(2,"WHO WANTS TO NOT DIE IN MINECRAFT")
    m.setTextColor(colors.lightGray)
    center(3,"A Gameshow For One Very Specific Person")
    fillRow(4,"-",colors.blue,colors.black)

    local questions = {
        {
            q  = "What should you do when you see lava?",
            a  = {"A: Touch it","B: Swim in it","C: Walk away","D: Dive in"},
            ca = "C",
            pa = rnd({"A","B","D"}),
            ex = "You chose to touch the lava. The answer was C.",
        },
        {
            q  = "What does a creeper's hiss mean?",
            a  = {"A: It's friendly","B: Run away","C: Pet it","D: Wave"},
            ca = "B",
            pa = rnd({"A","C","D"}),
            ex = "You waved at it. The answer was B: run away.",
        },
        {
            q  = "What is a shield used for?",
            a  = {"A: Eating","B: Blocking attacks","C: Farming","D: No idea"},
            ca = "B",
            pa = "D",
            ex = "You answered 'no idea'. Correct self-assessment.",
        },
        {
            q  = "How do you avoid phantom attacks?",
            a  = {"A: Sleep in a bed","B: Punch the sky","C: More dirt","D: Ignore them"},
            ca = "A",
            pa = rnd({"B","C","D"}),
            ex = "You chose 'more dirt'. The answer was A: sleep.",
        },
        {
            q  = "What colour is lava?",
            a  = {"A: Blue","B: Green","C: Orange","D: Transparent"},
            ca = "C",
            pa = rnd({"A","B","D"}),
            ex = "You answered " .. rnd({"blue","green","transparent"}) .. ". It is orange. You know this.",
        },
    }

    local score = 0
    for i,q in ipairs(questions) do
        blast(colors.black, colors.blue)
        m.setTextColor(colors.yellow)
        center(2,"QUESTION " .. i .. " OF " .. #questions)
        m.setTextColor(colors.white)
        -- wrap question across two lines if needed
        local qlen = #q.q
        if qlen <= w-4 then
            center(4, q.q)
        else
            center(4, q.q:sub(1,w-4))
            center(5, q.q:sub(w-3))
        end
        local row = 6
        for _,ans in ipairs(q.a) do
            m.setTextColor(colors.lightGray)
            center(row, ans)
            row = row + 1
        end
        os.sleep(2)
        m.setTextColor(colors.red)
        center(row+1, "Your answer: " .. q.pa)
        os.sleep(0.8)
        m.setTextColor(colors.lime)
        center(row+2, "Correct:     " .. q.ca)
        os.sleep(0.8)
        m.setTextColor(colors.orange)
        center(row+3, q.ex)
        os.sleep(2.5)
    end

    blast(colors.black, colors.blue)
    m.setTextColor(colors.red)
    center(math.floor(h/2)-2, "FINAL SCORE: " .. score .. " / " .. #questions)
    center(math.floor(h/2),   "PRIZE MONEY: 0 EMERALDS")
    center(math.floor(h/2)+2, "Gerald scored " .. #questions .. "/" .. #questions)
    center(math.floor(h/2)+4, "First try. Without studying.")
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: INTERVENTION (friends staging an intervention)
-- ============================================================
local function phase_intervention()
    blast(colors.black, colors.white)
    m.setTextColor(colors.red)
    center(2,"WE NEED TO TALK")
    m.setTextColor(colors.lightGray)
    center(3,"A Formal Intervention")
    fillRow(4,"=",colors.gray,colors.black)
    local lines = {
        "We've gathered here today because",
        "we care about you.",
        "And because the lava situation",
        "has become genuinely untenable.",
        "",
        "Dave wanted to say:",
        "'I watched you walk into it.",
        " I said stop. You sped up.",
        " I don't understand.'",
        "",
        "Callum's letter reads:",
        "'You've died " .. math.random(300,999) .. " times.",
        " I've counted. I wish I hadn't.",
        " Please. For us. Stop.'",
        "",
        "The admin prepared a slideshow.",
        "The slideshow is " .. math.random(40,200) .. " slides long.",
        "Each slide is a death.",
        "Many slides look identical.",
        "They are not identical.",
        "You found new ways.",
        "",
        "Gerald the pig attended.",
        "Gerald did not speak.",
        "Gerald's presence said everything.",
        "",
        "The chicken was invited.",
        "The chicken did not come.",
        "The chicken sent a note.",
        "The note said: 'Sort it out.'",
        "",
        "We love you.",
        "Please stop walking into lava.",
        "That is the whole ask.",
        "Just that one thing.",
    }
    local row = 5
    for _,line in ipairs(lines) do
        if row >= h then break end
        if line == "" then row = row + 1
        else
            m.setTextColor(line:sub(1,1)=="'" and colors.white or colors.lightGray)
            tw(2, row, line, 0.016)
            row = row + 1
        end
        os.sleep(0.1)
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: AUTOPSY REPORT
-- ============================================================
local function phase_autopsy()
    blast(colors.black, colors.white)
    center(2,"POST-MORTEM REPORT #" .. math.random(100,999))
    center(3,"Pathologist: Dr. Admin")
    fillRow(4,"=",colors.gray,colors.black)
    local causes = {
        {c="Lava immersion",
         n="Voluntary. Repeated. Unexplained.",
         t="Orange glow, hissing sound, several signs,",
         t2="a fence, two verbal warnings, Gerald oinking."},
        {c="Skeleton projectile",
         n="Arrow to the face. Skeleton was " .. math.random(20,80) .. " blocks away.",
         t="Patient was standing still. In the open.",
         t2="Looking in the wrong direction. As usual."},
        {c="Creeper detonation",
         n="Patient turned toward the hissing sound.",
         t="Made eye contact. Did not run.",
         t2="Said 'oh no' at appropriate time. Too late."},
        {c="Fall damage",
         n="Patient dug straight down. Again.",
         t="Wiki explicitly advises against this.",
         t2="Patient has never read the wiki."},
        {c="Void",
         n="Patient fell off the end island.",
         t="Was attempting to 'look at the void'.",
         t2="Patient is now also in the void."},
    }
    local death = rnd(causes)
    local items = {
        "CAUSE OF DEATH:",
        "  " .. death.c,
        "",
        "CIRCUMSTANCES:",
        "  " .. death.n,
        "",
        "WARNING SIGNS PRESENT:",
        "  " .. death.t,
        "  " .. death.t2,
        "",
        "TOXICOLOGY:",
        "  Blood hopium level: dangerously high",
        "  Lag: not detected (never detected)",
        "  Skill: not detected",
        "",
        "ITEMS LOST:",
        "  " .. math.random(0,3) .. "x Diamond",
        "  " .. math.random(0,64) .. "x Dirt (obviously)",
        "  1x Leather Boot (left, always left)",
        "  1x Dignity (not recovered)",
        "",
        "CORONER'S NOTE:",
        "  This is the " .. math.random(3,15) .. "th report this week.",
        "  Gerald remains unharmed.",
        "  Gerald was present.",
        "  Gerald tried to warn them.",
        "  Gerald always tries.",
        "  It never works.",
    }
    local row = 5
    for _,item in ipairs(items) do
        if row >= h then break end
        if item == "" then row = row + 1
        else
            m.setTextColor(item:sub(-1) == ":" and colors.yellow or colors.lightGray)
            tw(2, row, item, 0.014)
            row = row + 1
        end
        os.sleep(0.07)
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: FORMAL COMPLAINTS DEPARTMENT
-- ============================================================
local function phase_complaints()
    blast(colors.black, colors.white)
    center(2,"COMPLAINTS RECEIVED: TODAY")
    fillRow(3,"=",colors.gray,colors.black)
    local complaints = {
        {f="The Lava",    r="Player keeps visiting uninvited.",
                          s="Ongoing",n=math.random(20,200)},
        {f="The Skeleton",r="Player stands still, makes it too easy.",
                          s="Closed",n=math.random(5,50)},
        {f="The Creeper", r="Player turned toward the sound again.",
                          s="Resolved",n=math.random(10,80)},
        {f="The Warden",  r="Player placed 47 torches. Breathing.",
                          s="Escalated",n=1},
        {f="The Golem",   r="Player punched me. Twice. On purpose.",
                          s="Under review",n=2},
        {f="The Void",    r="Player argues after falling in.",
                          s="Dismissed",n=math.random(15,60)},
        {f="The Chicken", r="See attached 93-page document.",
                          s="Ongoing",n=1},
        {f="Gerald",      r="Player keeps calling me 'just a pig'.",
                          s="Valid",n=1},
        {f="The Village", r="Player burned it. Claims accident.",
                          s="Closed (arson)",n=1},
        {f="The Server",  r="Player exists on it.",
                          s="Cannot resolve",n=math.random(100,500)},
        {f="The Dirt",    r="Too much. Stop. Please stop collecting us.",
                          s="Ignored",n=math.random(1000,9000)},
        {f="Gravel",      r="Player trusts us. We don't want this.",
                          s="Ongoing",n=math.random(30,150)},
    }
    local row = 4
    m.setTextColor(colors.lightGray)
    put(2, row, "FROM            STATUS      #COMPLAINTS")
    row = row + 1
    fillRow(row,"-",colors.gray,colors.black)
    row = row + 1
    for _,c in ipairs(complaints) do
        if row >= h then break end
        m.setTextColor(c.s=="Ongoing" and colors.red or
                       c.s=="Escalated" and colors.orange or
                       c.s=="Valid" and colors.yellow or colors.lightGray)
        local line = string.format("%-16s%-12s%d",
            c.f:sub(1,15), c.s:sub(1,11), c.n)
        tw(2, row, line, 0.007)
        row = row + 1
        os.sleep(0.14)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: PLAYER MVPE CEREMONY (worst player awards)
-- ============================================================
local function phase_mvpe()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.yellow)
    center(2,"SMP AWARDS CEREMONY")
    center(3,os.date("%Y") .. " ANNUAL RECOGNITION NIGHT")
    fillRow(4,"-",colors.yellow,colors.black)
    local awards = {
        {a="Most Deaths (Server Record)",      w=genInsult(),     r="By a significant margin."},
        {a="Best Lava Relationship",            w="The Player",    r="Both parties committed."},
        {a="Worst Base Design",                 w="The Dirt Cube", r="Unanimous. Unopposed."},
        {a="Most Unban Appeals (Any Month)",    w="The Player",    r=math.random(6,55).." appeals. One month."},
        {a="Player Most Likely To Punch Golem", w="The Player",    r="Has done it multiple times."},
        {a="Lifetime Achievement: Dying",       w=genInsult(),     r="Contributions: immense."},
        {a="Server's Biggest Charity Project",  w="The Player",    r="We help where we can."},
        {a="Best Performance: Blaming Lag",     w="The Player",    r="Committed. Consistent. Wrong."},
        {a="Most Improved (Not This Player)",   w="Gerald",        r="Gerald is doing incredibly."},
        {a="Most Intimidating Entity",          w="The Chicken",   r="Player specifically terrified."},
        {a="Admin's Biggest Regret (Whitelist)",w=genInsult(),     r="Listed by name in ceremony notes."},
        {a="Dirt Hoarder Of The Year",          w="The Player",    r=math.random(10000,99999).." blocks. Why."},
    }
    local row = 5
    for _,aw in ipairs(awards) do
        if row >= h then break end
        m.setTextColor(colors.cyan)
        tw(2, row, aw.a:sub(1, w-2), 0.01)
        row = row + 1
        if row >= h then break end
        m.setTextColor(colors.yellow)
        put(4, row, "WINNER: " .. aw.w)
        row = row + 1
        if row >= h then break end
        m.setTextColor(colors.lightGray)
        put(4, row, aw.r)
        row = row + 1
        os.sleep(0.8)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: MINECRAFT.NET BLOG POST (about "one specific player")
-- ============================================================
local function phase_blogpost()
    blast(colors.black, colors.white)
    m.setTextColor(colors.lime)
    center(2,"minecraft.net // community blog")
    fillRow(3,"-",colors.lime,colors.black)
    m.setTextColor(colors.white)
    center(4,"A NOTE FROM THE MOJANG TEAM")
    fillRow(5,"-",colors.gray,colors.black)
    local post = {
        "Hi everyone,",
        "",
        "We've been monitoring telemetry data",
        "and have noticed something unusual.",
        "",
        "One specific player account has",
        "triggered our lava-contact alert",
        math.random(50,700) .. " times this month alone.",
        "",
        "Our systems are designed to detect",
        "repeated unusual deaths for welfare",
        "purposes. This account has maxed",
        "out every counter we have.",
        "",
        "We've had to redesign three systems",
        "specifically to accommodate this.",
        "Two engineers have asked to be",
        "reassigned. We understand.",
        "",
        "We won't name the account here.",
        "The player knows who they are.",
        "The lava definitely knows.",
        "Gerald knows.",
        "The chicken has known from the start.",
        "",
        "Please stay safe out there.",
        "Especially near lava.",
        "Please, specifically, stay away",
        "from the lava.",
        "",
        "With concern,",
        "The Mojang Team",
        "",
        "P.S. The bat incident was reviewed.",
        "We have no notes. We're speechless.",
    }
    local row = 6
    for _,line in ipairs(post) do
        if row >= h then break end
        if line == "" then row = row + 1
        else
            m.setTextColor(colors.lightGray)
            tw(2, row, line, 0.014)
            row = row + 1
        end
        os.sleep(0.08)
    end
    os.sleep(5)
end

-- ============================================================
-- PHASE: FAKE INSURANCE CLAIM (new version, different content)
-- ============================================================
local function phase_insurance2()
    blast(colors.black, colors.white)
    center(2,"CLAIM #" .. math.random(10000,99999) .. " - UNDER REVIEW")
    fillRow(3,"=",colors.gray,colors.black)
    local items = {
        {"ITEM CLAIMED",        "REASON GIVEN",       "DECISION"},
        {"Full diamond set",    "Lag",                "DENIED (no lag)"},
        {"Netherite pickaxe",   "Creeper (no creeper)","DENIED (logs)"},
        {math.random(5,64).."x diamond","Fell in lava","DENIED (intentional)"},
        {"Elytra",              "Wind",               "DENIED (there was no wind)"},
        {"64x iron",            "'The server did it'","DENIED (it did not)"},
        {"Trident",             "Threw it into lava", "DENIED (you did that)"},
        {"Horse armour",        "Horse 'ran away'",   "DENIED (you forgot the horse)"},
        {"Shulker box contents","Shulker 'looked mean'","DENIED (not how it works)"},
        {"XP levels (all)",     "Died, lost them",    "DENIED (yes that's how XP works)"},
        {"Base (dirt cube)",    "Griefed (by creeper)","DENIED (you let it in)"},
        {"Dignity",             "Existing on server", "DENIED (pre-existing condition)"},
        {"Gerald's trust",      "Various incidents",  "DENIED (Gerald's decision)"},
    }
    local row = 4
    m.setTextColor(colors.lightGray)
    put(2, row, string.format("%-22s%-22s%s","ITEM","REASON","DECISION"):sub(1,w-2))
    row = row + 1
    fillRow(row,"-",colors.gray,colors.black)
    row = row + 1
    for i = 2,#items do
        if row >= h then break end
        local itm = items[i]
        m.setTextColor(itm[3]:sub(1,6)=="DENIED" and colors.red or colors.lime)
        local line = string.format("%-22s%-22s%s",
            itm[1]:sub(1,21), itm[2]:sub(1,21), itm[3]):sub(1,w-2)
        tw(2, row, line, 0.006)
        row = row + 1
        os.sleep(0.13)
    end
    os.sleep(0.8)
    m.setTextColor(colors.red)
    center(h,"TOTAL APPROVED: 0.  TOTAL DENIED: EVERYTHING.")
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: OVERHEARD IN SPECTATOR MODE
-- ============================================================
local function phase_spectator()
    blast(colors.black, colors.black)
    m.setTextColor(colors.cyan)
    center(2,"OVERHEARD: SPECTATOR MODE")
    m.setTextColor(colors.lightGray)
    center(3,"(other players watching you)")
    fillRow(4,"-",colors.gray,colors.black)
    local convos = {
        "dave: ok so why are they going toward the lava",
        "callum: i have no idea",
        "dave: they can see the lava right",
        "callum: they can definitely see it",
        "dave: its right there",
        "callum: yeah",
        "dave: its so orange",
        "callum: bright orange yeah",
        "dave: oh no",
        "callum: yep",
        "dave: oh no oh no",
        "callum: there it is",
        "dave: i cant watch",
        "callum: i cant stop watching",
        "",
        "admin: (joins spectator mode)",
        "admin: what are we looking at",
        "callum: they're heading back toward the same lava",
        "admin: what",
        "callum: yeah",
        "admin: the same lava as before",
        "callum: yeah",
        "admin: they know thats the same lava",
        "callum: i genuinely dont think they do",
        "admin: (leaves spectator mode)",
        "admin: (cannot process what they saw)",
        "",
        "dave: is that a chicken following them",
        "callum: thats THE chicken",
        "dave: oh god",
        "callum: yeah",
        "dave: does the chicken know",
        "callum: the chicken always knows",
        "dave: should we warn them about the chicken",
        "callum: theyre in the lava again",
        "dave: ok the chicken can wait",
        "",
        "everyone: F",
        "gerald: (oinks with dignity)",
    }
    local row = 5
    for _,line in ipairs(convos) do
        if row >= h then break end
        if line == "" then row = row + 1
        else
            local who = line:match("^(%w+):")
            m.setTextColor(
                who == "admin"   and colors.red   or
                who == "gerald"  and colors.lime  or
                who == "everyone"and colors.yellow or
                who == "callum"  and colors.cyan  or
                colors.white
            )
            tw(2, row, line, 0.013)
            row = row + 1
        end
        os.sleep(0.18)
    end
    os.sleep(4.5)
end

-- ============================================================
-- PHASE: FIVE-STAR REVIEW OF DYING (by the mobs)
-- ============================================================
local function phase_mobreviews()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(2,"MOB REVIEW: THIS PLAYER")
    m.setTextColor(colors.yellow)
    center(3,"Ratings by those who've encountered them")
    fillRow(4,"-",colors.gray,colors.black)
    local reviews = {
        {mob="Skeleton",       stars="5*", r="Stands completely still. Never blocks."},
        {mob="Creeper",        stars="5*", r="Walks TOWARD the hissing. Incredible."},
        {mob="The Warden",     stars="5*", r="Loudest footsteps I have ever heard."},
        {mob="Zombie",         stars="5*", r="Full iron armour. Didn't use it once."},
        {mob="Phantom",        stars="5*", r="Hasn't slept. Ever. Dream client."},
        {mob="The Lava",       stars="5*", r="Visits constantly. Loyal. Appreciated."},
        {mob="Pillager",       stars="5*", r="Easy loot. Efficient. Good value."},
        {mob="Ghast",          stars="5*", r="Stood still while I fired. Polite."},
        {mob="The Void",       stars="5*", r="Gold member loyalty programme. VIP."},
        {mob="Bat",            stars="5*", r="They punched me first. I won. Wow."},
        {mob="A Cactus",       stars="5*", r="They walked into me. I didn't move."},
        {mob="The Chicken",    stars="N/A",r="Not giving a rating. You know why."},
        {mob="Gerald the Pig", stars="1*", r="Player is my owner. Embarrassing."},
        {mob="Enderman",       stars="3*", r="Made eye contact AGAIN. Consistent."},
        {mob="Gravel",         stars="5*", r="Trusted me above all others. Touching."},
    }
    local row = 5
    for _,rv in ipairs(reviews) do
        if row >= h then break end
        local positive = rv.stars == "5*"
        m.setTextColor(colors.cyan)
        local nm = (rv.mob .. ":"):sub(1,14)
        put(2, row, nm)
        m.setTextColor(positive and colors.lime or
                       rv.stars=="N/A" and colors.orange or colors.yellow)
        put(2+#nm, row, rv.stars .. " ")
        m.setTextColor(colors.white)
        put(2+#nm+4, row, rv.r)
        row = row + 1
        os.sleep(0.2)
    end
    os.sleep(4.5)
end


-- ============================================================
-- PHASE RUNNER
-- ============================================================
local phases = {
    -- Core phases
    phase_bsod,        phase_dox,         phase_virusscan,   phase_history,
    phase_discord,     phase_achievements, phase_roast,       phase_taskmanager,
    phase_progress,    phase_conspiracy,  phase_scoreboard,  phase_matrix,
    phase_rip,         phase_dvd,         phase_warden,
    phase_seizure,     phase_eulogy,      phase_loading,     phase_livechat,
    phase_speedrun,    phase_support,     phase_reboot,      phase_twitchchat,
    phase_reddit,      phase_patchnotes,  phase_psych,       phase_yelp,
    phase_horoscope,   phase_will,        phase_tos,         phase_job,
    phase_stars,       phase_email,       phase_google,      phase_fortune,
    phase_police,      phase_therapy,     phase_auction,     phase_dating,
    phase_warranty,    phase_fuckups,     phase_swearjar,    phase_insurance,
    phase_angrymail,   phase_linkedin,    phase_tripadvisor, phase_glassdoor,
    phase_obituary,    phase_amazon,      phase_craigslist,  phase_helpdesk,
    phase_documentary, phase_reportcard,  phase_voicemail,   phase_interview,
    phase_census,      phase_cookingshow, phase_powerpoint,  phase_courtroom,
    phase_declined,    phase_manual,      phase_confessional,phase_tips,
    phase_finalboss,
    -- New phases
    phase_groupchat,   phase_gameshow,    phase_intervention,phase_autopsy,
    phase_complaints,  phase_mvpe,        phase_blogpost,    phase_insurance2,
    phase_spectator,   phase_mobreviews,
    -- Ticker segments (7 short themed news flashes)
    phase_ticker_deaths, phase_ticker_gerald, phase_ticker_admin,
    phase_ticker_lava,   phase_ticker_dirt,   phase_ticker_sports,
    phase_ticker_weird,
}

local function visualLoop()
    while true do
        -- Fisher-Yates shuffle
        for i = #phases, 2, -1 do
            local j = math.random(1, i)
            phases[i], phases[j] = phases[j], phases[i]
        end
        for _, phase in ipairs(phases) do
            local ok, err = pcall(phase)
            if not ok then
                blast(colors.red, colors.white)
                center(math.floor(h/2), "ERR: " .. tostring(err))
                os.sleep(2)
            end
        end
    end
end

-- ============================================================
-- BOOT SEQUENCE
-- ============================================================
blast(colors.black, colors.red)
local mid = math.floor(h / 2)
center(math.max(1, mid - 2), "XYNIA BRAINROT ENGINE v8.0")
center(math.max(1, mid),     "INITIALIZING DAMAGE...")
center(math.max(1, mid + 2), "82 PHASES. NO SURVIVORS. NO CHILL.")
os.sleep(3.5)

parallel.waitForAny(visualLoop, audioLoop)
