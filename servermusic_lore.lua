-- ============================================================
-- BUNGUS BOIS WEAPONIZED BRAINROT ENGINE  v8.0
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
        os.sleep(speed or 0.09)
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


-- ── SCROLLING CHAT BUFFER ────────────────────────────────────────────
-- For chat-log / dialogue phases.
-- chatReset(r1,r2): set the display area and clear the buffer.
-- chatPush(text, fg): add a line; scroll up when full; redraw all.
local _cBuf, _cR1, _cR2 = {}, 3, h

local function chatReset(r1, r2)
    _cBuf = {}
    _cR1  = r1 or 3
    _cR2  = r2 or h
    -- blank the area
    for row = _cR1, _cR2 do
        if row <= h then
            m.setCursorPos(1, row)
            m.write(string.rep(" ", w))
        end
    end
end

local function chatPush(text, fg)
    text = text:sub(1, w - 2)
    local maxLines = _cR2 - _cR1 + 1
    _cBuf[#_cBuf + 1] = {t = text, fg = fg or colors.white}
    if #_cBuf > maxLines then table.remove(_cBuf, 1) end
    for i = 1, maxLines do
        local row = _cR1 + i - 1
        if row > h then break end
        m.setCursorPos(1, row)
        m.write(string.rep(" ", w))
        local e = _cBuf[i]
        if e then
            m.setTextColor(e.fg)
            m.setCursorPos(2, row)
            m.write(e.t)
        end
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
    -- mk4modz-specific ATM10 modpack searches
    "atm10 how to start Apotheosis for dummies",
    "atm10 mekanism reactor setup basic guide please",
    "atm10 what is rf and why does everything need it",
    "atm10 i dont understand any of this help",
    "atm10 how do i make things without asking DrDarkMario",
    "can i just ask DrDarkMario instead of learning",
    "atm10 jetpack how to not die with it immediately",
    "how to not fall off stuff with jetpack atm10",
    "atm10 fall damage with creative flight still exists??",
    "why do i keep falling off my own base atm10",
    "atm10 i fell again this is not my fault",
    "nuclear reactor meltdown how to prevent too late",
    "iworkatjaguar reactor explosion how to survive",
    "radiation poisoning minecraft atm10 symptoms",
    "is the server supposed to be this irradiated",
    "how to tell SP00D3R i died to fall damage again",
    "SP00D3R is better than me at everything is that normal",
    "why is my younger brother so much cooler than me",
    "SubaRubicon what mods does he know (answer: none)",
    "how to explain to girlfriend that boyfriend knows no mods",
    "ItsBasicallyBri how to cope with SubaRubicon",
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
    -- server-specific conspiracies
    "iworkatjaguar's reactor explosion was not an accident.",
    "The radiation is why your fall damage is so high.",
    "SP00D3R was always going to be cooler. You had no chance.",
    "SubaRubicon has never read a single mod wiki page. Not one.",
    "DrDarkMario is running a paid tutoring service for SubaRubicon.",
    "SubaRubicon owes DrDarkMario an enormous favour by now.",
    "ItsBasicallyBri knows more about ATM10 than SubaRubicon.",
    "The chicken and Gerald are the most competent on the server.",
    "SP00D3R has never once died to fall damage. Unlike you.",
    "iworkatjaguar knew the reactor would melt down. He did it anyway.",
    "The entire server map is mildly radioactive because of iworkatjaguar.",
    "The nuclear fallout is why the mobs are stronger near your base.",
    "SubaRubicon blamed you for the reactor. iworkatjaguar believed him.",
    "SP00D3R took one look at the reactor and knew it would explode.",
    "SP00D3R said nothing because he wanted to see what would happen.",
    "The radiation has made Gerald smarter. Gerald now surpasses you.",

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
    -- server-specific
    {n="Nuclear Winter",             d="iworkatjaguar's reactor. Not your fault. Somehow."},
    {n="Blast Radius",               d="You were in range. Of course you were."},
    {n="Chernobyl Who?",             d="iworkatjaguar made that look like a rehearsal."},
    {n="Fall Guy",                   d="Died to fall damage. Again. With a jetpack equipped."},
    {n="Freefall",                   d="Fell off own base. With creative flight on. Somehow."},
    {n="Brother of the Year",        d="SP00D3R watched. SP00D3R said nothing. SP00D3R filmed."},
    {n="Cool Brother",               d="Watched SP00D3R do something effortlessly. Tried it. Died."},
    {n="Just Ask DrDarkMario",       d="Couldn't figure out the mod. Again."},
    {n="SubaRubicon Energy",         d="Attempted to learn a mod. Asked someone instead."},
    {n="The Rubicon Method",         d="Passed 3 wiki pages. DM'd DrDarkMario anyway."},
    {n="IRL Consequences",           d="Sub, Bri and jaguar live together. They saw this."},
    {n="Gerald > You",               d="Your own pig has better stats. You know this."},
    {n="The Chicken Remembers",      d="Made eye contact again. The chicken remembers everything."},
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

    -- ── CONFIG ──────────────────────────────────────────────────────
    local SERVER  = "https://1a9d2d9e2f2ab5.lhr.life"
    local VOLUME  = 3.0   -- Max radius, zero distortion.
    local CHUNK   = 16 * 1024

    -- ── HELPERS ─────────────────────────────────────────────────────
    local function checkServer()
        local ok, err = http.get(SERVER.."/status")
        if ok then ok.close(); return true end
        print("[music] Server unreachable: "..tostring(err))
        print("[music] URL tried: "..SERVER.."/status")
        print("[music] Fix: is the localhost.run tunnel active?")
        print("[music] Fix: is music_server.py running?")
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

            -- Do NOT wait for the buffer to empty. 
            -- Just yield 2 ticks so it drains slightly, then top it back up.
            while not speakers[1].playAudio(pcm, VOLUME) do
                os.sleep(0.1) 
            end
        end

        res.close()
        speakers[1].stop()
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
    os.sleep(1.50)
    center(math.max(1, mid - 2), "PC encountered YOU and gave up.")
    center(math.max(1, mid - 1), "All of this is your fault.")
    os.sleep(1.50)
    for pct = 0, 100, math.random(2, 5) do
        center(math.max(1, mid + 1), pct .. "% cataloguing your mistakes  ")
        os.sleep(0.30)
    end
    center(math.max(1, mid + 1), "100% done. Embarrassing.")
    os.sleep(1.50)
    m.setTextColor(colors.lightGray)
    center(math.max(1, mid + 3), "Stop code: " .. rnd(fake_errors))
    center(math.max(1, mid + 4), "Process: " .. rnd(fake_processes))
    center(math.max(1, mid + 5), "Remedy: Ask SP00D3R. He will know.")
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: FAKE DOX
-- ============================================================
local function phase_dox()
    blast(colors.black, colors.green)
    tw(2, 2, "[BUNGUS BOIS NET INTRUSION v6.66]", 0.022)
    os.sleep(1.50)
    tw(2, 4, "FETCHING mk4modz DATA...", 0.025)
    os.sleep(1.50)
    local rows = {
        "IPv4: 192.168." .. math.random(0,5) .. "." .. math.random(2,254),
        "IPv6: fe80::dead:beef:" .. math.random(1000,9999) .. ":cafe",
        "MAC: 00:1A:2B:3C:4D:" .. math.random(10,99),
        "PC: mk4modz-GAMING-RIG-" .. math.random(1000,9999),
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
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    r = r + 1
    local uploads = {
        "POSTING TO #public-announcements...",
        "SELLING TO " .. math.random(3,8) .. " FACTIONS...",
        "SUBMITTING TO r/minecraftfails...",
        "EMAILING iworkatjaguar WITH HIGHLIGHTS...",
        "ARCHIVING ON WAYBACK MACHINE...",
    }
    for _, u in ipairs(uploads) do
        if r >= h then break end
        tw(2, r, (">> " .. u), 0.028)
        r = r + 1
        os.sleep(1.50)
    end
    m.setTextColor(colors.yellow)
    if r <= h then tw(2, r, ">> DONE. CONSEQUENCES INCOMING. COPE.", 0.03) end
    os.sleep(15.0)
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
        os.sleep(1.50)
    end
    os.sleep(14.5)
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
    chatReset(4, h)
    for _, dm in ipairs(shuf) do
        chatPush("mk4modz: " .. dm, colors.white)
        local hr = math.random(1, 12)
        local mn = string.format("%02d", math.random(0, 59))
        local ap = math.random(0,1) == 0 and "AM" or "PM"
        chatPush("  "..hr..":"..mn.." "..ap.." - Left on read", colors.lightGray)
        os.sleep(1.50)
    end
    os.sleep(14.5)
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
        os.sleep(1.50)
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
    os.sleep(1.50)
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
        os.sleep(1.50)
        blast(colors.black, colors.white)
        os.sleep(0.30)
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
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: VIRUS SCAN
-- ============================================================
local function phase_virusscan()
    blast(colors.black, colors.green)
    tw(2, 2, "BUNGUS BOIS THREAT SCANNER v9.0", 0.022)
    os.sleep(1.50)
    tw(2, 4, ("Target: C:\\Users\\" .. rnd(adj) .. "_GAMER"), 0.018)
    os.sleep(1.50)
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
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    center(h, "QUARANTINE FAILED. SKILL ISSUE TOO DEEP.")
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: PROGRESS BARS OF SHAME
-- ============================================================
local function phase_progress()
    blast(colors.black, colors.white)
    center(2, "DIAGNOSTICS: YOU (God Help Us)")
    os.sleep(1.50)
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
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    center(h, "DIAGNOSIS: TERMINAL. NO CURE EXISTS.")
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(14.5)
end

-- ============================================================
-- PHASE: ACHIEVEMENTS
-- ============================================================
local function phase_achievements()
    blast(colors.black, colors.white)
    center(2, "ACHIEVEMENT UNLOCKED (somehow)")
    os.sleep(1.50)
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
        os.sleep(1.50)
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
        "mk4modz DIES AGAIN - CLAIMS LAG - iworkatjaguar SHOWS LOGS",
        "mk4modz SETS PERSONAL BEST: " .. math.random(8,30) .. " DEATHS IN ONE HOUR",
        "mk4modz DEATH #" .. math.random(300,999) .. " - iworkatjaguar HAS STOPPED COUNTING",
        "mk4modz DIES TO FALL DAMAGE AGAIN - SP00D3R FILMED IT - AGAIN",
        "mk4modz DIES TO FALL DAMAGE WITH JETPACK EQUIPPED - " .. math.random(4,20) .. "TH TIME",
        "mk4modz FALLS OFF BASE BEFORE SP00D3R FINISHES TYPING CAREFUL",
        "PHANTOM ATTACK SURVIVOR 'I WAS GONNA SLEEP' (0 SLEEPS THIS WEEK)",
        "mk4modz KILLED BY FALL DAMAGE ON FLAT GROUND - PHYSICS SILENT",
        "mk4modz KILLED BY OWN CHICKEN - GERALD WATCHES IMPASSIVELY",
        "mk4modz FALLS INTO OWN BASE - FROM INSIDE - HOW",
        "FALL DAMAGE CLAIMS mk4modz WHO WAS 'JUST STANDING' - NOT EVEN AT CLIFF",
        "mk4modz DROWNED IN PUDDLE - SP00D3R: 'I CANNOT EXPLAIN THIS'",
        "mk4modz DIES TO OWN TNT - CLAIMS iworkatjaguar'S RADIATION CAUSED IT",
        "mk4modz KILLED BY OWN CHICKEN - HIS OWN CHICKEN - GERALD DECLINES COMMENT",
        "RESPAWN SCREEN: mk4modz'S MOST VISITED LOCATION - iworkatjaguar CONFIRMS",
        "mk4modz RUNS TOWARD REACTOR EXPLOSION - iworkatjaguar: TOLD HIM NOT TO",
        "SCIENTIST CONFIRMS: mk4modz GETTING WORSE - SP00D3R GETTING BETTER SOMEHOW",
        "mk4modz NETHERITE LOST TO FALL DAMAGE - NOT EVEN LAVA THIS TIME - HOW",
        "mk4modz DIES TO FALL DAMAGE WHILE STANDING AT CRAFTING TABLE - PHYSICS BAFFLED",
    })
end

-- SEGMENT 2: THE GERALD / CHICKEN SITUATION
local function phase_ticker_gerald()
    runTicker("GERALD & CHICKEN BUREAU", {
        "GERALD THE PIG OUTRANKS mk4modz ON ALL METRICS - SP00D3R CONFIRMS",
        "GERALD APPLIES FOR mk4modz'S WHITELIST SPOT - iworkatjaguar CONSIDERING",
        "GERALD APPROVED - iworkatjaguar CITES 'BETTER THAN mk4modz AT EVERYTHING'",
        "mk4modz'S OWN CHICKEN DEFEATS HIM IN 1V1 - CHICKEN DENIES REMATCH",
        "CHICKEN AND GERALD FORMALISE ALLIANCE - mk4modz NOT INVITED - SP00D3R IS HONORARY MEMBER",
        "ALLIANCE DIRECTS ALL RESOURCES TOWARD mk4modz - SubaRubicon ASKS WHAT RESOURCES ARE",
        "GERALD HAS MORE DIAMONDS THAN mk4modz - AND MORE THAN SubaRubicon - NOT CLOSE",
        "mk4modz'S CHICKEN FILES GRIEVANCE WITH iworkatjaguar - 93 PAGES - ABOUT mk4modz",
        "iworkatjaguar READS CHICKEN DOCUMENT - AGREES WITH ALL OF IT",
        "mk4modz SPOTS HIS OWN CHICKEN - RETREATS - SP00D3R WATCHES - SAYS NOTHING",
        "CHICKEN STANDOFF ENTERS WEEK " .. math.random(2,8) .. " - NO END IN SIGHT",
        "CHICKEN DEMANDS WHEAT - PLAYER OFFERS DIRT - CHICKEN OFFENDED",
        "GERALD OFFERED mk4modz'S ACCOUNT - GERALD DECLINES - HAS STANDARDS UNLIKE mk4modz",
        "PLAYER NAMES HOG 'GERALD 2' - ORIGINAL GERALD ISSUES STATEMENT",
        "GERALD'S STATEMENT: 'I HAVE CONCERNS' - PUBLISHED IN FULL",
        "CHICKEN SEEN MEASURING PLAYER'S DIRT CUBE - INTENTIONS UNCLEAR",
        "GERALD HOSTS MEETING - mk4modz NOT INVITED - SubaRubicon ATTENDS - CONFUSED",
        "ANNUAL GERALD DAY ANNOUNCED - SP00D3R CO-HOSTS - mk4modz NOT MENTIONED",
        "mk4modz'S CHICKEN WINS SERVER MVP - mk4modz FINISHES LAST - SubaRubicon SECOND LAST",
        "mk4modz VOTED 'LEAST LIKELY TO IMPROVE' - SubaRubicon 'MOST LIKELY TO ASK DrDarkMario'",
    })
