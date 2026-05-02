-- ============================================================
--  BLACKJACK for ComputerCraft
--  Works on any CC terminal (pocket, standard, advanced)
-- ============================================================

local w, h = term.getSize()
local isColor = term.isColor()

-- ── Colour palette (gracefully degrades on mono) ────────────
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

-- ── Card data ────────────────────────────────────────────────
local SUITS  = { "\3", "\4", "\5", "\6" }   -- ♥ ♦ ♣ ♠ (CC chars)
local RANKS  = { "A","2","3","4","5","6","7","8","9","10","J","Q","K" }
local RED    = { ["\3"]=true, ["\4"]=true }

local function newDeck(numDecks)
  numDecks = numDecks or 1
  local deck = {}
  for _=1, numDecks do
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

-- ── Drawing helpers ──────────────────────────────────────────
local function cls()
  term.setBackgroundColor(C.bg)
  term.clear()
end

local function at(x, y)
  term.setCursorPos(x, y)
end

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

-- Draw a single card at (x,y).  hidden=true draws card back.
local function drawCard(x, y, card, hidden)
  local bw, bh = 5, 3   -- card box size

  if hidden then
    -- Card back
    for row = 0, bh-1 do
      at(x, y+row)
      write(string.rep(row==0 and "\127" or (row==bh-1 and "\127" or "|"), bw),
            isColor and colors.blue or colors.gray,
            isColor and colors.blue or colors.gray)
    end
    return
  end

  local isRed = RED[card.suit]
  local fg    = isRed and C.red_suit or C.black_suit
  local rl    = card.rank   -- rank label
  local pad   = #rl == 1 and " " or ""   -- right-pad single-char rank

  -- Top line
  at(x, y)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x, y);     write(rl .. pad, fg, C.card_bg)

  -- Middle line (suit)
  at(x, y+1)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x + math.floor(bw/2), y+1)
  write(card.suit, fg, C.card_bg)

  -- Bottom line
  at(x, y+2)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x + bw - #rl - 1, y+2)
  write(pad .. rl, fg, C.card_bg)
end

-- Draw a hand of cards starting at (sx, sy)
-- hideFirst = true → hide card at index 1
local function drawHand(hand, sx, sy, hideFirst)
  for i, card in ipairs(hand) do
    local hidden = (i == 1 and hideFirst)
    drawCard(sx + (i-1)*6, sy, card, hidden)
  end
end

