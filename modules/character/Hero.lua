---- // ---- MODULES ---- // ---- 

local Character = require("modules.character.Character")

---- // ---- LOCAL VAR ---- // ---- 

---- // ---- HERO INITIALIZATION ---- // ---- 

local Hero = {}
Hero.__index = Hero
setmetatable(Hero, {__index = Character})

function Hero:new()
    local hero = Character:new(
        "",     -- name
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
        50,         -- atk
        1,          -- def
        1,          -- int
        1,          -- dex
        1,          -- crit
        50,          -- atkSpeed
        20,         -- coin
        false       -- isMonster
    )

    setmetatable(hero, self)
    return hero
end

return Hero