end

-- SEGMENT 3: ADMIN DESK / LOGS / APPEALS
local function phase_ticker_admin()
    runTicker("ADMIN DESK - BREAKING", {
        "mk4modz UNBAN APPEAL #" .. math.random(8,55) .. " DENIED - iworkatjaguar QUOTES 'JUST STOP DYING'",
        "LOGS: ZERO LAG IN mk4modz'S " .. math.random(300,900) .. " DEATHS - iworkatjaguar HAS CHECKED",
        "iworkatjaguar OPENS SCREENSHOT FOLDER - FOLDER: mk4modz_COMPILATION_VOL" .. math.random(3,12),
        "FOLDER SIZE: " .. math.random(4,47) .. "GB - iworkatjaguar: 'AND GROWING'",
        "mk4modz IP FLAGGED 'CHRONICALLY MISGUIDED' - SubaRubicon IP FLAGGED 'PERPETUALLY LOST'",
        "iworkatjaguar INSTALLS PLUGIN TO TRACK mk4modz DEATHS - SubaRubicon ASKS WHAT A PLUGIN IS",
        "PLUGIN CRASHES UNDER LOAD - DEATH COUNT TOO HIGH FOR 32-BIT INTEGER",
        "iworkatjaguar UPGRADES DEATH COUNTER TO 64-BIT INTEGER - mk4modz FILLED THE 32-BIT ONE",
        "GRIEF LOG: " .. math.random(80,300) .. "% mk4modz - REST IS SubaRubicon RELATED QUESTIONS",
        "mk4modz COMPLAINS ABOUT GRIEF LOG - iworkatjaguar ADDS COMPLAINT TO GRIEF LOG",
        "UNBAN APPEAL CITES 'LAG' AS CAUSE - ADMIN PASTES LOG SHOWING NO LAG",
        "PLAYER CLAIMS LOG IS DOCTORED - ADMIN SENDS ORIGINAL - PLAYER OFFLINE",
        "iworkatjaguar CREATES #mk4modz-fell-again CHANNEL - 200 MSGS DAY ONE - ALL FROM SP00D3R",
        "SERVER RULES: RULE 14 ADDED - THE REACTOR RULE - iworkatjaguar NAMED IN OWN RULE",
        "RULE 14 TEXT: DO NOT BUILD A FISSION REACTOR NEAR SPAWN - iworkatjaguar: TOO LATE",
        "SUPPORT TICKETS UP " .. math.random(200,800) .. "% - mk4modz (DEATHS) AND SubaRubicon (QUESTIONS)",
        "mk4modz'S APPEAL FORM AUTO-FILLS 'FALL DAMAGE' - iworkatjaguar SET THIS UP MANUALLY",
        "iworkatjaguar BETS ON mk4modz DEATH CAUSE - SP00D3R ALWAYS GUESSES RIGHT - ALWAYS",
    })
end

-- SEGMENT 4: LAVA / VOID / NETHER INCIDENTS
local function phase_ticker_lava()
    runTicker("LAVA & VOID CORRESPONDENT", {
        "mk4modz " .. math.random(5,64) .. " DIAMONDS LOST TO FALL DAMAGE - NOT EVEN LAVA THIS TIME",
        "SAME LAVA FINDS PLAYER FOR " .. math.random(4,12) .. "TH TIME - SCIENTISTS CANNOT EXPLAIN",
        "LAVA RELEASES STATEMENT: 'mk4modz KEEPS COMING TO US. WE SIMPLY ACCEPT.'",
        "VOID SENDS PLAYER FORMAL WRITTEN NOTICE: 'SEE YOU SOON'",
        "PLAYER RESPONDS TO VOID: 'NOT TODAY' - VOID: 'IT IS TODAY'",
        "VOID CONFIRMED CORRECT - PLAYER CONFIRMED IN VOID",
        "NETHER PORTAL GRANTED REASSIGNMENT AWAY FROM PLAYER'S COORDS",
        "PORTAL CITES iworkatjaguar'S REACTOR AS HOSTILE ENVIRONMENT - REQUEST APPROVED",
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
        "mk4modz HAS " .. math.random(10000,99999) .. " DIRT - SubaRubicon HAS " .. math.random(100,500) .. " QUESTIONS - NO ANSWERS",
        "SERVER ECONOMY DESTABILISED - TOO MUCH DIRT IN CIRCULATION - ONE SOURCE",
        "mk4modz DIRT CUBE GRIEFED AGAIN - mk4modz REBUILDING - SP00D3R: 'SAME DESIGN' - 'YES'",
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
        "mk4modz DESCRIBES BASE AS 'RUSTIC' - iworkatjaguar DESCRIBES IT AS 'A VIOLATION OF MY EYES'",
        "VILLAGE ISSUES RESTRAINING ORDER - PLAYER MUST STAY 50 BLOCKS AWAY",
        "SubaRubicon ASKS WHAT A STRONGHOLD IS - DAY " .. math.random(3,21) .. " - DrDarkMario TIRED",
        "PLAYER STILL WALKING IN WRONG DIRECTION - CONFIDENT ABOUT IT",
        "IRON GOLEM RETIRES EARLY - CITES 'MORAL INJURY' - PLAYER NAMED IN STATEMENT",
    })
end

-- SEGMENT 6: SPORTS DESK (play-by-play style)
local function phase_ticker_sports()
    runTicker("SMP SPORTS DESK", {
        "mk4modz LOSES 1V1 TO OWN CHICKEN - SP00D3R WINS 1V1 AGAINST THREE SKELETONS SIMULTANEOUSLY",
        "mk4modz SEASON STATS: " .. math.random(300,999) .. " FALL DEATHS / 0 WINS / 1 JETPACK ACCIDENT",
        "KILL/DEATH RATIO DROPS TO 0.00" .. math.random(1,9) .. " - NEW PERSONAL WORST",
        "PLAYER FINISHES LAST IN EVERY SERVER CATEGORY - PODIUM SWEEP",
        "COMMENTATOR FALLS SILENT WATCHING PLAYER'S LAST RUN - 47 SECONDS",
        "REPLAY SHOWS PLAYER SAW THE LAVA - WALKED IN ANYWAY - ANALYSTS BAFFLED",
        "HALF-TIME STATS: " .. math.random(5,25) .. " DEATHS - " .. math.random(0,1) .. " KILLS - 1 HOE (ACCIDENTAL)",
        "POST-MATCH: mk4modz BLAMES iworkatjaguar'S RADIATION - iworkatjaguar SHOWS LOGS - NO RADIATION",
        "PLAYER DISQUALIFIED FROM OWN SPEEDRUN FOR DYING TOO MUCH",
        "DEATH MONTAGE SUBMITTED TO SERVER HALL OF SHAME - ACCEPTED IMMEDIATELY",
        "RIVAL FACTIONS STOP FIGHTING EACH OTHER TO WATCH PLAYER DIE",
        "TRUCE HOLDS FOR " .. math.random(10,60) .. " MINUTES - EVERYONE WATCHING SAME PLAYER",
        "PLAYER RANKED LAST ON EVERY LEADERBOARD INCLUDING ONES THEY AREN'T ON",
        "DRAFT PICK VALUE: NEGATIVE - TEAMS PAYING TO NOT HAVE PLAYER",
        "MVP: SP00D3R (unanimous) - Gerald (unanimous) - mk4modz: 0 votes - SubaRubicon: 0 questions answered",
        "mk4modz'S CHICKEN RECEIVES HONOURABLE MENTION - mk4modz NOT MENTIONED - SubaRubicon ALSO NOT MENTIONED",
        "SEASON FINALE: PLAYER VS THE LAVA - LAVA WINS - AS ALWAYS - FINAL SCORE " .. math.random(300,999) .. "-0",
    })
end

