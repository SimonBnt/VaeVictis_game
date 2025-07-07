local GameMenu = {}

local menuFont = love.graphics.newFont(12)

function GameMenu.draw()
    love.graphics.setFont(menuFont)
    love.graphics.print("Partir en expedition", 20, 160)
    love.graphics.print("Option", 20, 180)
    love.graphics.print("Quitter", 20, 200)
end

return GameMenu