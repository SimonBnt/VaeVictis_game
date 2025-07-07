local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager
resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local numberFont = love.graphics.newFont(8)

local WeatherTimeline = {}

function WeatherTimeline.draw(Calendar, GameTime)
    local index = 4
    local xStart = 224
    local xEnd = 416
    local space = (xEnd - xStart) / (index - 1)
    local days = Calendar:getViewDays(index)
    local progress = GameTime.minutes / 1440 -- 0 à 1
    local centerX = xStart + (xEnd - xStart) / 2

    love.graphics.setScissor(xStart, 15, xEnd - xStart, 30)
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", xStart, 15, xEnd - xStart, 30, 4)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", centerX, 15, 2, 4, 4)
    love.graphics.setColor(1, 1, 1, 1)

    for i, info in ipairs(days) do
        -- Calcule la position X, puis décale TOUT à gauche selon la progression du jour
        local x = math.floor(xStart + (i - 1) * space - progress * space + 0.5)
        spriteManager:drawSpriteCentered(info.weather, x, 30, 1, 1)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.setFont(numberFont)
        love.graphics.print(string.format(info.day), x - 2, 22)
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.setScissor()
end

return WeatherTimeline