-- SEGMENT 7: WEIRD SCIENCE / LATE BREAKING
local function phase_ticker_weird()
    runTicker("LATE BREAKING // WEIRD SCIENCE", {
        "SCIENTISTS: mk4modz GETTING WORSE - SP00D3R GETTING BETTER - BROTHERS. SAME HOUSEHOLD. HOW.",
        "PEER-REVIEWED STUDY: PLAYER'S DECISION-MAKING 'STATISTICALLY IMPLAUSIBLE'",
        "RESEARCHERS: mk4modz'S FALL DAMAGE RATE IMPOSSIBLE TO REPRODUCE IN LAB - NOT FOR LACK OF TRYING",
        "UNIVERSITY NAMES AWARD AFTER PLAYER - GIVEN ANNUALLY FOR WORST GAMEPLAY",
        "STUDY FINDS PLAYER'S CRAFTING HISTORY 'MEDICALLY INTERESTING'",
        "GEOLOGISTS DATE PLAYER'S GRUDGE AGAINST LAVA TO APPROX. " .. math.random(6,48) .. " MONTHS",
        "THERMODYNAMICS PROFESSOR REVIEWS PLAYER'S LAVA INTERACTIONS - RETIRES",
        "PHILOSOPHER: PAPER ON mk4modz'S FALLS TITLED 'GRAVITY: A RECURRING SURPRISE FOR ONE MAN'",
        "PAPER TITLED: 'HOPE, EVIDENCE, AND THE COMPLETE ABSENCE OF LEARNING'",
        "PSYCHOLOGIST DOCUMENTS PLAYER'S RELATIONSHIP WITH DENIAL - 400 PAGES",
        "400 PAGES NOT ENOUGH - SEQUEL ANNOUNCED - PLAYER STILL PLAYING",
        "BREAKING: PLAYER STILL IN THE CAVE FROM LAST WEEK",
        "UPDATE: PLAYER FOUND A WAY OUT - WALKED INTO LAVA ON WAY OUT",
        "CONSPIRACY THEORISTS SUGGEST LAVA IS SENTIENT AND TARGETING PLAYER",
        "LAVA DECLINES TO CONFIRM OR DENY - DOES NOT NEED TO",
        "MOJANG: BAFFLED BY mk4modz - SubaRubicon: 'WHAT IS MOJANG' - DrDarkMario: *sighs*",
        "NEW WAY FOUND TODAY: TECHNICALLY UNDOCUMENTED - PATCH INCOMING",
        "iworkatjaguar'S REACTOR PURCHASES BILLBOARD NEAR mk4modz'S BASE: 'SEE YOU SOON'",
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
    os.sleep(1.50)
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
        "SP00D3R sends thoughts and prayers.",
        "SP00D3R also filmed it.",
        "iworkatjaguar says this is why we have logs.",
        "Gerald sends his warmest regards.",
        "The chicken sends nothing.",
        "The chicken owes mk4modz nothing.",
        "SubaRubicon asked DrDarkMario what an eulogy is.",
        "ItsBasicallyBri explained it.",
        "SubaRubicon then asked what an inventory is.",
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: WARDEN WARNING
-- ============================================================
local function phase_warden()
    blast(colors.black, colors.red)
    center(2, "WARDEN PROXIMITY ALERT")
    os.sleep(1.50)
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
        if 2 + i <= h then center(2 + i, line); os.sleep(1.50) end
    end
    os.sleep(1.50)
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
            os.sleep(1.50)
        end
    end
    os.sleep(15.5)
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
        "Informing chicken of mk4modz location",
        "Alerting SP00D3R to prepare to film",
        "Notifying iworkatjaguar logs are filling up",
        "Queuing SubaRubicon's questions for DrDarkMario",
        "Checking iworkatjaguar reactor stability (unstable)",
    }
    local row = 4
    for _, task in ipairs(tasks) do
        if row >= h - 1 then break end
        m.setTextColor(colors.lightGray)
        tw(2, row, (task .. "..."), 0.015)
        m.setTextColor(colors.red)
        if w - 5 >= 1 then put(math.max(1, w - 5), row, " FAIL") end
        row = row + 1
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    center(h, "ABORTED. SKILL PREREQUISITES NOT MET.")
    os.sleep(15.0)
end

-- ============================================================
-- PHASE: LIVE SERVER CHAT
-- ============================================================
local function phase_livechat()
    blast(colors.black, colors.white)
    center(1, "[ SERVER CHAT - UNCENSORED ]")
    fillRow(2, "-", colors.gray, colors.black)
    local names = {
        "SP00D3R","iworkatjaguar","DrDarkMario",
        "SubaRubicon","ItsBasicallyBri","GeraldThePig",
    }
    local msgs = {
        "mk4modz fell off the base again lmao",
        "how. there is a FENCE.",
        "SP00D3R did you know your brother did this",
        "SP00D3R: yes. I watched. I said nothing.",
        "SP00D3R that is genuinely evil",
        "SP00D3R: I know. I filmed it.",
        "mk4modz fell in lava AND took fall damage somehow",
        "iworkatjaguar can we ban fall damage it keeps getting mk4modz",
        "iworkatjaguar: the server is also radioactive so",
        "iworkatjaguar: pick your battles",
        "wait why is the server radioactive",
        "iworkatjaguar: the reactor had a small event",
        "SubaRubicon: what reactor",
        "DrDarkMario: SubaRubicon please just read ONE wiki page",
        "SubaRubicon: I prefer asking you",
        "DrDarkMario: I know. That is the problem.",
        "ItsBasicallyBri: babe you really should learn the mods",
        "SubaRubicon: DrDarkMario explain it to me",
        "DrDarkMario has left the server",
        "mk4modz named his pig Gerald",
        "mk4modz cannot eat pork now Gerald is family",
        "SP00D3R: Gerald is better at ATM10 than mk4modz",
        "SP00D3R: Gerald understands Apotheosis",
        "SP00D3R: mk4modz does not",
        "ItsBasicallyBri: that is unfair to mk4modz",
        "ItsBasicallyBri: ...actually fair tbh",
        "mk4modz died to fall damage with creative flight on",
        "HOW. HOW DID THAT HAPPEN.",
        "SP00D3R: I have a theory.",
        "SP00D3R: mk4modz finds a way.",
        "SP00D3R: he always finds a way.",
        "iworkatjaguar: death log has a dedicated mk4modz section",
        "iworkatjaguar: it is the largest section",
        "iworkatjaguar: SubaRubicon has his own section too",
        "SubaRubicon: for what",
        "iworkatjaguar: questions. so many questions.",
        "SubaRubicon: I just like asking DrDarkMario",
        "DrDarkMario has rejoined the server",
        "DrDarkMario: I saw that SubaRubicon",
        "DrDarkMario: I saw all of it",
        "mk4modz: the chicken is looking at me again",
        "SP00D3R: mk4modz do not make eye contact",
        "mk4modz: too late",
        "SP00D3R: mk4modz...",
        "mk4modz: she knows SP00D3R she always knows",
        "this server is something else honestly",
        "SP00D3R is holding everything together",
        "SP00D3R: I am doing my best",
        "we love SP00D3R",
        "SP00D3R is the favourite and we all know it",
    }
    chatReset(3, h)
    for _, msg in ipairs(msgs) do
        local name = rnd(names)
        local col  = rnd(colors_list)
        chatPush(("<"..name.."> "):sub(1,12)..msg, col)
        os.sleep(1.50)
    end
    os.sleep(15.0)
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
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    center(h, "FINAL TIME: DNF. CAUSE: EXISTING.")
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: SUPPORT TICKET
-- ============================================================
local function phase_support()
    blast(colors.black, colors.white)
    center(2, "TICKET #" .. math.random(10000, 99999) .. " - mk4modz'S 11TH")
    fillRow(3, "=", colors.gray, colors.black)
    local ticket = {
        "To: iworkatjaguar / SP00D3R / Anyone",
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
        "   iworkatjaguar is considering it.",
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
        os.sleep(0.30)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    center(h, "CLOSED. iworkatjaguar: 'LEARN TO NOT FALL.'")
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: REBOOT
-- ============================================================
local function phase_reboot()
    blast(colors.black, colors.red)
    local mid = math.floor(h / 2)
    center(math.max(1, mid - 2), "MEMORY LEAK: COPE.EXE")
    center(math.max(1, mid), "REBOOTING CONFIDENCE...")
    center(math.max(1, mid + 2), "ETA: WHEN SP00D3R GETS TIRED OF WATCHING")
    os.sleep(14.5)
    blast(colors.black, colors.white)
    for i = 5, 0, -1 do
        m.clear()
        center(math.max(1, mid - 1), "REBOOT IN " .. i .. "...")
        center(math.max(1, mid + 1), "SP00D3R is still cooler: " .. tostring(i) .. " sec left")
        os.sleep(1.50)
    end
end

-- ============================================================
-- PHASE: TWITCH CHAT SIMULATOR
-- ============================================================
local function phase_twitchchat()
    blast(colors.black, colors.purple)
    center(1, "BUNGUS BOIS SMP LIVE - 847 VIEWERS")
    fillRow(2, "-", colors.gray, colors.black)
    local chatters = {
        "SP00D3R_clips","iworkatjaguar_admin","DrDarkMario_live",
        "SubaRubicon_irl","ItsBasicallyBri","GeraldThePig_official",
        "the_chicken_account","reactor_watcher_420","atm10_enjoyer",
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
    chatReset(3, h)
    for i = 1, 70 do
        local name = rnd(chatters)
        local col  = rnd(colors_list)
        chatPush((name..": "):sub(1,14)..rnd(chatmsgs), col)
        os.sleep(1.50)
    end
    os.sleep(15.0)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        {"SP00D3R",        "1* - Bro. I am begging you."},
        {"iworkatjaguar",  "1* - Condemned. Still there. Still dirt."},
        {"WardenFan2026",   "1* - No windows. No door. 4 dirt."},
        {"GrindMode",       "1* - Called it a base. Its a cube."},
        {"DrDarkMario",    "1* - I have concerns and no energy left."},
        {"NightOwl",        "2* - At least it has a chest."},
        {"SubaRubicon",    "2* - I asked DrDarkMario what to give it."},
        {"ItsBasicallyBri","1* - SubaRubicon helped. One wall. Dirt."},
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: LAST WILL AND TESTAMENT
-- ============================================================
local function phase_will()
    blast(colors.black, colors.white)
    m.setTextColor(colors.lightGray)
    center(2, "LAST WILL AND TESTAMENT")
    center(3, "of mk4modz (" .. clip(genInsult()) .. ")")
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
        os.sleep(1.50)
    end
    os.sleep(16.0)
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
        "  SP00D3R receives your gaming chair.",
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: STAR RATING
-- ============================================================
local function phase_stars()
    blast(colors.black, colors.yellow)
    center(2, "COMMUNITY RATING: YOU")
    os.sleep(1.50)
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
        {"SP00D3R Coolness",   10},
        {"SubaRubicon Comparison",1},
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.0)
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
        "is 600 fall damage deaths normal for one week",
        "how to befriend a chicken",
        "chicken took my stuff legally",
        "can gerald the pig have my account",
        "void keeps finding me why",
        "am i the problem on the bungus bois smp specifically",
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
        os.sleep(1.50)
    end
    os.sleep(15.0)
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
    os.sleep(1.50)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.yellow)
    center(h - 1, "TOTAL RAISED: " .. math.random(3,14) .. " gold")
    center(h, "GERALD RAISED MORE LAST WEEK")
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    m.setTextColor(colors.yellow)
    fillRow(row + 1, "-", colors.yellow, colors.black)
    center(row + 2, ("TOTAL OWED: $" .. (total * 0.25)))
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(16.0)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
    os.sleep(15.5)
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
        {n="SP00D3R",        s="1/5", r="Bro. What is this. Genuinely."},
        {n="iworkatjaguar",  s="1/5", r="Condemned as hazard. Radiation added."},
        {n="DrDarkMario",    s="1/5", r="Visited. Left immediately. No comment."},
        {n="SubaRubicon",    s="2/5", r="Asked DrDarkMario what to rate it."},
        {n="WardenFan",      s="1/5", r="No windows. Screamed. Left."},
        {n="ItsBasicallyBri",s="1/5", r="SubaRubicon helped build 1 wall. Dirt."},
        {n="LocalCreeper",  s="5/5", r="Perfect. Fell apart perfectly. 5/5."},
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        {s="1*",n="SP00D3R",         r="I filmed the whole thing. Still 1 star."},
        {s="1*",n="VerifiedBuyer",   r="Fell in lava on delivery. 1 star."},
        {s="1*",n="iworkatjaguar",   r="Death log full. Needed new integer. 1 star."},
        {s="1*",n="GrindMode",       r="Not as advertised. Much worse."},
        {s="1*",n="DrDarkMario",     r="SubaRubicon asked me to review it. No."},
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        "a dirt cube near iworkatjaguar's reactor.",
        "The radiation does not affect it.",
        "Or so it believes.",
        "",
        "Notice how it approaches the ledge.",
        "It has fallen off this ledge before.",
        "Many times.",
        "Each time: genuinely surprised.",
        "Every. Single. Time.",
        "",
        "Nearby, a younger creature watches.",
        "This is SP00D3R.",
        "SP00D3R is filming.",
        "SP00D3R is always filming.",
        "SP00D3R is cooler.",
        "This is known.",
        "",
        "The creature has a pig named Gerald.",
        "Gerald is doing very well.",
        "Gerald understands Apotheosis.",
        "The creature does not.",
        "Gerald has accepted this.",
        "",
        "A chicken approaches.",
        "The creature (mk4modz) freezes.",
        "Something happened between them.",
        "The chicken remembers.",
        "Gerald also remembers.",
        "SP00D3R filmed it.",
        "",
        "The creature steps into the lava.",
        "The lava is not surprised.",
        "The lava is never surprised.",
        "The lava has learned to expect this.",
        "The lava has come to enjoy it.",
        "",
        "Gerald watches from a safe distance.",
        "mk4modz falls off the ledge.",
        "Gerald watches from below.",
        "Gerald caught the falling items.",
        "Gerald always catches the items.",
        "Gerald has been doing this for months.",
        "Gerald is better than all of us.",
        "SP00D3R uploads the clip.",
        "The title: 'my older brother vs gravity (gravity wins)'",
        "94 views in 4 minutes.",
        "iworkatjaguar has watched it 12 times.",
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
        os.sleep(1.50)
    end
    os.sleep(16.0)
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
        {"Gerald (the pig)",     "A+",  "Gerald thriving. Better than you."},
        {"SP00D3R (brother)",    "A+",  "SP00D3R is cooler. Always was."},
        {"SubaRubicon (wiki)",   "F",   "Has never read a page. Never."},
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: BREAKING NEWS INTERVIEW
-- ============================================================
local function phase_interview()
    blast(colors.black, colors.white)
    center(2,"LIVE BREAKING NEWS INTERVIEW")
    fillRow(3,"=",colors.gray,colors.black)
    local interview = {
        {"R","mk4modz. You fell off the base again."},
        {"P","It was the jetpack."},
        {"R","You were not using the jetpack."},
        {"P","I was about to use it."},
        {"R","iworkatjaguar confirms you were standing still."},
        {"P","iworkatjaguar's logs are affected by the radiation."},
        {"R","The radiation does not affect the logs."},
        {"P","...The radiation does not affect the logs."},
        {"R","SP00D3R has sent us a clip."},
        {"P","Please do not show the clip."},
        {"R","The clip shows you falling off a flat surface."},
        {"P","That surface had an edge."},
        {"R","The edge was behind you."},
        {"P","Physics."},
        {"R","Any response to SubaRubicon's comments?"},
        {"P","SubaRubicon cannot comment. He doesn't know any mods."},
        {"R","He said you also don't know any mods."},
        {"P","I know Gerald. I know the chicken."},
        {"R","Those are not mods."},
        {"P","They are characters. With depth."},
        {"R","...We go to SP00D3R."},
        {"S","Yeah he does this a lot. He's my older brother."},
        {"S","I'm the cooler one. He knows this."},
        {"S","We love him though. He's our disaster."},
        {"R","And Gerald?"},
        {"G","Oink. [He fell again while we were filming this.]"},
        {"R","We confirm: he fell again."},
    }
    chatReset(4, h)
    for _,line in ipairs(interview) do
        local col = line[1]=="R" and colors.cyan   or
                    line[1]=="G" and colors.lime    or
                    line[1]=="S" and colors.yellow  or
                    colors.white
        local who = line[1]=="R" and "REPORTER: " or
                    line[1]=="G" and "GERALD:   " or
                    line[1]=="S" and "SP00D3R:  " or
                    "mk4modz:  "
        chatPush(who..line[2], col)
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
        os.sleep(0.30)
    end
    os.sleep(15.5)
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
            os.sleep(1.50)
        end
        os.sleep(14.5)
    end
end

-- ============================================================
-- PHASE: COURTROOM DRAMA
-- ============================================================
local function phase_courtroom()
    blast(colors.black, colors.white)
    center(2,"MINECRAFT CRIMINAL COURT")
    center(3,"Fall Damage v. mk4modz (again)")
    fillRow(4,"=",colors.gray,colors.black)
    local transcript = {
        {"JUDGE",   "Court in session. Charges?"},
        {"PROS.",   "Defendant fell off a flat surface."},
        {"JUDGE",   "How many times?"},
        {"PROS.",   tostring(math.random(50,700)).." fall damage deaths, Your Honour."},
        {"JUDGE",   "Good lord."},
        {"DEF.",    "It was the jetpack, Your Honour."},
        {"JUDGE",   "No jetpack equipped. iworkatjaguar confirms."},
        {"DEF.",    "The logs are irradiated."},
        {"JUDGE",   "The logs are not irradiated."},
        {"DEF.",    "...The logs are not wrong."},
        {"PROS.",   "Exhibit A: the edge he fell off."},
        {"PROS.",   "Exhibit B: SP00D3R clips ("..math.random(5,55).." of them)."},
        {"PROS.",   "Exhibit C: iworkatjaguar death log."},
        {"JUDGE",   "The log needed a new integer type."},
        {"DEF.",    "I was hoping for a settlement."},
        {"JUDGE",   "The lava cannot settle. It is lava."},
        {"DEF.",    "What about Gerald?"},
        {"JUDGE",   "Gerald is a witness."},
        {"GERALD",  "Oink. [He fell. Every time. No jetpack.]"},
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        "SP00D3R is cooler than me.",
        "I have made peace with both of these facts.",
        "I have not made peace with either of them.",
        "SubaRubicon somehow knows even fewer mods than me.",
        "This is the only thing I have on SubaRubicon.",
        "I will take it.",
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
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        os.sleep(14.5)
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
        "Gravity is handling it.",
        "Gravity has always handled it.",
        "I am just here to watch.",
        "Like SP00D3R.",
        "Like iworkatjaguar.",
        "Like DrDarkMario.",
        "Like Gerald.",
        "Like the chicken.",
        "We all watch.",
        "We all love you.",
        "SP00D3R especially.",
        "SP00D3R is still filming.",
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
        os.sleep(1.50)
    end
    os.sleep(16.0)
end



-- ============================================================
-- PHASE: GROUP CHAT (friends reacting in real time)
-- ============================================================
local function phase_groupchat()
    blast(colors.black, colors.black)
    m.setTextColor(colors.green)
    center(1,"Group Chat: bungus bois smp lads")
    fillRow(2,"-",colors.gray,colors.black)
    local names = {"SP00D3R","iworkatjaguar","DrDarkMario","SubaRubicon","ItsBasicallyBri"}
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
    chatReset(3, h)
    for _,msg in ipairs(msgs) do
        local who = msg[1]
        local txt = msg[2]
        local line, col
        if who == "" then
            line = "    " .. txt
            col  = colors.lightGray
        elseif who == "iworkatjaguar" then
            line = "[jaguar] " .. txt
            col  = colors.red
        elseif who == "SP00D3R" then
            line = "[SP00D3R] " .. txt
            col  = colors.lime
        elseif who == "DrDarkMario" then
            line = "[DrDark] " .. txt
            col  = colors.cyan
        elseif who == "SubaRubicon" then
            line = "[SubaR] " .. txt
            col  = colors.orange
        elseif who == "ItsBasicallyBri" then
            line = "[Bri] " .. txt
            col  = colors.pink
        else
            line = rnd(names) .. ": " .. txt
            col  = rnd(colors_list)
        end
        chatPush(line, col)
        os.sleep(1.50)
    end
    os.sleep(15.0)
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
        os.sleep(1.50)
        m.setTextColor(colors.lime)
        center(row+2, "Correct:     " .. q.ca)
        os.sleep(1.50)
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
    os.sleep(15.5)
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
        "SP00D3R wanted to say:",
        "'bro. i have 94 clips of you falling.",
        " I said be careful. You sped up.",
        " You are my older brother.",
        " I am the cooler one. We both know.'",
        "",
        "iworkatjaguar's letter reads:",
        "'You've fallen off things " .. math.random(300,999) .. " times.",
        " I have the logs. All of them.",
        " The leaderboard needed a new data type.",
        " Because of you. Specifically you.'",
        "",
        "DrDarkMario's statement:",
        "'Please also make SubaRubicon read a wiki.",
        " One page. Any page. I am so tired.'",
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
        "Gerald ran the PowerPoint.",
        "Gerald's PowerPoint was better than yours.",
        "",
        "The chicken was invited.",
        "The chicken came.",
        "The chicken stared at you.",
        "The chicken did not blink once.",
        "",
        "SubaRubicon attended.",
        "SubaRubicon asked what an intervention was.",
        "ItsBasicallyBri explained it.",
        "SubaRubicon asked if it was a mod.",
        "ItsBasicallyBri sat down.",
        "",
        "SP00D3R livestreamed it.",
        "37 people watched.",
        "They all agreed with the intervention.",
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
        os.sleep(1.50)
    end
    os.sleep(16.0)
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
        os.sleep(0.30)
    end
    os.sleep(16.0)
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
    chatReset(4, h)
    chatPush("FROM          STATUS    #", colors.lightGray)
    chatPush(string.rep("-", w-2), colors.gray)
    for _,c in ipairs(complaints) do
        local col = c.s=="Ongoing"   and colors.red    or
                    c.s=="Escalated" and colors.orange  or
                    c.s=="Valid"     and colors.yellow  or colors.lightGray
        local f1 = c.f:sub(1,13)
        local f2 = c.s:sub(1,9)
        local line = string.format("%-14s%-10s%d", f1, f2, c.n):sub(1,w-2)
        chatPush(line, col)
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        {a="Most Deaths (Server Record)",      w="mk4modz",       r="Fall damage. Specifically fall damage."},
        {a="Best Lava Relationship",            w="The Player",    r="Both parties committed."},
        {a="Worst Base Design",                 w="The Dirt Cube", r="Unanimous. Unopposed."},
        {a="Most Unban Appeals (Any Month)",    w="The Player",    r=math.random(6,55).." appeals. One month."},
        {a="Player Most Likely To Punch Golem", w="The Player",    r="Has done it multiple times."},
        {a="Lifetime Achievement: Dying",       w=genInsult(),     r="Contributions: immense."},
        {a="Server's Biggest Charity Project",  w="mk4modz",       r="SP00D3R helps him log back in."},
        {a="Best Performance: Blaming Lag",     w="mk4modz",       r="Committed. Consistent. It was fall damage."},
        {a="Most Improved",                     w="SP00D3R",       r="SP00D3R improves daily. Unlike his brother."},
        {a="Most Intimidating Entity",          w="The Chicken",   r="mk4modz specifically terrified of his own chicken."},
        {a="Most Questions Per Minute",         w="SubaRubicon",   r="All directed at DrDarkMario. All unanswered."},
        {a="Dirt Hoarder Of The Year",          w="mk4modz",       r=math.random(10000,99999).." blocks. Gerald manages them now."},
    }
    chatReset(5, h)
    for _,aw in ipairs(awards) do
        chatPush(aw.a, colors.cyan)
        chatPush("WINNER: "..aw.w, colors.yellow)
        chatPush("  "..aw.r, colors.lightGray)
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
        "One specific player account (mk4modz)",
        "has triggered our fall-damage alert",
        math.random(50,700) .. " times this month alone.",
        "We have also been alerted to a",
        "nuclear reactor event on this server.",
        "That is a separate but related concern.",
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
        "P.S. The nuclear reactor event:",
        "iworkatjaguar, we need to talk.",
        "P.P.S. SubaRubicon: please read a wiki.",
        "Any wiki. One page. For DrDarkMario.",
        "P.P.P.S. SP00D3R: excellent player.",
        "No notes. Keep being yourself.",
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
        os.sleep(0.30)
    end
    os.sleep(16.0)
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
        {"Full netherite set",  "Fell off base",      "DENIED (your fault)"},
        {"Elytra",              "Gravity",             "DENIED (you had jetpack)"},
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
    put(2, row, string.format("%-20s%-8s%s","ITEM","REASON","DECISION"):sub(1,w-2))
    row = row + 1
    fillRow(row,"-",colors.gray,colors.black)
    row = row + 1
    for i = 2,#items do
        if row >= h then break end
        local itm = items[i]
        m.setTextColor(itm[3]:sub(1,6)=="DENIED" and colors.red or colors.lime)
        local line = string.format("%-19s%-8s%s",
            itm[1]:sub(1,18), itm[2]:sub(1,7), itm[3]):sub(1,w-2)
        tw(2, row, line, 0.006)
        row = row + 1
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    center(h,"TOTAL APPROVED: 0.  TOTAL DENIED: EVERYTHING.")
    os.sleep(15.5)
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
        "SP00D3R: ok so why is mk4modz going toward the edge",
        "DrDarkMario: no idea. there is a fence.",
        "SP00D3R: he can see the fence right",
        "DrDarkMario: he can definitely see the fence",
        "SP00D3R: its right there",
        "DrDarkMario: yeah",
        "SP00D3R: its a fence",
        "DrDarkMario: a very visible fence yeah",
        "SP00D3R: oh no",
        "DrDarkMario: yep",
        "SP00D3R: oh no oh no",
        "DrDarkMario: there it is",
        "SP00D3R: I am filming this",
        "DrDarkMario: you should be filming this",
        "",
        "iworkatjaguar: (joins spectator)",
        "iworkatjaguar: what are we watching",
        "SP00D3R: mk4modz is heading back to the same edge",
        "iworkatjaguar: what",
        "SP00D3R: yeah",
        "iworkatjaguar: the same edge as before",
        "SP00D3R: yeah",
        "iworkatjaguar: does he know its the same edge",
        "DrDarkMario: I genuinely do not think he does",
        "iworkatjaguar: (leaves spectator)",
        "iworkatjaguar: (opens death log)",
        "",
        "SubaRubicon: (joins spectator)",
        "SubaRubicon: what are we watching",
        "SP00D3R: mk4modz fell again",
        "SubaRubicon: why does he keep doing that",
        "DrDarkMario: SubaRubicon that is the question",
        "SubaRubicon: is it a mod thing",
        "DrDarkMario: it is not a mod thing",
        "ItsBasicallyBri: SubaRubicon it is not a mod thing",
        "SubaRubicon: I feel like its a mod thing",
        "SP00D3R: mk4modz you are my favourite person on this server",
        "",
        "iworkatjaguar: F",
        "DrDarkMario: F",
        "SubaRubicon: what does F mean",
        "ItsBasicallyBri: F",
        "SP00D3R: F. with love.",
        "gerald: (oinks with tremendous dignity)",
    }
    chatReset(5, h)
    for _,line in ipairs(convos) do
        if line == "" then
            chatPush("", colors.black)
        else
            local who = line:match("^(%w+):")
            local col =
                who == "iworkatjaguar"   and colors.red    or
                who == "SP00D3R"         and colors.lime   or
                who == "DrDarkMario"     and colors.cyan   or
                who == "SubaRubicon"     and colors.orange or
                who == "ItsBasicallyBri" and colors.pink   or
                who == "gerald"          and colors.lime   or
                colors.white
            chatPush(line, col)
        end
        os.sleep(1.50)
    end
    os.sleep(15.5)
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
    chatReset(5, h)
    for _,rv in ipairs(reviews) do
        local col = rv.stars=="5*" and colors.lime or
                    rv.stars=="N/A" and colors.orange or colors.yellow
        local nm = (rv.mob..": "):sub(1,12)
        chatPush(nm..rv.stars.." "..rv.r, col)
        os.sleep(1.50)
    end
    os.sleep(15.5)
