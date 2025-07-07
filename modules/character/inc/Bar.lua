local Bar = {}

-- local font = love.graphics.newFont(10)
Bar.barW = 64

function Bar.create(current, max, posX, posY, color, isHealthBar)
    -- love.graphics.setFont(font)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", posX, posY, Bar.barW, 2)

    local percentage = current / max
    local barLength = Bar.barW * percentage

    -- Changement de couleur uniquement pour la barre de vie
    if isHealthBar then
        if percentage >= 0.5 then
            love.graphics.setColor(0, 255, 0.5) -- Vert
        elseif percentage > 0.3 then
            love.graphics.setColor(255, 187, 0.5) -- Orange
        else
            love.graphics.setColor(255, 0, 0.5) -- Rouge
        end
    else
        love.graphics.setColor(color) -- Couleur par défaut pour les autres barres
    end

    love.graphics.rectangle("fill", posX, posY, barLength, 2)

    -- Texte de la barre
    -- love.graphics.setColor(1, 1, 1)
    -- local text = current .. "/" .. max
    -- local textWidth = font:getWidth(text)
    -- local textHeight = font:getHeight()
    -- local textX = posX + (32 - textWidth) / 2
    -- local textY = posY + (4 - textHeight) / 2

    -- love.graphics.print(text, textX, textY)
end

function Bar.createActionBar(posX, posY, attackCooldown)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", posX, posY, Bar.barW, 2)
    love.graphics.setColor(1, 0.2, 0.5)
    love.graphics.rectangle("fill", posX, posY, attackCooldown, 2)
    love.graphics.setColor(1, 1, 1)
end

return Bar