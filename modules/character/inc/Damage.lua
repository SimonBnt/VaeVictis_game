local KnockBack = require("modules.character.inc.KnockBack")
local Particle = require("modules.interface.Particle")

local Damage = {}

function Damage.take(target, attack)
    if target.currentHealth > 0 then
        target.currentHealth = math.max(0, target.currentHealth - attack.damage)

        KnockBack.trigger(target)
    end

    Particle:create("circle", 5, 20, -50, 50, -50, 20, 0.5, 1.5, 1, 4, target.posX, target.posY, 100, true, {1,0,0})
end

return Damage