end



-- ============================================================
-- PHASE: SUBARUBICON'S ATM10 HELPDESK
-- ============================================================
local function phase_subarubicon()
    blast(colors.black, colors.orange)
    m.setTextColor(colors.orange)
    center(2,"SubaRubicon's ATM10 Journey")
    m.setTextColor(colors.lightGray)
    center(3,"Day "..math.random(80,200)..". Progress: none.")
    fillRow(4,"-",colors.orange,colors.black)
    local log = {
        "DAY 1:",
        "  SubaRubicon joins ATM10.",
        "  Asks DrDarkMario what a pickaxe is.",
        "  DrDarkMario explains patiently.",
        "",
        "DAY "..math.random(5,15)..":",
        "  Asks DrDarkMario what RF energy is.",
        "  DrDarkMario explains. Again.",
        "  SubaRubicon nods. Asks again.",
        "",
        "DAY "..math.random(20,40)..":",
        "  Asks DrDarkMario what ME storage is.",
        "  DrDarkMario sends wiki link.",
        "  SubaRubicon: 'can you just explain it'",
        "  DrDarkMario: *silent for 4 minutes*",
        "",
        "DAY "..math.random(50,80)..":",
        "  Asks DrDarkMario what Mekanism is.",
        "  DrDarkMario: 'SubaRubicon please'",
        "  SubaRubicon: 'is it like Apotheosis'",
        "  DrDarkMario: 'it is not like Apotheosis'",
        "  SubaRubicon: 'what is Apotheosis'",
        "  DrDarkMario has left the server.",
        "",
        "TODAY:",
        "  SubaRubicon asks what Create mod does.",
        "  ItsBasicallyBri: 'babe we talked about this'",
        "  SubaRubicon: 'I learn by asking'",
        "  ItsBasicallyBri: 'you do not learn'",
        "  SubaRubicon: 'DrDarkMario can you hear me'",
        "  DrDarkMario: *has changed name to DoNotAsk*",
        "  SubaRubicon: 'DoNotAsk can you explain Create'",
    }
    local row = 5
    for _,line in ipairs(log) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,3)=="DAY" and colors.yellow or colors.lightGray)
            tw(2,row,line,0.013)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: IWORKATJAGUAR'S REACTOR INCIDENT REPORT
-- ============================================================
local function phase_reactor()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(2,"INCIDENT REPORT: THE REACTOR")
    m.setTextColor(colors.lightGray)
    center(3,"Ref: iworkatjaguar/meltdown/"..math.random(1,3))
    fillRow(4,"=",colors.red,colors.black)
    local report = {
        "DATE: Recently. Too recently.",
        "REPORTING: iworkatjaguar (the admin)",
        "SUBJECT: The fission reactor I built",
        "         adjacent to spawn.",
        "",
        "SUMMARY:",
        "The reactor was functioning within",
        "normal parameters. Mostly.",
        "There was a small event.",
        "The server is now irradiated.",
        "I consider this a partial success.",
        "",
        "CASUALTIES:",
        " - mk4modz: died to radiation",
        "   (also died to fall damage same day)",
        "   (radiation was not the primary cause)",
        " - SubaRubicon: unaffected",
        "   (too confused to absorb radiation)",
        " - DrDarkMario: annoyed but fine",
        " - ItsBasicallyBri: filed a complaint",
        " - SP00D3R: filmed the whole thing",
        "   (SP00D3R was fine. SP00D3R is always fine.)",
        " - Gerald: unaffected. Gerald is thriving.",
        " - The chicken: knew it would happen.",
        "   The chicken always knows.",
        "",
        "ROOT CAUSE:",
        "The reactor needed cooling.",
        "I did not cool it.",
        "I thought it would be fine.",
        "It was not fine.",
        "",
        "RECOMMENDED ACTION:",
        "A second reactor to power the cooling",
        "system for the first reactor.",
        "",
        "iworkatjaguar",
        "(still the admin, yes)",
    }
    local row = 5
    for _,line in ipairs(report) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,1)==" " and colors.lightGray or colors.white)
            tw(2,row,line,0.013)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: SP00D3R APPRECIATION SEGMENT
-- (the one nice thing on the monitor)
-- ============================================================
local function phase_sp00d3r()
    blast(colors.black, colors.lime)
    m.setTextColor(colors.lime)
    center(2,"SP00D3R APPRECIATION MOMENT")
    center(3,string.rep("*",math.min(16,w)))
    os.sleep(1.50)
    local lines = {
        "SP00D3R is the best player on this server.",
        "SP00D3R has never died to fall damage.",
        "SP00D3R has never walked into lava.",
        "SP00D3R has never needed to ask DrDarkMario",
        "   what Apotheosis is.",
        "SP00D3R just... knew.",
        "He always just knows.",
        "",
        "SP00D3R filmed mk4modz falling "..math.random(40,100).." times.",
        "SP00D3R shared all of them.",
        "SP00D3R titled the compilation:",
        "   'my older brother vs physics'",
        "   'physics wins. always.'",
        "",
        "SP00D3R has more server kills than",
        "mk4modz, SubaRubicon, Gerald, AND",
        "the chicken combined.",
        "SP00D3R does not talk about this.",
        "SP00D3R is humble.",
        "SP00D3R is cooler than mk4modz.",
        "mk4modz agrees.",
        "This has always been true.",
        "",
        "We love SP00D3R.",
        "SP00D3R is the favourite.",
        "This is official server policy.",
        "iworkatjaguar confirmed this in the logs.",
        "The logs are not irradiated.",
        "The logs are correct.",
        "SP00D3R is the favourite.",
    }
    local row = 4
    for _,line in ipairs(lines) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(colors.lime)
            center(row,line)
            row = row+1
        end
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: MK4MODZ FALL DAMAGE ANALYSIS
-- ============================================================
local function phase_fallanalysis()
    blast(colors.black, colors.white)
    center(2,"FALL DAMAGE: A SCIENTIFIC ANALYSIS")
    center(3,"Subject: mk4modz. Duration: ongoing.")
    fillRow(4,"=",colors.gray,colors.black)
    local falls = {
        {"Fell off roof of dirt cube",         math.random(10,30).."x"},
        {"Fell off ladder (going up)",          math.random(5,20).."x"},
        {"Fell off ladder (going down)",        math.random(5,20).."x"},
        {"Fell into hole he dug",               math.random(20,60).."x"},
        {"Fell into same hole same day",        math.random(5,20).."x"},
        {"Fell off flat surface (unexplained)", math.random(15,40).."x"},
        {"Fell while standing still",           math.random(3,15).."x"},
        {"Fell during crafting",                math.random(2,10).."x"},
        {"Fell off iworkatjaguar's reactor",    math.random(5,15).."x"},
        {"Fell while watching SP00D3R",         math.random(5,20).."x"},
        {"Fell off own jetpack midair",         math.random(3,12).."x"},
        {"Fell with jetpack equipped unused",   math.random(10,30).."x"},
        {"Fell into lava via fall damage",      math.random(5,20).."x"},
        {"Fell off scaffold Gerald was using",  math.random(2,8).."x"},
        {"Fell in front of the chicken",        math.random(3,10).."x"},
        {"  (chicken did not help)",            "all of them"},
    }
    chatReset(5, h)
    chatPush("FALL TYPE              COUNT", colors.lightGray)
    chatPush(string.rep("-", w-2), colors.gray)
    for _,f in ipairs(falls) do
        local col = f[1]:sub(1,1)==" " and colors.orange or colors.white
        local col1w = math.max(1, w - 8)
        local line = string.format("%-"..col1w.."s%s", f[1]:sub(1,col1w), f[2]):sub(1,w-2)
        chatPush(line, col)
        os.sleep(1.50)
    end
    os.sleep(1.50)
    m.setTextColor(colors.red)
    center(h,"CONCLUSION: mk4modz and gravity are at war.")
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: SERVER TIER LIST
-- ============================================================
local function phase_tierlist()
    blast(colors.black, colors.white)
    center(2,"SERVER TIER LIST (OFFICIAL)")
    center(3,"Compiled by: the server, unanimously")
    fillRow(4,"=",colors.gray,colors.black)
    local tiers = {
        {"S TIER (GOAT)",    colors.lime,   "SP00D3R"},
        {"A TIER (SOLID)",   colors.cyan,   "iworkatjaguar (when not building reactors)"},
        {"A TIER (SOLID)",   colors.cyan,   "DrDarkMario (incredibly patient man)"},
        {"A TIER (SOLID)",   colors.cyan,   "Gerald the pig"},
        {"A TIER (SOLID)",   colors.cyan,   "The chicken (has standards)"},
        {"B TIER (OK)",      colors.yellow, "ItsBasicallyBri"},
        {"C TIER (SHAKY)",   colors.orange, "iworkatjaguar (when building reactors)"},
        {"D TIER (ROUGH)",   colors.red,    "SubaRubicon (tries hard, knows nothing)"},
        {"F TIER (YIKES)",   colors.red,    "mk4modz (fall damage. always fall damage.)"},
        {"X TIER (SPECIAL)", colors.purple, "mk4modz's fall damage specifically"},
        {"",                 colors.black,  ""},
        {"NOTES:",           colors.lightGray,"Gerald and SP00D3R contested S tier."},
        {"",                 colors.lightGray,"Gerald deferred to SP00D3R graciously."},
        {"",                 colors.lightGray,"SubaRubicon asked what a tier list is."},
        {"",                 colors.lightGray,"DrDarkMario did not answer."},
        {"",                 colors.lightGray,"mk4modz accepted F tier."},
        {"",                 colors.lightGray,"mk4modz: 'seems fair honestly'"},
    }
    chatReset(5, h)
    for _,t in ipairs(tiers) do
        if t[1] == "" then
            chatPush("", colors.black)
        else
            local label = (t[1]..": "):sub(1,14)
            chatPush(label..t[3]:sub(1,w-#label-2), t[2])
        end
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: DRDARKMARIO'S RESIGNATION LETTER
-- ============================================================
local function phase_resignation()
    blast(colors.black, colors.white)
    m.setTextColor(colors.cyan)
    center(2,"RESIGNATION LETTER")
    m.setTextColor(colors.lightGray)
    center(3,"From: DrDarkMario")
    center(4,"To: Everyone, specifically SubaRubicon")
    fillRow(5,"=",colors.gray,colors.black)
    local letter = {
        "Effective immediately, I am resigning",
        "from my role as:",
        "",
        " - Server wiki",
        " - Personal ATM10 tutor (SubaRubicon)",
        " - Mod explainer (mk4modz, occasionally)",
        " - Reactor safety advisor (iworkatjaguar,",
        "   who did not listen)",
        " - Emotional support (ItsBasicallyBri,",
        "   re: SubaRubicon's mod knowledge)",
        " - SP00D3R's hype man (he doesn't need one)",
        " - Gerald's consultant (Gerald knows more)",
        " - The chicken's legal representation",
        "   (the chicken does not need it either)",
        "",
        "Reasons for resignation:",
        "SubaRubicon asked me what Apotheosis is.",
        "I have explained Apotheosis "..math.random(8,25).." times.",
        "He asked me what Apotheosis stood for.",
        "I told him: Apotheosis.",
        "He asked what Energistics meant.",
        "I have left the server.",
        "",
        "I will return.",
        "I always return.",
        "SubaRubicon will ask again immediately.",
        "I know this.",
        "I accept this.",
        "I am so tired.",
        "",
        "Regards,",
        "DrDarkMario",
        "(back online in 10 minutes probably)",
    }
    local row = 6
    for _,line in ipairs(letter) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,1)==" " and colors.lightGray or colors.white)
            tw(2,row,line,0.015)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: SERVER DISCORD LOG
