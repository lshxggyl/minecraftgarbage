-- ============================================================
--  TOUCH BLACKJACK for ComputerCraft
--  Optimized for 2x3 Portrait Monitors
-- ============================================================

local mon = peripheral.find("monitor")
if not mon then
    error("No monitor found! Slap an advanced monitor next to this computer.")
end

-- Set scale for portrait and redirect output
mon.setTextScale(0.5)
term.redirect(mon)

local w, h = term.getSize()
local isColor = term.isColor()

-- ── Colour palette ────────────
local C = {
  bg        = isColor and colors.green    or colors.black,
  felt      = isColor and colors.green    or colors.black,
  header    = isColor and colors.lime     or colors.white,
  text      = isColor and colors.white    or colors.white,
  dim       = isColor and colors.gray     or colors.gray,
  card_bg   = isColor and colors.white    or colors.white,
  card_fg   = isColor and colors.black    or colors.black,
  red_suit  = isColor and colors.red      or colors.white,
  black_suit= isColor and colors.black    or colors.black,
  gold      = isColor and colors.yellow   or colors.white,
  btn_bg    = isColor and colors.blue     or colors.black,
  btn_fg    = isColor and colors.white    or colors.white,
  bust      = isColor and colors.red      or colors.white,
  win       = isColor and colors.lime     or colors.white,
  push      = isColor and colors.yellow   or colors.white,
}

local SUITS  = { "\3", "\4", "\5", "\6" }
local RANKS  = { "A","2","3","4","5","6","7","8","9","10","J","Q","K" }
local RED    = { ["\3"]=true, ["\4"]=true }

