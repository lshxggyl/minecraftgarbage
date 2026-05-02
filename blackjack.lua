-- ============================================================
--  TOUCH BLACKJACK for ComputerCraft
--  Optimized for 2x3 Portrait Monitors v4
-- ============================================================

local mon = peripheral.find("monitor")
if not mon then
    error("No monitor found! Slap an advanced monitor next to this computer.")
end

-- Capture the old terminal state so we can actually quit cleanly
mon.setTextScale(0.75)
local oldTerm = term.redirect(mon)

local w, h = term.getSize()
local isColor = term.isColor()

-- ── Colour palette ────────────
local C = {
  bg        = isColor and colors.green    or colors.black,
  felt      = isColor and colors.green    or colors.black,
  header    = isColor and colors.black    or colors.white,
  text      = isColor and colors.white    or colors.white,
  dim       = isColor and colors.gray     or colors.gray,
  card_bg   = isColor and colors.white    or colors.white,
  card_fg   = isColor and colors.black    or colors.black,
  red_suit  = isColor and colors.red      or colors.white,
  black_suit= isColor and colors.black    or colors.black,
  gold      = isColor and colors.white    or colors.white,
  btn_bg    = isColor and colors.black    or colors.black,
  btn_fg    = isColor and colors.white    or colors.white,
  bust      = isColor and colors.red      or colors.white,
  win       = isColor and colors.lime     or colors.white,
  push      = isColor and colors.lightBlue or colors.white,
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
  local bw, bh = 7, 5 -- Taller cards (7x5)
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

  -- Draw the 5 rows of the card
  at(x, y)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x, y); write(rl .. pad, fg, C.card_bg)

  at(x, y+1)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)

  at(x, y+2)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x + math.floor(bw/2), y+2); write(card.suit, fg, C.card_bg)

  at(x, y+3)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)

  at(x, y+4)
  write(string.rep(" ", bw), C.card_bg, C.card_bg)
  at(x + bw - #rl - 1, y+4); write(pad .. rl, fg, C.card_bg)
end

local function getCardPos(index, sx, sy)
  local i = index - 1
  -- Increased vertical spacing for taller cards
  return sx + (i%3)*8, sy + math.floor(i/3)*6
end

local function drawHand(hand, sx, sy, hideFirst, animateIndex)
  for i, card in ipairs(hand) do
    local hidden = (i == 1 and hideFirst)
    if not animateIndex or i <= animateIndex then
      local cx, cy = getCardPos(i, sx, sy)
      drawCard(cx, cy, card, hidden)
    end
  end
end

local function flipCard(x, y, card)
  local bw, bh = 7, 5
  for row=0, bh-1 do
    at(x, y+row); write(string.rep(" ", bw), C.bg, C.bg)
    at(x+2, y+row); write("|||", colors.blue, colors.blue)
  end
  os.sleep(0.15)
  drawCard(x, y, card, false)
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
  write(" \4 BLACKJACK \4 ", C.header, C.bg)
  local chipStr = "$" .. chips
  at(w - #chipStr, 1); write(chipStr, C.text, C.bg)
end

local function drawLabels(dealerTotal, playerTotal, hideDealer)
  at(2, 3); write("Dealer", C.dim, C.bg)
  if not hideDealer then
    local dColor = (type(dealerTotal) == "number" and dealerTotal > 21) and C.bust or C.text
    write(" (" .. dealerTotal .. ")", dColor, C.bg)
  end

  at(2, 13); write("You", C.dim, C.bg)
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
  centre("  " .. text .. "
