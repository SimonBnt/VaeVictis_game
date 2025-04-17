local showTxt = {}
local activeMessages = {}

function showTxt.trigger(txt, posX, posY)
    table.insert(activeMessages, {
        text = txt,
        x = posX,
        y = posY,
        timeRemaining = 2
    })
end

function showTxt.update(dt)
    for i = #activeMessages, 1, -1 do
        local message = activeMessages[i]
        message.timeRemaining = message.timeRemaining - dt
        
        if message.timeRemaining <= 0 then
            table.remove(activeMessages, i)
        end
    end
end

function showTxt.draw()
    love.graphics.setColor(1, 1, 1)

    for _, message in ipairs(activeMessages) do
        -- Optionnel: faire disparaître progressivement le texte
        local alpha = math.min(1, message.timeRemaining)
        love.graphics.setColor(1, 1, 1, alpha)
        
        love.graphics.print(message.text, message.x, message.y)
    end
    
    love.graphics.setColor(1, 1, 1, 1)
end

return showTxt