local function newDeck(numDecks)
  local deck = {}
  for _=1, (numDecks or 1) do
    for _, s in ipairs(SUITS) do
      for _, r in ipairs(RANKS) do
        deck[#deck+1] = { rank=r, suit=s }
      end
    end
  end
  return deck
end

local function shuffle(deck)
  for i = #deck, 2, -1 do
    local j = math.random(i)
    deck[i], deck[j] = deck[j], deck[i]
  end
end

local function cardValue(rank)
  if rank == "A" then return 11 end
  if rank == "J" or rank == "Q" or rank == "K" then return 10 end
  return tonumber(rank)
end

local function handTotal(hand)
  local total, aces = 0, 0
  for _, c in ipairs(hand) do
    total = total + cardValue(c.rank)
    if c.rank == "A" then aces = aces + 1 end
  end
  while total > 21 and aces > 0 do
    total = total - 10
    aces  = aces - 1
  end
  return total
end

-- ── Drawing helpers ────────────
local function cls()
  term.setBackgroundColor(C.bg)
  term.clear()
end

local function at(x, y) term.setCursorPos(x, y) end

local function write(text, fg, bg)
  if fg then term.setTextColor(fg) end
  if bg then term.setBackgroundColor(bg) end
  term.write(text)
end

local function centre(text, y, fg, bg)
  local x = math.floor((w - #text) / 2) + 1
  at(x, y)
  write(text, fg, bg)
end

local function drawCard(x, y, card, hidden)
  local bw, bh = 5, 3
  if hidden then
    for row = 0, bh-1 do
      at(x, y+row)
      write(string.rep(row==0 and "\127" or (row==bh-1 and "\127" or "|"), bw), colors.blue, colors.blue)
    end
    return
  end

  local fg  = RED[card.suit] and C.red_suit or C.black_suit
  local rl  = card.rank
  local pad = #rl == 1 and " " or ""

  at(x, y)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x, y); write(rl .. pad, fg, C.card_bg)

  at(x, y+1)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x + math.floor(bw/2), y+1); write(card.suit, fg, C.card_bg)

  at(x, y+2)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x + bw - #rl - 1, y+2); write(pad .. rl, fg, C.card_bg)
end

local function drawHand(hand, sx, sy, hideFirst, animateIndex)
  for i, card in ipairs(hand) do
    local hidden = (i == 1 and hideFirst)
    -- Only draw up to the animateIndex if provided
    if not animateIndex or i <= animateIndex then
      drawCard(sx + ((i-1)%4)*6, sy + math.floor((i-1)/4)*4, card, hidden)
    end
  end
end

-- ── Touch/Input Handler ────────────
local function getAction(zones, keyMap)
  while true do
    local ev, p1, p2, p3 = os.pullEvent()
    if ev == "monitor_touch" then
      for _, z in ipairs(zones) do
        if p2 >= z.x and p2 < z.x + z.w and p3 >= z.y and p3 < z.y + z.h then
          return z.action
        end
      end
    elseif ev == "key" and keyMap and keyMap[p1] then
      return keyMap[p1]
    end
  end
end

-- ── HUD & Buttons ────────────
local function drawHUD(chips, bet)
  at(1, 1); term.setBackgroundColor(C.bg); term.clearLine()
  write(" \4 BLACKJACK \4 ", C.gold, C.bg)
  local chipStr = "$" .. chips
  at(w - #chipStr, 1); write(chipStr, C.header, C.bg)
end

local function drawLabels(dealerTotal, playerTotal, hideDealer)
  at(2, 3); write("Dealer", C.dim, C.bg)
  if not hideDealer then
    local dColor = (type(dealerTotal) == "number" and dealerTotal > 21) and C.bust or C.text
    write(" (" .. dealerTotal .. ")", dColor, C.bg)
  end

  at(2, 14); write("You", C.dim, C.bg)
  local pColor = (type(playerTotal) == "number" and playerTotal > 21) and C.bust or C.text
  write(" (" .. playerTotal .. ")", pColor, C.bg)
end

local function drawButtons(buttons, y)
  local zones = {}
  local totalW = 0
  for _, b in ipairs(buttons) do totalW = totalW + #b.lbl + 4 end
  local sx = math.floor((w - totalW) / 2) + 1
  at(1, y); term.clearLine()
  at(1, y+1); term.clearLine()
  at(1, y+2); term.clearLine()
  
  for _, b in ipairs(buttons) do
    local lbl = " " .. b.lbl .. " "
    table.insert(zones, {x=sx, y=y, w=#lbl, h=3, action=b.act})
    
    at(sx, y);   write(string.rep(" ", #lbl), C.btn_fg, C.btn_bg)
    at(sx, y+1); write(lbl, C.btn_fg, C.btn_bg)
    at(sx, y+2); write(string.rep(" ", #lbl), C.btn_fg, C.btn_bg)
    sx = sx + #lbl + 2
  end
  return zones
end

local function banner(text, fg)
  centre(string.rep(" ", #text + 4), 11, fg, fg)
  centre("  " .. text .. "  ", 11, C.card_bg, fg)
end

-- ── Screens ────────────
local function betScreen(chips)
  cls()
  drawHUD(chips, 0)
  local bets = {10, 25, 50, 100}
  local chosen = 10
  
  while true do
    for row = 3, h do at(1,row); term.clearLine() end
    centre("Place Your Bet", 6, C.gold, C.bg)
    centre("Current: $" .. chosen, 8, C.text, C.bg)

    local zones = {}
    local bx = math.floor((w - (#bets * 6 - 1)) / 2) + 1
    for i, b in ipairs(bets) do
      local lbl = "$" .. b
      local bg = (b == chosen) and C.felt or C.btn_bg
      table.insert(zones, {x=bx, y=11, w=#lbl+2, h=3, action=b})
      at(bx, 11); write(string.rep(" ", #lbl+2), C.text, bg)
      at(bx, 12); write(" " .. lbl .. " ", C.text, bg)
      at(bx, 13); write(string.rep(" ", #lbl+2), C.text, bg)
      bx = bx + #lbl + 3
    end

    local dealZones = drawButtons({{lbl="DEAL", act="deal"}, {lbl="QUIT", act="quit"}}, 17)
    for _, z in ipairs(dealZones) do table.insert(zones, z) end

    if chips < chosen then centre("Not enough chips!", 21, C.bust, C.bg) end

    local act = getAction(zones, {[keys.enter]="deal", [keys.q]="quit"})
    if type(act) == "number" then chosen = act
    elseif act == "deal" and chips >= chosen then return chosen
    elseif act == "quit" then return nil end
  end
end

local function gameScreen(deck, chips, bet)
  local player = { table.remove(deck), table.remove(deck) }
  local dealer = { table.remove(deck), table.remove(deck) }

  local function redraw(hideDealer, extraMsg, extraFg)
    cls()
    drawHUD(chips, bet)
    drawHand(dealer, 2, 4, hideDealer)
    drawHand(player, 2, 15, false)
    local dt = hideDealer and cardValue(dealer[2].rank) or handTotal(dealer)
    drawLabels(dt, handTotal(player), hideDealer)
    if extraMsg then banner(extraMsg, extraFg or C.gold) end
  end

  -- Initial Deal Animation
  cls()
  drawHUD(chips, bet)
  drawLabels("?", "?", true)
  os.sleep(0.2)
  for i=1, 2 do
    player[i] = player[i] or table.remove(deck)
    drawHand(player, 2, 15, false, i)
    os.sleep(0.3)
    dealer[i] = dealer[i] or table.remove(deck)
    drawHand(dealer, 2, 4, true, i)
    os.sleep(0.3)
  end
  redraw(true)

  local playerBJ = handTotal(player) == 21
  local dealerBJ = handTotal(dealer) == 21

  local function waitEnd()
    local z = drawButtons({{lbl="NEXT HAND", act="next"}}, h-4)
    getAction(z, {[keys.enter]="next"})
  end

  if playerBJ or dealerBJ then
    -- Reveal animation
    redraw(false)
    if playerBJ and dealerBJ then
      banner("PUSH — Both Blackjack!", C.push)
    elseif playerBJ then
      banner("BLACKJACK! You win 3:2!", C.win)
      chips = chips + math.floor(bet * 1.5)
    else
      banner("Dealer Blackjack.", C.bust)
      chips = chips - bet
    end
    waitEnd(); return chips
  end

  local stood = false
  while not stood do
    redraw(true)
    local pt = handTotal(player)
    if pt > 21 then
      banner("BUST! You lose.", C.bust)
      chips = chips - bet
      waitEnd(); return chips
    end

    local canDouble = (#player == 2 and chips >= bet*2)
    local btns = { {lbl="HIT", act="h"}, {lbl="STAND", act="s"} }
    if canDouble then table.insert(btns, {lbl="DOUBLE", act="d"}) end

    local zones = drawButtons(btns, h-4)
    local act = getAction(zones, {[keys.h]="h", [keys.s]="s", [keys.d]="d"})

    if act == "h" then
      player[#player+1] = table.remove(deck)
      -- Hit animation
      redraw(true)
      os.sleep(0.2)
    elseif act == "s" then
      stood = true
    elseif act == "d" and canDouble then
      bet = bet * 2
      player[#player+1] = table.remove(deck)
      redraw(true)
      os.sleep(0.4)
      stood = true
    end
  end

  local pt = handTotal(player)
  if pt > 21 then
    redraw(false)
    banner("BUST! You lose.", C.bust)
    chips = chips - bet
    waitEnd(); return chips
  end

  -- Dealer Flip Animation
  redraw(false)
  os.sleep(0.6)

  while handTotal(dealer) < 17 do
    dealer[#dealer+1] = table.remove(deck)
    redraw(false)
    os.sleep(0.5)
  end

  local dt = handTotal(dealer)
  redraw(false)

  if dt > 21 then
    banner("Dealer Busts! WIN!", C.win)
    chips = chips + bet
  elseif pt > dt then
    banner("You WIN! (" .. pt .. " vs " .. dt .. ")", C.win)
    chips = chips + bet
  elseif pt == dt then
    banner("PUSH — Tie! (" .. pt .. ")", C.push)
  else
    banner("Dealer Wins (" .. dt .. " vs " .. pt .. ")", C.bust)
    chips = chips - bet
  end

  waitEnd()
  return chips
end

local function titleScreen()
  cls()
  centre("\4 BLACKJACK \4", 5, C.gold, C.bg)
  centre(string.rep("-", w-2), 7, C.felt, C.bg)
  centre("Beat the dealer to 21", 9, C.text, C.bg)
  centre(string.rep("-", w-2), 11, C.felt, C.bg)

  local zones = drawButtons({{lbl="START GAME", act="start"}, {lbl="QUIT", act="quit"}}, 15)
  local act = getAction(zones, {[keys.enter]="start", [keys.q]="quit"})
  return act == "start"
end

local function gameOver(chips)
  cls()
  centre("\4 GAME OVER \4", 5, C.bust, C.bg)
  if chips <= 0 then
    centre("You ran out of chips!", 8, C.text, C.bg)
  else
    centre("Cashed out with $" .. chips, 8, C.gold, C.bg)
  end

  local zones = drawButtons({{lbl="PLAY AGAIN", act="play"}, {lbl="QUIT", act="quit"}}, 12)
  local act = getAction(zones, {[keys.enter]="play", [keys.q]="quit"})
  return act == "play"
end

-- ── Main ────────────
math.randomseed(os.time())

while true do
  if not titleScreen() then break end

  local chips = 500
  local deck  = newDeck(4)
  shuffle(deck)

  while chips > 0 do
    if #deck < 20 then
      deck = newDeck(4); shuffle(deck)
    end

    local bet = betScreen(chips)
    if not bet then break end

    chips = gameScreen(deck, chips, bet)

    if chips <= 0 then
      if not gameOver(chips) then goto quit end
      chips = 500
      deck = newDeck(4); shuffle(deck)
    end
  end

  if chips > 0 then
    if not gameOver(chips) then break end
  end
end

::quit::
cls()
term.restore()
print("Thanks for playing.")
