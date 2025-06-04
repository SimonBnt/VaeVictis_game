local Flash = {}

Flash.timer = 10000000000

function Flash.trigger(dt)
    Flash.timer = Flash.timer - dt

    if Flash.timer >= 10 then 
        love.graphics.setColor(0.2,0.2,0.2)
    end
end

return Flash 