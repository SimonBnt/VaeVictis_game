---- // ---- MODULES ---- // ---- 

local Character = require("modules.character.Character")

---- // ---- LOCAL VAR ---- // ---- 

---- // ---- HERO INITIALIZATION ---- // ---- 

local Hero = {}
Hero.__index = Hero
setmetatable(Hero, {__index = Character})

function Hero:new(inventory)
    local hero = Character:new(
        "Héro",     -- name
        160,        -- posX
        208,        -- posY
        100,        -- currentHealth
        100,        -- maxHealth
        100,        -- currentMana
        100,        -- maxMana
        100,        -- currentEnergy
        100,        -- maxEnergy
        0,          -- currentXp
        100,        -- maxXp
        1,          -- lvl
        10,         -- atk
        2,          -- def
        2,          -- int
        2,          -- dex
        1,          -- crit
        50,          -- atkSpeed
        0,         -- coin
        false       -- isMonster
    )

    hero.inventory = inventory
    
    setmetatable(hero, self)
    return hero
end

return Hero