local ShowTxt = require("modules.interface.ShowTxt")

local Stun = {}

function Stun.trigger(target)
    target.isStunned = true
    target.stunTimer = 8 -- par défaut 8 secondes
    target.currentEnergy = 10
    ShowTxt.trigger(target.name .. " est étourdit", 200, 100)
end

function Stun.update(target ,dt)
    if target.isStunned then
        target.stunTimer = target.stunTimer - dt

        if target.stunTimer <= 0 then
            target.isStunned = false
            target.stunTimer = 0
            ShowTxt.trigger(target.name .. " n'est plus étourdit", 200, 100)
        end
    end
end

return Stun