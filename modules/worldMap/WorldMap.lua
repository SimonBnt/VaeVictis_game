local WorldMap = {}

function WorldMap.draw()
    local text = "World Map"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    local x = (640 - textWidth) / 2
    local y = (320 - textHeight) / 2
    love.graphics.print(text, x, y)
end

return WorldMap