-- ── HUD / status ─────────────────────────────────────────────
local function drawHUD(chips, bet)
  -- Header bar
  term.setBackgroundColor(C.bg)
  at(1, 1)
  term.clearLine()
  write(" \4 BLACKJACK \4 ", C.gold, C.bg)
  local chipStr = "Chips: $" .. chips
  at(w - #chipStr, 1)
  write(chipStr, C.header, C.bg)
  if bet > 0 then
    local betStr = "Bet: $" .. bet
    at(math.floor((w - #betStr)/2)+1, 1)
    write(betStr, C.gold, C.bg)
  end
end

local function drawLabels(dealerTotal, playerTotal, hideDealer)
  at(1, 3)
  write("Dealer", C.dim, C.bg)
  if not hideDealer then
    local dtxt = " (" .. dealerTotal .. ")"
    write(dtxt, dealerTotal > 21 and C.bust or C.text, C.bg)
  end

  at(1, 8)
  write("You   ", C.dim, C.bg)
  local ptxt = " (" .. playerTotal .. ")"
  write(ptxt, playerTotal > 21 and C.bust or C.text, C.bg)
end

-- ── Button row ───────────────────────────────────────────────
-- buttons = { {label, key}, ... }
local function drawButtons(buttons, y)
  local totalW = 0
  for _, b in ipairs(buttons) do totalW = totalW + #b[1] + 4 end
  local sx = math.floor((w - totalW) / 2) + 1
  local positions = {}
  at(1, y); term.clearLine()
  for _, b in ipairs(buttons) do
    local lbl = "[ " .. b[1] .. " ]"
    positions[#positions+1] = { x=sx, len=#lbl, key=b[2], label=b[1] }
    at(sx, y)
    write(lbl, C.btn_fg, C.btn_bg)
    sx = sx + #lbl + 1
  end
  return positions
end

-- ── Message bar ──────────────────────────────────────────────
local function msg(text, fg)
  at(1, h)
  term.setBackgroundColor(C.bg)
  term.clearLine()
  centre(text, h, fg or C.text, C.bg)
end

-- ── Result banner ────────────────────────────────────────────
local function banner(text, fg)
  centre(string.rep(" ", #text + 4), 6, fg, fg)
  centre("  " .. text .. "  ", 6, C.card_bg, fg)
end

-- ── Betting screen ───────────────────────────────────────────
local function betScreen(chips)
  cls()
  drawHUD(chips, 0)

  local bets   = {10, 25, 50, 100}
  local chosen = 10
  local dirty  = true

  while true do
    if dirty then
      dirty = false
      -- clean area
      for row = 3, h-1 do at(1,row); term.clearLine() end

      centre("Place Your Bet", 4, C.gold, C.bg)
      centre("Current Bet: $" .. chosen, 5, C.text, C.bg)

      -- Bet chips row
      local bx = math.floor((w - (#bets * 6 - 1)) / 2) + 1
      at(1, 7); term.clearLine()
      for i, b in ipairs(bets) do
        local lbl = "$" .. b
        local fg  = (b == chosen) and C.gold or C.btn_fg
        local bg  = (b == chosen) and C.felt  or C.btn_bg
        at(bx, 7)
        write(" " .. lbl .. " ", fg, bg)
        bx = bx + #lbl + 3
      end

      centre("[ DEAL  (Enter) ]", 10, C.btn_fg, C.btn_bg)
      centre("Use < > arrows to change bet", 12, C.dim, C.bg)

      if chips < chosen then
        centre("Not enough chips!", 14, C.bust, C.bg)
      end
    end

    local _, key = os.pullEvent("key")
    if key == keys.left or key == keys.a then
      local ci = 1
      for i,b in ipairs(bets) do if b==chosen then ci=i end end
      chosen = bets[math.max(1, ci-1)]
      dirty = true
    elseif key == keys.right or key == keys.d then
      local ci = 1
      for i,b in ipairs(bets) do if b==chosen then ci=i end end
      chosen = bets[math.min(#bets, ci+1)]
      dirty = true
    elseif key == keys.enter or key == keys.numPadEnter then
      if chips >= chosen then
        return chosen
      end
    elseif key == keys.q then
      return nil  -- quit
    end
  end
end

-- ── Main game loop ───────────────────────────────────────────
local function gameScreen(deck, chips, bet)
  -- Deal initial cards
  local player = { table.remove(deck), table.remove(deck) }
  local dealer = { table.remove(deck), table.remove(deck) }

  local function redraw(hideDealer, extraMsg, extraFg)
    cls()
    drawHUD(chips, bet)
    drawHand(dealer, 2, 3, hideDealer)
    drawHand(player, 2, 8, false)
    local dt = hideDealer and cardValue(dealer[2].rank) or handTotal(dealer)
    drawLabels(dt, handTotal(player), hideDealer)
    if extraMsg then
      banner(extraMsg, extraFg or C.gold)
    end
  end

  -- Check natural blackjack
  local playerBJ = handTotal(player) == 21
  local dealerBJ = handTotal(dealer) == 21

  if playerBJ or dealerBJ then
    redraw(false)
    if playerBJ and dealerBJ then
      banner("PUSH — Both Blackjack!", C.push)
      -- push bet back
    elseif playerBJ then
      banner("BLACKJACK! You win 3:2!", C.win)
      chips = chips + math.floor(bet * 1.5)
    else
      banner("Dealer Blackjack. You lose.", C.bust)
      chips = chips - bet
    end
    msg("Press any key...", C.dim)
    os.pullEvent("key")
    return chips
  end

  -- Player turn
  local stood = false
  while not stood do
    redraw(true)

    local pt = handTotal(player)
    if pt > 21 then
      banner("BUST! You lose.", C.bust)
      chips = chips - bet
      msg("Press any key...", C.dim)
      os.pullEvent("key")
      return chips
    end

    local canDouble = (#player == 2 and chips >= bet*2)
    local btns = { {"Hit (H)", keys.h}, {"Stand (S)", keys.s} }
    if canDouble then btns[#btns+1] = {"Double (D)", keys.d} end

    local positions = drawButtons(btns, h-1)
    msg("Your total: " .. pt, C.text)

    local _, key = os.pullEvent("key")
    if key == keys.h then
      player[#player+1] = table.remove(deck)
    elseif key == keys.s then
      stood = true
    elseif key == keys.d and canDouble then
      bet   = bet * 2
      player[#player+1] = table.remove(deck)
      stood = true
    end
  end

  -- Final player bust check
  local pt = handTotal(player)
  if pt > 21 then
    redraw(false)
    banner("BUST! You lose.", C.bust)
    chips = chips - bet
    msg("Press any key...", C.dim)
    os.pullEvent("key")
    return chips
  end

  -- Dealer turn (reveal + hit until 17)
  redraw(false)
  os.sleep(0.6)
  while handTotal(dealer) < 17 do
    dealer[#dealer+1] = table.remove(deck)
    redraw(false)
    os.sleep(0.5)
  end

  local dt = handTotal(dealer)
  redraw(false)

  -- Determine winner
  if dt > 21 then
    banner("Dealer Busts! You WIN!", C.win)
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

  msg("Press any key...", C.dim)
  os.pullEvent("key")
  return chips
end

-- ── Title screen ─────────────────────────────────────────────
local function titleScreen()
  cls()
  centre("\4\4\4 BLACKJACK \4\4\4", 2, C.gold,   C.bg)
  centre("ComputerCraft Edition",   3, C.dim,    C.bg)
  centre(string.rep("-", w-2),      4, C.felt,   C.bg)
  centre("Beat the dealer to 21",   6, C.text,   C.bg)
  centre("without going over!",     7, C.text,   C.bg)
  centre(string.rep("-", w-2),      9, C.felt,   C.bg)
  centre("[ Press Enter to Start ]",11, C.btn_fg, C.btn_bg)
  centre("[ Q to Quit ]",          13, C.dim,    C.bg)

  while true do
    local _, key = os.pullEvent("key")
    if key == keys.enter or key == keys.numPadEnter then return true end
    if key == keys.q then return false end
  end
end

-- ── Game over screen ─────────────────────────────────────────
local function gameOver(chips)
  cls()
  centre("\4 GAME OVER \4",         3, C.bust,  C.bg)
  if chips <= 0 then
    centre("You ran out of chips!",  5, C.text,  C.bg)
  else
    centre("You cashed out with",    5, C.text,  C.bg)
    centre("$" .. chips .. "!",      6, C.gold,  C.bg)
  end
  centre("[ Play Again? (Enter) ]", 9, C.btn_fg, C.btn_bg)
  centre("[ Quit (Q) ]",           11, C.dim,   C.bg)

  while true do
    local _, key = os.pullEvent("key")
    if key == keys.enter or key == keys.numPadEnter then return true end
    if key == keys.q then return false end
  end
end

-- ── Entry point ──────────────────────────────────────────────
math.randomseed(os.time())

while true do
  if not titleScreen() then break end

  local chips = 500
  local deck  = newDeck(4)
  shuffle(deck)

  while chips > 0 do
    -- Reshuffle when deck runs low
    if #deck < 20 then
      deck = newDeck(4)
      shuffle(deck)
    end

    local bet = betScreen(chips)
    if not bet then break end   -- player quit

    chips = gameScreen(deck, chips, bet)

    if chips <= 0 then
      if not gameOver(chips) then goto quit end
      chips = 500
      deck  = newDeck(4)
      shuffle(deck)
    end
  end

  if chips > 0 then
    if not gameOver(chips) then break end
  end
end

::quit::
cls()
at(1,1)
term.setTextColor(C.text)
term.setBackgroundColor(colors.black)
print("Thanks for playing Blackjack!")