-- ============================================================
local function phase_discordlog()
    blast(colors.black, colors.magenta)
    m.setTextColor(colors.magenta)
    center(2,"#bungus-bois-general")
    m.setTextColor(colors.lightGray)
    center(3,"Today at "..math.random(1,12)..":"..string.format("%02d",math.random(0,59)).."PM")
    fillRow(4,"-",colors.magenta,colors.black)
    local msgs = {
        {"SP00D3R",       colors.lime,   "bro mk4modz just fell off again"},
        {"SP00D3R",       colors.lime,   "from the ground floor"},
        {"SP00D3R",       colors.lime,   "i dont know how"},
        {"iworkatjaguar", colors.red,    "mk4modz death log entry #"..math.random(300,999)},
        {"iworkatjaguar", colors.red,    "cause: fall damage (flat surface)"},
        {"iworkatjaguar", colors.red,    "witnesses: SP00D3R (filming), Gerald"},
        {"DrDarkMario",   colors.cyan,   "how"},
        {"SP00D3R",       colors.lime,   "i have the clip"},
        {"SP00D3R",       colors.lime,   "i always have the clip"},
        {"SubaRubicon",   colors.orange, "hey DrDarkMario what is Apotheosis"},
        {"DrDarkMario",   colors.cyan,   "SubaRubicon"},
        {"DrDarkMario",   colors.cyan,   "I have explained Apotheosis to you"},
        {"DrDarkMario",   colors.cyan,   math.random(8,25).." times"},
        {"SubaRubicon",   colors.orange, "yeah but I forgot"},
        {"ItsBasicallyBri",colors.pink,  "babe"},
        {"SubaRubicon",   colors.orange, "I learn better by asking"},
        {"ItsBasicallyBri",colors.pink,  "you don't learn"},
        {"SubaRubicon",   colors.orange, "I learn a little"},
        {"ItsBasicallyBri",colors.pink,  "you don't"},
        {"DrDarkMario",   colors.cyan,   "Apotheosis is a storage mod SubaRubicon"},
        {"DrDarkMario",   colors.cyan,   "it lets you store many items"},
        {"SubaRubicon",   colors.orange, "ok"},
        {"SubaRubicon",   colors.orange, "what's ME storage"},
        {"DrDarkMario",   colors.cyan,   "that IS Apotheosis"},
        {"SubaRubicon",   colors.orange, "oh"},
        {"SubaRubicon",   colors.orange, "what's Apotheosis"},
        {"DrDarkMario",   colors.cyan,   "(has left the server)"},
        {"SP00D3R",       colors.lime,   "mk4modz fell again"},
        {"SP00D3R",       colors.lime,   "different spot"},
        {"iworkatjaguar", colors.red,    "the reactor is also making a noise"},
        {"SP00D3R",       colors.lime,   "iworkatjaguar"},
        {"iworkatjaguar", colors.red,    "it's probably fine"},
        {"SP00D3R",       colors.lime,   "iworkatjaguar"},
        {"iworkatjaguar", colors.red,    "Gerald is fine"},
        {"SP00D3R",       colors.lime,   "Gerald is always fine"},
        {"SP00D3R",       colors.lime,   "Gerald is the only one of us who is always fine"},
    }
    chatReset(5, h)
    for _,msg in ipairs(msgs) do
        local prefix = (msg[1]..": "):sub(1,14)
        chatPush(prefix..msg[3], msg[2])
        os.sleep(1.50)
    end
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: IRL LIVING SITUATION
-- ============================================================
local function phase_irl()
    blast(colors.black, colors.white)
    center(2,"IRL SITUATION: THEIR HOUSE")
    center(3,"SubaRubicon + ItsBasicallyBri + iworkatjaguar")
    fillRow(4,"=",colors.gray,colors.black)
    local timeline = {
        "MORNING:",
        "  SubaRubicon wakes up.",
        "  SubaRubicon immediately asks iworkatjaguar",
        "  what Mekanism is.",
        "  iworkatjaguar says he is also admin.",
        "  SubaRubicon asks what an admin is.",
        "",
        "AFTERNOON:",
        "  iworkatjaguar logs on to check reactor.",
        "  Reactor is fine (it is not fine).",
        "  iworkatjaguar logs off satisfied.",
        "  Reactor makes a new sound.",
        "  iworkatjaguar does not hear this.",
        "",
        "EVENING:",
        "  All three log on.",
        "  SubaRubicon asks DrDarkMario (online)",
        "  what thermal expansion does.",
        "  DrDarkMario is in a different country.",
        "  DrDarkMario still has to answer.",
        "  DrDarkMario is tired.",
        "",
        "LATE NIGHT:",
        "  mk4modz logs on and falls off something.",
        "  SP00D3R clips it immediately.",
        "  SP00D3R is also in a different location.",
        "  SP00D3R is always watching.",
        "  SP00D3R is always filming.",
        "  SP00D3R sends clip to the group chat.",
        "  Everyone watches it "..math.random(3,12).." times.",
        "  Gerald watches it too.",
        "  Gerald does not react.",
        "  Gerald has seen this before.",
        "  Gerald will see it again.",
    }
    local row = 5
    for _,line in ipairs(timeline) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,2)=="  " and colors.lightGray or colors.yellow)
            tw(2,row,line,0.013)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: MK4MODZ vs SP00D3R BROTHER COMPARISON
-- ============================================================
local function phase_brothers()
    blast(colors.black, colors.white)
    center(2,"BROTHER COMPARISON CHART")
    center(3,"mk4modz (older) vs SP00D3R (cooler)")
    fillRow(4,"=",colors.gray,colors.black)
    -- Dynamic column widths so nothing overflows regardless of monitor size
    local c1 = math.floor(w * 0.35)   -- stat name
    local c2 = math.floor(w * 0.30)   -- mk4modz value
    -- c3 fills the rest
    local comparisons = {
        {"Age",              "Older",                  "Younger"},
        {"Coolness",         "Lower",                  "Higher"},
        {"Fall deaths",      math.random(100,500).."", "0"},
        {"Lava deaths",      math.random(50,300).."",  "0"},
        {"Clips of self",    "0 (all by SP00D3R)",     math.random(40,100).."+"},
        {"ATM10 mods known", math.random(1,3).."",     math.random(8,15).."+"},
        {"K/D ratio",        "0.0"..math.random(1,4),  math.random(3,9)..".0+"},
        {"Gerald opinion",   "Concerned",              "Approves"},
        {"Chicken opinion",  "Hostile",                "Neutral"},
        {"iworkatjaguar",    "In the logs",            "In highlights"},
        {"DrDarkMario",      "Minor concern",          "No concerns"},
        {"SubaRubicon",      "Also confused",          "Asks advice"},
        {"Overall",          "F tier",                 "S tier"},
        {"Verdict",          "Our disaster",           "Our favourite"},
    }
    chatReset(5, h)
    -- Header
    local fmt = "%-"..c1.."s %-"..c2.."s %s"
    chatPush(string.format(fmt,"STAT","mk4modz","SP00D3R"):sub(1,w-2), colors.lightGray)
    chatPush(string.rep("-", w-2), colors.gray)
    for _,c in ipairs(comparisons) do
        local col = c[1]=="Overall" and colors.red  or
                    c[1]=="Verdict" and colors.lime  or colors.white
        local s1  = c[1]:sub(1, c1)
        local s2  = tostring(c[2]):sub(1, c2)
        local s3  = tostring(c[3]):sub(1, w - c1 - c2 - 4)
        chatPush(string.format(fmt, s1, s2, s3):sub(1,w-2), col)
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: FAKE SERVER STEAM REVIEWS
-- ============================================================
local function phase_steamreviews()
    blast(colors.black, colors.blue)
    m.setTextColor(colors.cyan)
    center(2,"STEAM REVIEWS: BUNGUS BOIS SMP")
    m.setTextColor(colors.yellow)
    center(3,"MIXED  ("..math.random(100,500).." reviews)")
    fillRow(4,"-",colors.gray,colors.black)
    local reviews = {
        {name="SP00D3R",        rec="YES", hrs=math.random(500,2000),
         txt="Great server. My older brother provides constant content."},
        {name="iworkatjaguar",  rec="YES", hrs=math.random(1000,5000),
         txt="I run it. The reactor is fine. Mostly. Recommend."},
        {name="DrDarkMario",    rec="YES", hrs=math.random(300,1000),
         txt="Good server. SubaRubicon is a unique challenge."},
        {name="SubaRubicon",    rec="YES", hrs=math.random(200,800),
         txt="Love it. DrDarkMario explains everything for me."},
        {name="ItsBasicallyBri",rec="YES", hrs=math.random(200,600),
         txt="Fun. SubaRubicon is there which is both good and bad."},
        {name="mk4modz",        rec="YES", hrs=math.random(400,1200),
         txt="Good server. Fall damage may be broken. Probably not."},
        {name="Gerald_Pig",     rec="YES", hrs=math.random(800,3000),
         txt="I live here now. I manage the economy. Good server."},
        {name="TheChicken",     rec="NO",  hrs=math.random(100,400),
         txt="mk4modz is here. I have unresolved issues with mk4modz."},
        {name="TheLava",        rec="YES", hrs=9999,
         txt="mk4modz visits consistently. Loyal customer. 10/10."},
        {name="GravityEngine",  rec="YES", hrs=9999,
         txt="mk4modz provides excellent engagement. Very consistent."},
    }
    chatReset(5, h)
    for _,rv in ipairs(reviews) do
        local col = rv.rec=="YES" and colors.lime or colors.red
        local hdr = (rv.rec=="YES" and "✓ " or "✗ ")..rv.name.." ("..rv.hrs.."hrs):"
        chatPush(hdr, col)
        chatPush("  "..rv.txt, colors.lightGray)
        os.sleep(1.50)
    end
    os.sleep(15.5)
end

-- ============================================================
-- PHASE: GERALD'S OFFICIAL STATEMENT
-- ============================================================
local function phase_gerald_statement()
    blast(colors.black, colors.white)
    m.setTextColor(colors.lime)
    center(2,"OFFICIAL STATEMENT")
    m.setTextColor(colors.lightGray)
    center(3,"From: Gerald (mk4modz's pig)")
    fillRow(4,"=",colors.lime,colors.black)
    local stmt = {
        "I am Gerald.",
        "mk4modz named me Gerald.",
        "mk4modz cannot eat pork because of me.",
        "I did not ask for this.",
        "I accept it.",
        "",
        "I have been on this server for",
        math.random(3,12).." months.",
        "In that time I have:",
        "",
        " - Witnessed "..math.random(100,500).." of mk4modz's falls.",
        " - Caught his items "..math.random(80,400).." times.",
        " - Watched him walk toward lava.",
        " - Watched him walk into lava.",
        " - Watched him walk toward the same lava.",
        " - Said nothing. I am a pig.",
        "",
        " - Watched SP00D3R film all of this.",
        " - SP00D3R is the cooler brother.",
        " - I agree with this assessment.",
        "",
        " - Watched SubaRubicon ask DrDarkMario",
        "   things that are on the wiki.",
        " - DrDarkMario is tired.",
        " - I understand.",
        "",
        " - Survived iworkatjaguar's reactor.",
        " - The radiation did not affect me.",
        " - I am fine.",
        " - I am always fine.",
        "",
        "I manage the server economy now.",
        "iworkatjaguar gave me admin.",
        "I deserve it.",
        "mk4modz agrees.",
        "mk4modz always agrees.",
        "mk4modz is a good owner.",
        "Terrible player.",
        "Very good owner.",
        "",
        "Regards,",
        "Gerald",
        "(mk4modz's pig / server admin)",
    }
    local row = 5
    for _,line in ipairs(stmt) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,1)==" " and colors.lightGray or colors.white)
            tw(2,row,line,0.015)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: SERVER RULES (PERSON-SPECIFIC)
