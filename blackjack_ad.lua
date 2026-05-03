local mon = peripheral.find("monitor")
if not mon then
    error("Monitor missing. Plug the damn thing in before running the script.")
end

-- Scale 2 fits a 9-letter word perfectly on a 3-block-wide monitor
mon.setTextScale(2)
local w, h = mon.getSize()

local step = 0
while true do
    -- Casino felt background
    mon.setBackgroundColor(colors.green)
    mon.clear()

    -- Alternate between White, Yellow, and Red for the main text
    local text_colors = {colors.white, colors.yellow, colors.red}
    mon.setTextColor(text_colors[(step % 3) + 1])

    local text = "BLACKJACK"
    local x = math.floor((w - string.len(text)) / 2) + 1
    local y = math.ceil(h / 2)

    mon.setCursorPos(x, y)
    mon.write(text)

    -- Flashy black dollar signs on the sides every other tick
    mon.setTextColor(colors.black)
    if step % 2 == 0 then
        mon.setCursorPos(x - 2, y)
        mon.write("$")
        mon.setCursorPos(x + string.len(text) + 1, y)
        mon.write("$")
    end

    step = step + 1
    os.sleep(0.4) -- Not as fast as the main sign, keeping it slick
end
