local MoveSet = {}

function MoveSet.draw(hero)
    local font = love.graphics.newFont(8)
    love.graphics.setFont(font)
    love.graphics.setColor(0, 0, 0)

    local posY = 32
    local posX = 20
    local w = 50
    local offset = 55

    for i = 1, hero.maxMoveSet do
        love.graphics.rectangle("line", posX, posY, w, 14, 2)
        posX = posX + offset
    end

    posX = 20

    for i = 1, hero.maxMoveSet do
        local atk = hero.availableAtkList[i]

        if atk then
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(atk.name, posX + 2, posY)
        end
        
        posX = posX + offset
    end

    love.graphics.setFont(love.graphics.newFont()) -- reset to default font
    love.graphics.setColor(1, 1, 1) -- reset color
end

return MoveSet