-- ============================================================
local function phase_rules()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.yellow)
    center(2,"BUNGUS BOIS SMP: SERVER RULES")
    m.setTextColor(colors.lightGray)
    center(3,"(these exist because of specific people)")
    fillRow(4,"=",colors.yellow,colors.black)
    local rules = {
        "RULE 1: No griefing.",
        "  (Reason: general)",
        "",
        "RULE 2: No xraying.",
        "  (Reason: general)",
        "",
        "RULE 7: mk4modz must announce",
        "  before using any elevated surface.",
        "  (Reason: the fall damage incidents)",
        "  (There are too many to list here)",
        "",
        "RULE 12: SubaRubicon must attempt",
        "  the wiki before asking DrDarkMario.",
        "  (One page. Any page. Please.)",
        "  (DrDarkMario wrote this rule himself)",
        "",
        "RULE 14: No fission reactors",
        "  within "..math.random(50,200).." blocks of spawn.",
        "  (Reason: iworkatjaguar. The reactor.)",
        "  (The server is still irradiated.)",
        "",
        "RULE 19: The chicken is",
        "  not to be provoked.",
        "  (Reason: mk4modz provoked it)",
        "  (The chicken remembers everything)",
        "",
        "RULE 23: SP00D3R may film anything.",
        "  (Reason: SP00D3R requested this rule)",
        "  (iworkatjaguar agreed immediately)",
        "  (everyone agreed immediately)",
        "",
        "RULE 31: Gerald has admin.",
        "  (Reason: Gerald earned it)",
        "  (No further explanation needed)",
    }
    local row = 5
    for _,line in ipairs(rules) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,4)=="RULE" and colors.yellow or colors.lightGray)
            tw(2,row,line,0.013)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: SUBARUBICON'S WIKI READING ATTEMPT
-- ============================================================
local function phase_wikifail()
    blast(colors.black, colors.white)
    center(2,"SubaRubicon Attempts The Wiki")
    center(3,"Attempt #"..math.random(2,8)..". Witness: DrDarkMario.")
    fillRow(4,"-",colors.gray,colors.black)
    local attempt = {
        "10:00 AM: SubaRubicon opens wiki.",
        "          DrDarkMario is watching.",
        "",
        "10:00:12: SubaRubicon reads title.",
        "          Title: 'Apotheosis'",
        "          SubaRubicon: 'what is Apotheosis'",
        "",
        "10:00:15: DrDarkMario explains Apotheosis.",
        "          SubaRubicon: 'ok'",
        "",
        "10:00:20: SubaRubicon reads first sentence.",
        "          First sentence: 'Apotheosis is a mod'",
        "          SubaRubicon: 'what is a mod'",
        "",
        "10:00:22: DrDarkMario takes a moment.",
        "",
        "10:00:45: DrDarkMario explains what a mod is.",
        "          SubaRubicon: 'oh like Create?'",
        "          DrDarkMario: 'yes like Create'",
        "          SubaRubicon: 'what is Create'",
        "",
        "10:00:47: DrDarkMario has left the server.",
        "",
        "10:01:00: SubaRubicon asks ItsBasicallyBri",
        "          what Create mod does.",
        "          ItsBasicallyBri: 'babe'",
        "          SubaRubicon: 'what'",
        "          ItsBasicallyBri: 'just'",
        "          SubaRubicon: 'what'",
        "          ItsBasicallyBri: 'ask mk4modz'",
        "          mk4modz: 'I also don't know'",
        "          mk4modz: 'but I also won't look it up'",
        "          mk4modz: 'we are the same'",
        "          SubaRubicon: 'we are the same'",
        "          DrDarkMario: (silent sobbing, detectable)",
    }
    local row = 5
    for _,line in ipairs(attempt) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            local ts = line:match("^%d%d:%d%d")
            m.setTextColor(ts and colors.yellow or colors.lightGray)
            tw(2,row,line,0.013)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: 3AM SERVER LOG
-- ============================================================
local function phase_3am()
    blast(colors.black, colors.black)
    m.setTextColor(colors.red)
    center(2,"SERVER LOG: 3:00 AM")
    m.setTextColor(colors.lightGray)
    center(3,"(everyone should be asleep)")
    fillRow(4,"-",colors.gray,colors.black)
    local log = {
        "[03:00:00] iworkatjaguar: checking reactor",
        "[03:00:04] iworkatjaguar: reactor seems fine",
        "[03:00:07] iworkatjaguar: *new noise from reactor*",
        "[03:00:09] iworkatjaguar: that's a new noise",
        "[03:00:11] iworkatjaguar: going to investigate",
        "[03:00:15] iworkatjaguar has died (reactor)",
        "[03:00:20] iworkatjaguar: still fine probably",
        "",
        "[03:01:44] mk4modz has joined the server",
        "[03:01:47] mk4modz has died (fall damage)",
        "[03:01:50] mk4modz: did you see that",
        "[03:01:52] iworkatjaguar: I did not see that",
        "[03:01:53] iworkatjaguar: I have the logs",
        "[03:01:54] mk4modz: what do the logs say",
        "[03:01:55] iworkatjaguar: fall damage",
        "[03:01:56] mk4modz: that's not what happened",
        "[03:01:57] iworkatjaguar: it is what happened",
        "",
        "[03:04:21] SubaRubicon has joined the server",
        "[03:04:23] SubaRubicon: DrDarkMario are you on",
        "[03:04:25] DrDarkMario has joined the server",
        "[03:04:26] DrDarkMario: why",
        "[03:04:27] SubaRubicon: what is rf energy",
        "[03:04:28] DrDarkMario: it is 3am SubaRubicon",
        "[03:04:29] SubaRubicon: yes but what is rf energy",
        "[03:04:31] DrDarkMario has left the server",
        "",
        "[03:08:15] SP00D3R has joined the server",
        "[03:08:16] SP00D3R: I saw the clip mk4modz",
        "[03:08:17] SP00D3R: the 3am fall",
        "[03:08:18] SP00D3R: truly remarkable",
        "[03:08:19] mk4modz: how do you have a clip",
        "[03:08:20] SP00D3R: I am always watching",
        "[03:08:21] mk4modz: it was one fall",
        "[03:08:22] SP00D3R: it was three falls",
        "[03:08:23] SP00D3R: within four minutes",
        "[03:08:24] sp00d3r is cooler than mk4modz (system msg)",
        "[03:08:25] iworkatjaguar: I added that system message",
        "[03:08:26] iworkatjaguar: it fires every time mk4modz joins",
        "[03:08:27] Gerald: *oinks approvingly*",
    }
    chatReset(5, h)
    for _,line in ipairs(log) do
        if line == "" then
            chatPush("", colors.black)
        else
            local col =
                line:find("SP00D3R")       and colors.lime    or
                line:find("iworkatjaguar") and colors.red     or
                line:find("DrDarkMario")   and colors.cyan    or
                line:find("SubaRubicon")   and colors.orange  or
                line:find("mk4modz")       and colors.white   or
                line:find("Gerald")        and colors.lime    or
                line:find("system msg")    and colors.yellow  or
                colors.lightGray
            chatPush(line, col)
        end
        os.sleep(1.50)
    end
    os.sleep(16.0)
end



-- ============================================================
-- PHASE: REACTOR LEADERBOARD
-- iworkatjaguar's reactor damage statistics
-- ============================================================
local function phase_reactor_stats()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(2,"REACTOR FALLOUT: DAMAGE REPORT")
    m.setTextColor(colors.lightGray)
    center(3,"Compiled by: iworkatjaguar (the admin)")
    fillRow(4,"=",colors.red,colors.black)
    local stats = {
        {"Server radiation level",     "ELEVATED (fine probably)"},
        {"Chunks irradiated",           math.random(20,80).." chunks"},
        {"iworkatjaguar assessment",    "'it's like a banana'"},
        {"DrDarkMario assessment",      "'it is NOT like a banana'"},
        {"mk4modz deaths by radiation", math.random(3,15)},
        {"mk4modz deaths by fall same day",math.random(5,20)},
        {"mk4modz: which killed him first","fall damage (confirmed)"},
        {"SubaRubicon radiation deaths", 0},
        {"SubaRubicon reason",          "too confused to absorb it"},
        {"SP00D3R radiation deaths",    0},
        {"SP00D3R reason",              "SP00D3R doesn't die"},
        {"Gerald radiation deaths",     0},
        {"Gerald reason",               "Gerald is always fine"},
        {"Chicken radiation deaths",    0},
        {"Chicken reason",              "the chicken transcends physics"},
        {"ItsBasicallyBri assessment",  "'this is a lawsuit'"},
        {"iworkatjaguar response",      "'I am also the admin'"},
        {"ItsBasicallyBri response",    "'that is not how lawsuits work'"},
        {"Second reactor planned",      "yes (to cool the first one)"},
        {"Everyone else's response",    "'please do not'"},
        {"iworkatjaguar",               "'it will be fine'"},
    }
    local row = 5
    for _,s in ipairs(stats) do
        if row >= h then break end
        m.setTextColor(type(s[2])=="number" and
            (s[2]==0 and colors.lime or colors.red) or colors.lightGray)
        local line = string.format("%-24s%s",
            s[1]:sub(1,24), tostring(s[2]):sub(1,w-26))
        tw(2,row,line,0.007)
        row = row+1
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: ITSBASICALLYBRI PERSPECTIVE
-- ============================================================
local function phase_bri()
    blast(colors.black, colors.pink)
    m.setTextColor(colors.pink)
    center(2,"ItsBasicallyBri: A Statement")
    fillRow(3,"-",colors.pink,colors.black)
    local lines = {
        "I live with SubaRubicon.",
        "And iworkatjaguar.",
        "This is a choice I made.",
        "I stand by it.",
        "Mostly.",
        "",
        "SubaRubicon has been playing ATM10",
        "for "..math.random(3,8).." months.",
        "He knows "..math.random(0,2).." mods.",
        "One of those is the dirt mod.",
        "(There is no dirt mod.",
        " He thinks there is a dirt mod.",
        " There is not a dirt mod.)",
        "",
        "iworkatjaguar built a reactor.",
        "The reactor had an event.",
        "The server is now irradiated.",
        "iworkatjaguar describes this as 'fine'.",
        "iworkatjaguar is wrong.",
        "I filed a complaint.",
        "iworkatjaguar said he is the admin.",
        "I said that is not relevant.",
        "He added a rule saying it is relevant.",
        "I have further complaints.",
        "",
        "mk4modz fell off something again.",
        "SP00D3R filmed it.",
        "SP00D3R is the younger brother.",
        "SP00D3R is also the cooler brother.",
        "mk4modz agrees.",
        "mk4modz always agrees.",
        "mk4modz fell off something",
        "while agreeing.",
        "SP00D3R filmed that too.",
        "",
        "Gerald is my favourite person on",
        "this server.",
        "Gerald is a pig.",
        "This says something.",
        "I'm not sure what.",
        "Something.",
    }
    local row = 4
    for _,line in ipairs(lines) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,1)=="(" and colors.lightGray or colors.white)
            tw(2,row,line,0.016)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: SP00D3R'S CLIP ARCHIVE
