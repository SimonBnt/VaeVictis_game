
local Particle = require("modules.interface.Particle")

local LevelUp = {}

function LevelUp.trigger(hero)
    hero.lvl = hero.lvl + 1
    
    hero.maxHealth = hero.maxHealth + 10
    hero.maxMana   = hero.maxMana + 10
    hero.maxEnergy = hero.maxEnergy + 10
    
    hero.atk = hero.atk + 1
    hero.def = hero.def + 1
    hero.int = hero.int + 1
    hero.dex = hero.dex + 1
    hero.crit = hero.crit + 1
    hero.atkSpeed = hero.atkSpeed + 1

    Particle:create("circle", 800, 1000, -50, 50, -80, -20, 0.5, 1.5, 0.2, 1, hero.posX, hero.posY, 100, true, {1,1,0})
end

return LevelUp