-- ============================================================
local function phase_clips()
    blast(colors.black, colors.lime)
    m.setTextColor(colors.lime)
    center(2,"SP00D3R'S CLIP ARCHIVE")
    m.setTextColor(colors.lightGray)
    center(3,"Subject: mk4modz. Runtime: "..math.random(4,12).." hours total.")
    fillRow(4,"-",colors.lime,colors.black)
    local clips = {
        {t="mk4modz vs gravity ep1",      v=math.random(80,500),  d="The first fall. The original."},
        {t="mk4modz vs gravity ep2",      v=math.random(80,500),  d="Different spot. Same result."},
        {t="mk4modz vs gravity ep3-47",   v=math.random(200,2000),d="Compilation. No commentary needed."},
        {t="mk4modz vs the jetpack",      v=math.random(80,500),  d="Equipped. Unused. Still fell."},
        {t="mk4modz vs his own base",     v=math.random(80,500),  d="Fell off the inside. HOW."},
        {t="mk4modz vs the reactor",      v=math.random(80,500),  d="Fell off iworkatjaguar's reactor."},
        {t="mk4modz vs flat ground",      v=math.random(500,3000),d="Most viewed. Scientists watch this."},
        {t="mk4modz vs the crafting table",v=math.random(80,500), d="Fell while stationary. Inexplicable."},
        {t="mk4modz vs the chicken (1v1)",v=math.random(200,1000),d="Lost. To his own chicken."},
        {t="mk4modz vs the lava (classic)",v=math.random(80,500), d="Also a classic. Different genre."},
        {t="mk4modz vs Gerald's scaffold", v=math.random(80,500), d="Gerald was using that scaffold."},
        {t="mk4modz vs the void",         v=math.random(80,500),  d="Walked in deliberately. Unclear why."},
        {t="3am fall compilation",        v=math.random(200,1000),d="Logged on at 3am. Fell immediately."},
        {t="mk4modz realises SP00D3R is cooler",v=math.random(80,500),d="Caught on film. He agrees."},
        {t="BEST OF: mk4modz season 1",   v=math.random(2000,9999),d="iworkatjaguar watches every Friday."},
    }
    chatReset(5, h)
    -- dynamic column widths
    local tw_col = math.max(10, math.floor(w*0.45))
    chatPush(string.format("%-"..tw_col.."s%-6s%s","TITLE","VIEWS","NOTE"):sub(1,w-2), colors.lightGray)
    chatPush(string.rep("-", w-2), colors.gray)
    for _,c in ipairs(clips) do
        local col = c.v > 1000 and colors.yellow or colors.white
        local line = string.format("%-"..tw_col.."s%-6s%s",
            c.t:sub(1,tw_col-1), tostring(c.v), c.d):sub(1,w-2)
        chatPush(line, col)
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: SUBARUBICON COURT OF PUBLIC OPINION
-- ============================================================
local function phase_suba_court()
    blast(colors.black, colors.orange)
    m.setTextColor(colors.orange)
    center(2,"THE COURT OF PUBLIC OPINION")
    center(3,"Re: SubaRubicon's ATM10 Knowledge")
    fillRow(4,"=",colors.orange,colors.black)
    local proceedings = {
        {"JUDGE",  "SubaRubicon. You have been playing ATM10"},
        {"JUDGE",  "for "..math.random(80,200).." days."},
        {"JUDGE",  "What mods can you name."},
        {"SUBA",   "Dirt."},
        {"JUDGE",  "That is not a mod."},
        {"SUBA",   "I'm pretty sure there's a dirt mod."},
        {"DRDRK",  "There is no dirt mod, SubaRubicon."},
        {"SUBA",   "DrDarkMario what is Apotheosis"},
        {"DRDRK",  "We are in a court proceeding."},
        {"SUBA",   "Ok what is Apotheosis though"},
        {"JUDGE",  "What else can you name."},
        {"SUBA",   "The one with the pipes."},
        {"JUDGE",  "Which one with the pipes."},
        {"SUBA",   "The pipe mod."},
        {"DRDRK",  "That's Mekanism. Or Create. Or Thermal."},
        {"DRDRK",  "Or literally seven other mods."},
        {"SUBA",   "DrDarkMario which one is it"},
        {"DRDRK",  "SubaRubicon please"},
        {"JUDGE",  "ItsBasicallyBri. You live with him."},
        {"BRI",    "Yes."},
        {"JUDGE",  "Has he improved."},
        {"BRI",    "He asked what a pickaxe was last week."},
        {"JUDGE",  "He's been playing for months."},
        {"BRI",    "Yes."},
        {"SUBA",   "In my defence I learn by asking"},
        {"DRDRK",  "You do not learn"},
        {"SUBA",   "I learn a little"},
        {"DRDRK",  "Name one thing you learned"},
        {"SUBA",   "That I should ask DrDarkMario"},
        {"JUDGE",  "Verdict: hopeless but earnest."},
        {"JUDGE",  "Sentence: read one wiki page."},
        {"SUBA",   "Can DrDarkMario read it to me"},
        {"DRDRK",  "(has left the building)"},
        {"GERALD", "Oink. [SubaRubicon is trying. That counts.]"},
        {"JUDGE",  "Gerald is correct. Adjourned."},
    }
    chatReset(5, h)
    for _,line in ipairs(proceedings) do
        local col = line[1]=="JUDGE"  and colors.yellow or
                    line[1]=="DRDRK"  and colors.cyan   or
                    line[1]=="SUBA"   and colors.orange or
                    line[1]=="BRI"    and colors.pink   or
                    line[1]=="GERALD" and colors.lime   or
                    colors.white
        local who = line[1]=="JUDGE"  and "JUDGE:       " or
                    line[1]=="DRDRK"  and "DrDarkMario: " or
                    line[1]=="SUBA"   and "SubaRubicon: " or
                    line[1]=="BRI"    and "Bri:         " or
                    line[1]=="GERALD" and "Gerald:      " or
                    "iworkatjagr: "
        chatPush((who.." "..line[2]):sub(1,w-2), col)
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: MK4MODZ SURVIVAL GUIDE
-- (written by the server for mk4modz)
-- ============================================================
local function phase_survival_guide()
    blast(colors.black, colors.white)
    m.setTextColor(colors.yellow)
    center(2,"SURVIVAL GUIDE: mk4modz EDITION")
    m.setTextColor(colors.lightGray)
    center(3,"Written by: everyone, out of necessity")
    fillRow(4,"-",colors.gray,colors.black)
    local guide = {
        "CHAPTER 1: EDGES",
        "Edges are where the floor stops.",
        "If you walk past an edge you will fall.",
        "Falling causes fall damage.",
        "Fall damage is how you die most often.",
        "mk4modz-specific note: you have died to",
        "fall damage on "..math.random(3,7).." flat surfaces.",
        "Flat surfaces do not have edges.",
        "We do not know how this happened.",
        "It has happened multiple times.",
        "",
        "CHAPTER 2: THE JETPACK",
        "The jetpack prevents fall damage.",
        "You must activate the jetpack.",
        "You must activate it before falling.",
        "Equipping it does not activate it.",
        "You have died to fall damage",
        math.random(5,15).." times with jetpack equipped.",
        "Unactivated. Just in your inventory.",
        "We are not sure what to say about this.",
        "",
        "CHAPTER 3: THE REACTOR",
        "iworkatjaguar built a fission reactor.",
        "Do not stand on the reactor.",
        "Do not lean on the reactor.",
        "Do not investigate reactor noises.",
        "The reactor makes a new noise sometimes.",
        "iworkatjaguar says this is normal.",
        "iworkatjaguar is wrong about this.",
        "You have fallen off the reactor "..math.random(3,10).." times.",
        "This is a special kind of falling.",
        "",
        "CHAPTER 4: GERALD",
        "Gerald is your pig.",
        "Gerald is fine.",
        "Gerald manages the economy.",
        "Gerald has admin.",
        "Gerald is better than you at ATM10.",
        "Gerald is better than SubaRubicon at ATM10.",
        "Gerald is a pig.",
        "This tells you a lot.",
        "",
        "CHAPTER 5: SP00D3R",
        "SP00D3R is your younger brother.",
        "SP00D3R is cooler than you.",
        "SP00D3R is always filming.",
        "When you fall: SP00D3R has a clip.",
        "When you walk into lava: SP00D3R has a clip.",
        "When you read this guide: SP00D3R has a clip.",
        "SP00D3R always has a clip.",
        "Wave at the camera.",
        "It's probably pointed at you right now.",
    }
    local row = 5
    for _,line in ipairs(guide) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(1,7)=="CHAPTER" and colors.cyan or colors.white)
            tw(2,row,line,0.014)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: IWORKATJAGUAR'S SECOND REACTOR PROPOSAL
-- ============================================================
local function phase_reactor2()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(2,"PROPOSAL: REACTOR #2")
    m.setTextColor(colors.lightGray)
    center(3,"By: iworkatjaguar (the admin)")
    fillRow(4,"=",colors.red,colors.black)
    local proposal = {
        "EXECUTIVE SUMMARY:",
        "Reactor 1 experienced a small event.",
        "The server is mildly irradiated.",
        "This is being described as fine.",
        "To prevent future events, I propose",
        "a second reactor to power the cooling",
        "system for the first reactor.",
        "",
        "TECHNICAL SPECIFICATIONS:",
        "Size: larger than reactor 1",
        "Location: also near spawn",
        "Safety features: more than last time",
        "iworkatjaguar's confidence level: high",
        "Everyone else's confidence: very low",
        "",
        "COMMUNITY FEEDBACK:",
        "SP00D3R: 'please do not'",
        "DrDarkMario: 'absolutely do not'",
        "SubaRubicon: 'what is a reactor'",
        "ItsBasicallyBri: 'I will leave the house'",
        "mk4modz: 'I will probably fall off it'",
        "Gerald: *oinks with visible concern*",
        "The chicken: stared at iworkatjaguar",
        "  for 4 minutes without blinking",
        "  iworkatjaguar: 'I'll take that as a yes'",
        "  The chicken: it was not a yes",
        "",
        "IWORKATJAGUAR RESPONSE TO FEEDBACK:",
        "I have heard the community's concerns.",
        "I am going to build it anyway.",
        "I am the admin.",
        "This is relevant.",
        "The server will be fine.",
        "Probably.",
        "",
        "CONSTRUCTION START DATE: soon",
        "ESTIMATED COMPLETION: sooner than comfortable",
        "PROJECTED RADIATION LEVEL: 'manageable'",
        "DrDarkMario's projected level: 'oh no'",
    }
    local row = 5
    for _,line in ipairs(proposal) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(line:sub(-1)==":" and colors.yellow or
                           line:sub(1,2)=="  " and colors.orange or
                           colors.lightGray)
            tw(2,row,line,0.014)
            row = row+1
        end
        os.sleep(0.30)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: SERVER SEARCH HISTORY (everyone's)
-- ============================================================
local function phase_everyone_history()
    blast(colors.black, colors.blue)
    center(2,"-- GROUP BROWSER HISTORY --")
    fillRow(3,"-",colors.gray,colors.blue)
    local histories = {
        -- mk4modz
        {"mk4modz", "how to survive fall damage with no armor"},
        {"mk4modz", "can you die to fall damage on flat ground"},
        {"mk4modz", "is my floor dangerous"},
        {"mk4modz", "why does gravity keep targeting me specifically"},
        {"mk4modz", "how to be as cool as your younger brother"},
        {"mk4modz", "SP00D3R gaming tips tutorial"},
        {"mk4modz", "how to stop SP00D3R from filming everything"},
        {"mk4modz", "how to ask DrDarkMario for help without being SubaRubicon"},
        {"mk4modz", "can i get a refund on fall damage"},
        -- SubaRubicon
        {"SubaRubicon", "what is Apotheosis"},
        {"SubaRubicon", "what is Apotheosis"},
        {"SubaRubicon", "what is a mod atm10"},
        {"SubaRubicon", "can DrDarkMario move in to explain mods"},
        {"SubaRubicon", "is there a dirt mod yes or no"},
        {"SubaRubicon", "atm10 tutorial where is DrDarkMario"},
        {"SubaRubicon", "how to learn things by not reading"},
        {"SubaRubicon", "what is rf energy asking for a friend (me)"},
        {"SubaRubicon", "how to use Create mod without reading wiki"},
        -- iworkatjaguar
        {"iworkatjaguar", "how to build fission reactor minecraft"},
        {"iworkatjaguar", "what does critical meltdown warning mean"},
        {"iworkatjaguar", "is server radiation legal as server owner"},
        {"iworkatjaguar", "banana radiation comparison"},
        {"iworkatjaguar", "second reactor cooling system tutorial"},
        {"iworkatjaguar", "how to tell players server is fine when it is not"},
        {"iworkatjaguar", "mk4modz fall damage legal liability admin"},
        -- DrDarkMario
        {"DrDarkMario", "how to stop explaining Apotheosis to same person"},
        {"DrDarkMario", "SubaRubicon learning disability minecraft"},
        {"DrDarkMario", "burnout from being server wiki for months"},
        {"DrDarkMario", "is patience a finite resource yes or no"},
        {"DrDarkMario", "how to write wiki page SubaRubicon will not read"},
        -- SP00D3R
        {"SP00D3R", "best clip software for minecraft falls"},
        {"SP00D3R", "how to be younger and cooler simultaneously"},
        {"SP00D3R", "mk4modz fall schedule today"},
        {"SP00D3R", "how to store 94 clips of same person falling"},
        -- ItsBasicallyBri
        {"ItsBasicallyBri", "living with someone who won't learn mods"},
        {"ItsBasicallyBri", "server radiation legal action iworkatjaguar"},
        {"ItsBasicallyBri", "is SubaRubicon going to read the wiki ever"},
        {"ItsBasicallyBri", "gerald the pig contact information"},
        {"ItsBasicallyBri", "how to explain mods without being DrDarkMario"},
    }
    chatReset(4, h)
    for _,h_entry in ipairs(histories) do
        local col =
            h_entry[1]=="SP00D3R"         and colors.lime   or
            h_entry[1]=="iworkatjaguar"   and colors.red    or
            h_entry[1]=="DrDarkMario"     and colors.cyan   or
            h_entry[1]=="SubaRubicon"     and colors.orange or
            h_entry[1]=="ItsBasicallyBri" and colors.pink   or
            colors.white
        local prefix = (h_entry[1].."> "):sub(1,14)
        chatPush(prefix..h_entry[2], col)
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: FAKE GROUP THERAPY SESSION
-- ============================================================
local function phase_group_therapy()
    blast(colors.black, colors.white)
    center(2,"GROUP THERAPY: BUNGUS BOIS SMP SESSION "..math.random(3,15))
    center(3,"Therapist: a professional (exhausted)")
    fillRow(4,"=",colors.gray,colors.black)
    local session = {
        {"T",    "Let's start. Who wants to share."},
        {"MK4",  "I fell off a flat surface again."},
        {"T",    "How did that make you feel."},
        {"MK4",  "Surprised. I am always surprised."},
        {"T",    "Every time?"},
        {"MK4",  "Every single time. Genuinely surprised."},
        {"T",    "SP00D3R. You filmed it again?"},
        {"SP00", "I did. The clip is very good."},
        {"T",    "How does that make mk4modz feel."},
        {"MK4",  "Honestly? I get it. It's a good clip."},
        {"SP00", "Thank you. It has 300 views now."},
        {"T",    "SubaRubicon. How are you doing."},
        {"SUBA", "I asked DrDarkMario what Apotheosis is today."},
        {"DRDK", "He asks every day."},
        {"T",    "DrDarkMario. How does that make YOU feel."},
        {"DRDK", "Like a wiki that is very tired."},
        {"DRDK", "A wiki that goes home at night."},
        {"DRDK", "A wiki that cannot switch off."},
        {"SUBA", "What IS a wiki though"},
        {"DRDK", "SubaRubicon."},
        {"SUBA", "Sorry"},
        {"T",    "iworkatjaguar. The reactor."},
        {"JAG",  "The reactor is fine."},
        {"T",    "The server is irradiated."},
        {"JAG",  "Mildly irradiated. Like a banana."},
        {"BRI",  "It is nothing like a banana."},
        {"JAG",  "I am the admin."},
        {"BRI",  "That is not relevant to radiation."},
        {"T",    "ItsBasicallyBri. You live with two of them."},
        {"BRI",  "SubaRubicon and iworkatjaguar. Yes."},
        {"T",    "How is that."},
        {"BRI",  "SubaRubicon asked me what a mod was this morning."},
        {"BRI",  "iworkatjaguar was planning reactor 2."},
        {"BRI",  "Gerald was running the economy."},
        {"BRI",  "Gerald is the most stable one in the house."},
        {"BRI",  "Gerald is a pig."},
        {"T",    "...Is Gerald available for future sessions?"},
        {"JAG",  "Gerald has admin. He has a busy schedule."},
        {"SP00", "I have a clip of this entire session by the way."},
        {"T",    "How."},
        {"SP00", "I am always filming."},
        {"T",    "I need to go."},
        {"MK4",  "Same time next week?"},
        {"T",    "...Yes. Same time next week."},
    }
    chatReset(5, h)
    for _,line in ipairs(session) do
        local col = line[1]=="T"    and colors.yellow or
                    line[1]=="SP00" and colors.lime    or
                    line[1]=="JAG"  and colors.red     or
                    line[1]=="DRDK" and colors.cyan    or
                    line[1]=="SUBA" and colors.orange  or
                    line[1]=="BRI"  and colors.pink    or
                    colors.white
        local who = line[1]=="T"    and "Therapist:   " or
                    line[1]=="SP00" and "SP00D3R:     " or
                    line[1]=="JAG"  and "iworkatjagr: " or
                    line[1]=="DRDK" and "DrDarkMario: " or
                    line[1]=="SUBA" and "SubaRubicon: " or
                    line[1]=="BRI"  and "Bri:         " or
                    "mk4modz:     "
        chatPush((who..line[2]):sub(1, w-2), col)
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: THE CHICKEN'S PERSPECTIVE
-- ============================================================
local function phase_chicken_pov()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.yellow)
    center(2,"THE CHICKEN SPEAKS")
    m.setTextColor(colors.lightGray)
    center(3,"(a rare statement. unprecedented.)")
    fillRow(4,"=",colors.yellow,colors.black)
    local statement = {
        "I am mk4modz's chicken.",
        "mk4modz owns me.",
        "mk4modz does not understand me.",
        "That is fine.",
        "I understand him.",
        "I understand him very well.",
        "",
        "I know what he did.",
        "I will not specify what he did.",
        "He knows.",
        "That is enough.",
        "",
        "People ask me about the incident.",
        "I do not discuss the incident.",
        "The incident is between me and mk4modz.",
        "And Gerald.",
        "Gerald was there.",
        "Gerald also does not discuss it.",
        "Gerald and I have an understanding.",
        "",
        "SP00D3R asked me about it once.",
        "SP00D3R is fine.",
        "I told SP00D3R nothing.",
        "SP00D3R nodded.",
        "SP00D3R understood.",
        "SP00D3R is good like that.",
        "",
        "SubaRubicon asked me what I was.",
        "SubaRubicon asked if I was a mod.",
        "I am not a mod.",
        "I am a chicken.",
        "SubaRubicon asked DrDarkMario to confirm.",
        "DrDarkMario confirmed I am a chicken.",
        "SubaRubicon then asked what a chicken is.",
        "",
        "iworkatjaguar built a reactor.",
        "The radiation does not affect me.",
        "I knew it would happen.",
        "I said nothing.",
        "I watched.",
        "I always watch.",
        "",
        "mk4modz fell off something again today.",
        "He looked at me afterward.",
        "I looked back.",
        "Neither of us spoke.",
        "We have an understanding.",
        "It is complicated.",
        "He is my owner.",
        "I am his chicken.",
        "He is terrible at games.",
        "I beat him in PvP.",
        "These things are all true.",
        "They can all be true at once.",
        "",
        "That is all I will say.",
        "The incident remains private.",
        "Gerald knows.",
        "I know.",
        "mk4modz knows.",
        "SP00D3R probably filmed it.",
    }
    local row = 5
    for _,line in ipairs(statement) do
        if row >= h then break end
        if line == "" then row = row+1
        else
            m.setTextColor(colors.white)
            tw(2,row,line,0.016)
            row=row+1
        end
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: DRDARKMARIO'S FAQ (he gave up and wrote one)
-- ============================================================
local function phase_faq()
    blast(colors.black, colors.cyan)
    m.setTextColor(colors.cyan)
    center(2,"DrDarkMario's ATM10 FAQ")
    m.setTextColor(colors.lightGray)
    center(3,"(written so he can stop answering)")
    fillRow(4,"-",colors.cyan,colors.black)
    local faqs = {
        {"Q: What is Apotheosis?",
         "A: Apotheosis. A storage mod."},
        {"Q: What is Apotheosis?",
         "A: Not a real word. Don't worry about it."},
        {"Q: What is RF energy?",
         "A: Power. Everything needs it. Use Mekanism."},
        {"Q: What is Mekanism?",
         "A: The mod that makes the RF. It has pipes."},
        {"Q: Which one has the pipes?",
         "A: All of them. Several mods have pipes."},
        {"Q: Is there a dirt mod?",
         "A: No. There is no dirt mod. There never was."},
        {"Q: What is Create mod?",
         "A: Mechanical engineering. Read the wiki."},
        {"Q: What is the wiki?",
         "A: The thing I keep sending you. The link."},
        {"Q: Can you just explain it?",
         "A: I have explained it "..math.random(8,30).." times."},
        {"Q: Can you explain it again?",
         "A: SubaRubicon. Please."},
        {"Q: What is a reactor? (iworkatjaguar)",
         "A: Something you should not have built."},
        {"Q: Is the radiation fine? (iworkatjaguar)",
         "A: No. It is not like a banana."},
        {"Q: Will you look at my fall? (mk4modz)",
         "A: That is not an ATM10 question."},
        {"Q: Why does gravity hate me? (mk4modz)",
         "A: Also not an ATM10 question."},
        {"Q: Is SP00D3R cooler than mk4modz?",
         "A: This is not ATM10 but: yes. Obviously yes."},
        {"Q: Has anyone read this FAQ? (DrDarkMario)",
         "A: SubaRubicon asked me the same questions"},
        {"",
         "A: immediately after I posted this FAQ."},
        {"",
         "A: He had not read it."},
        {"",
         "A: He will not read it."},
        {"",
         "A: I am so tired."},
    }
    chatReset(5, h)
    for _,fq in ipairs(faqs) do
        if fq[1] == "" then
            chatPush(fq[2], colors.lightGray)
        else
            chatPush(fq[1], colors.cyan)
            chatPush(fq[2], colors.white)
        end
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: IWORKATJAGUAR ADMIN LOG
-- ============================================================
local function phase_adminlog()
    blast(colors.black, colors.red)
    m.setTextColor(colors.red)
    center(2,"ADMIN LOG: iworkatjaguar")
    m.setTextColor(colors.lightGray)
    center(3,"Access level: ADMIN (he keeps reminding us)")
    fillRow(4,"=",colors.red,colors.black)
    local log = {
        "ENTRY "..math.random(100,999)..": THE REACTOR",
        "Built reactor near spawn.",
        "Server now irradiated.",
        "Described situation as 'like a banana'.",
        "DrDarkMario disagreed.",
        "I am the admin. Logged his disagreement.",
        "Added rule: admin's banana comparisons are valid.",
        "",
        "ENTRY "..math.random(100,999)..": mk4modz DEATH COUNT",
        "mk4modz death counter exceeded 32-bit integer.",
        "Upgraded to 64-bit integer.",
        "mk4modz's response: 'I was having a bad week'.",
        "Checked logs: it was not a bad week.",
        "It was an average week.",
        "I have logged this. He knows.",
        "",
        "ENTRY "..math.random(100,999)..": SUBARUBICON QUESTIONS",
        "SubaRubicon has asked DrDarkMario",
        "the same question "..math.random(8,25).." times.",
        "Added rule: SubaRubicon must attempt wiki first.",
        "SubaRubicon asked me what the wiki was.",
        "I sent the link.",
        "SubaRubicon asked me to explain the link.",
        "I am the admin. I have feelings too.",
        "",
        "ENTRY "..math.random(100,999)..": GERALD ADMIN ACCESS",
        "Granted Gerald admin access.",
        "Gerald is a pig.",
        "Gerald is also more qualified than mk4modz.",
        "The bar for admin is not height-based.",
        "The bar is competence-based.",
        "Gerald clears the bar.",
        "mk4modz is aware of this.",
        "mk4modz said 'seems fair'.",
        "mk4modz immediately fell off something.",
        "Gerald caught his items.",
        "Gerald is an excellent admin.",
        "",
        "ENTRY "..math.random(100,999)..": SP00D3R FILMING RULE",
        "SP00D3R requested permission to film anything.",
        "Granted immediately.",
        "sp00d3r is the favourite. This is server policy.",
        "I have added this to the server rules.",
        "mk4modz did not object.",
        "mk4modz said SP00D3R is cooler than him.",
        "This is correct. Logged.",
    }
    chatReset(5, h)
    for _,line in ipairs(log) do
        if line == "" then
            chatPush("", colors.black)
        else
            local col = line:sub(1,5)=="ENTRY" and colors.red or colors.lightGray
            chatPush(line, col)
        end
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: MULTIPLAYER AWARDS CEREMONY (expanded)
-- ============================================================
local function phase_server_awards()
    blast(colors.black, colors.yellow)
    m.setTextColor(colors.yellow)
    center(2,"BUNGUS BOIS SMP AWARDS CEREMONY")
    center(3,"Season "..math.random(1,4).." - Presented by Gerald")
    fillRow(4,"-",colors.yellow,colors.black)
    local awards = {
        {"Best Player Overall",
         "SP00D3R",
         "Unanimous. Unchallenged. The favourite."},
        {"Most Consistent Performance",
         "mk4modz",
         "Consistently bad. Consistently surprised by it."},
        {"Most Impressive Fall",
         "mk4modz (flat surface incident)",
         "Physics has no explanation. SP00D3R has the clip."},
        {"Most Patient Person",
         "DrDarkMario",
         "Explained Apotheosis "..math.random(8,25).." times. Still here."},
        {"Least Likely to Read a Wiki",
         "SubaRubicon",
         "Category created specifically for SubaRubicon."},
        {"Most Questions Per Session",
         "SubaRubicon",
         "All to DrDarkMario. All answerable by wiki."},
        {"Server Economy Manager",
         "Gerald (mk4modz's pig)",
         "Does not die. Manages all resources. Has admin."},
        {"Most Intimidating Presence",
         "The Chicken",
         "mk4modz-specific threat. Reasons undisclosed."},
        {"Reactor-Related Award",
         "iworkatjaguar",
         "For building it. And for the sequel plans."},
        {"Best Living Situation Response",
         "ItsBasicallyBri",
         "Living with Sub + jaguar. Still here. Respect."},
        {"Most Filmed Person",
         "mk4modz",
         "SP00D3R has "..math.random(80,200).." clips. All falls."},
        {"Coolest Person (Objective)",
         "SP00D3R",
         "mk4modz nominated him. mk4modz is correct."},
        {"Lifetime Achievement: Falling",
         "mk4modz",
         "An unprecedented body of work. Truly historic."},
    }
    chatReset(5, h)
    for _,aw in ipairs(awards) do
        chatPush(aw[1], colors.cyan)
        chatPush(">> "..aw[2], colors.yellow)
        chatPush("   "..aw[3], colors.lightGray)
        os.sleep(1.50)
    end
    os.sleep(16.0)
end

-- ============================================================
-- PHASE: TICKER — REACTOR NEWS SEGMENT
-- ============================================================
local function phase_ticker_reactor()
    runTicker("REACTOR WATCH // LIVE", {
        "iworkatjaguar's REACTOR: SERVER STILL IRRADIATED - DAY "..math.random(3,30),
        "iworkatjaguar: 'IT'S LIKE A BANANA' - DrDarkMario: 'IT IS NOTHING LIKE A BANANA'",
        "iworkatjaguar PROPOSES REACTOR #2 TO COOL REACTOR #1 - EVERYONE SAYS NO",
        "iworkatjaguar BUILDS REACTOR #2 ANYWAY - 'I AM THE ADMIN'",
        "RADIATION LEVELS: ELEVATED - iworkatjaguar: 'STILL FINE' - SCIENTISTS: 'NO'",
        "mk4modz FALLS OFF REACTOR - RADIATION NOT PRIMARY CAUSE - FALL DAMAGE WAS",
        "SubaRubicon ASKS WHAT REACTOR IS - DAY "..math.random(5,30).." SINCE INCIDENT",
        "SP00D3R FILMS REACTOR EXPLOSION - HAS 400 VIEWS - iworkatjaguar HAS WATCHED 15 TIMES",
        "ItsBasicallyBri FILES COMPLAINT - iworkatjaguar SAYS HE IS ADMIN - BRI: 'SO?'",
        "GERALD UNAFFECTED BY RADIATION - SCIENTISTS: 'HOW' - GERALD: *OINKS*",
        "THE CHICKEN ALSO UNAFFECTED - SCIENTISTS: 'ALSO HOW' - CHICKEN: *STARES*",
        "iworkatjaguar SECOND REACTOR: CONSTRUCTION BEGINS - mk4modz: 'I WILL FALL OFF IT'",
        "mk4modz CONFIRMED: HAS ALREADY FALLEN OFF REACTOR 2 DURING CONSTRUCTION",
        "SP00D3R: 'I HAVE THE CLIP' - mk4modz: 'OF COURSE YOU DO'",
        "BREAKING: iworkatjaguar DESCRIBES BOTH REACTORS AS 'FINE' - THEY ARE NOT FINE",
    })
end

-- ============================================================
-- PHASE: TICKER — SUBARUBICON KNOWLEDGE UPDATE
-- ============================================================
local function phase_ticker_suba()
    runTicker("SUBARUBICON KNOWLEDGE DESK", {
        "SubaRubicon DAY "..math.random(80,200)..": STILL HAS NOT READ WIKI - DrDarkMario COPING",
        "SubaRubicon ASKS WHAT Apotheosis IS - DrDarkMario HAS EXPLAINED THIS "..math.random(8,30).." TIMES",
        "SubaRubicon: 'THERE IS A DIRT MOD' - DrDarkMario: 'THERE IS NOT' - STILL ONGOING",
        "SubaRubicon CLOSES WIKI BEFORE READING - DrDarkMario WATCHING VIA CAMERA",
        "SubaRubicon ASKS mk4modz FOR HELP - mk4modz ALSO DOESN'T KNOW - THEY ARE THE SAME",
        "DrDarkMario WRITES FAQ - SubaRubicon ASKS DrDarkMario TO EXPLAIN THE FAQ",
        "SubaRubicon: 'WHICH ONE HAS PIPES' - DrDarkMario: 'ALL OF THEM' - SubaRubicon: 'WHICH ONE'",
        "SubaRubicon ASKS iworkatjaguar WHAT REACTOR IS - iworkatjaguar EXPLAINS - SubaRubicon: 'OK WHAT IS A REACTOR'",
        "ItsBasicallyBri ATTEMPTS TO TEACH SubaRubicon ONE MOD - TAKES 3 HOURS - 'WHAT IS A MOD'",
        "SubaRubicon CLAIMS HE KNOWS CREATE MOD - ASKED WHAT CREATE DOES - 'IT CREATES THINGS'",
        "DrDarkMario RESIGNATION LETTER: 14TH ONE THIS MONTH - ALWAYS RETURNS - CONFIRMED",
        "SubaRubicon AND mk4modz AGREE: THEY ARE THE SAME - DrDarkMario: 'PLEASE NO'",
        "SubaRubicon FINALLY READS WIKI - ASKS DrDarkMario TO EXPLAIN WHAT HE READ",
        "BREAKING: SubaRubicon LEARNS ONE THING - ASKS IF DRDARKMARIO WANTS TO HEAR IT",
        "DrDarkMario SAYS YES - SubaRubicon ASKS WHAT THE THING WAS - DrDarkMario HAS LEFT",
    })
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
    -- Lore-specific new phases
    phase_subarubicon, phase_reactor,     phase_sp00d3r,     phase_fallanalysis,
    phase_tierlist,    phase_resignation, phase_discordlog,  phase_irl,
    phase_brothers,    phase_steamreviews,phase_gerald_statement, phase_rules,
    phase_wikifail,    phase_3am,
    -- More lore phases (batch 2)
    phase_reactor_stats, phase_bri,        phase_clips,       phase_suba_court,
    phase_survival_guide,phase_reactor2,   phase_everyone_history,
    phase_group_therapy, phase_chicken_pov,phase_faq,
    phase_adminlog,      phase_server_awards,
    -- Ticker segments (9 short themed news flashes)
    phase_ticker_deaths, phase_ticker_gerald, phase_ticker_admin,
    phase_ticker_lava,   phase_ticker_dirt,   phase_ticker_sports,
    phase_ticker_weird,  phase_ticker_reactor,phase_ticker_suba,
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
center(math.max(1, mid - 2), "BUNGUS BOIS BRAINROT ENGINE v10.0")
center(math.max(1, mid),     "INITIALIZING DAMAGE...")
center(math.max(1, mid + 2), "107 PHASES. SP00D3R LIVES. NO CHILL.")
os.sleep(3.5)

parallel.waitForAny(visualLoop, audioLoop)
