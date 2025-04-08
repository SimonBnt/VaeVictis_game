---- // ---- MODULES ---- // ---- 

local Character = require("modules.character.Character")
local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")

---- // ---- LOCAL VAR ---- // ---- 

---- // ---- HERO INITIALIZATION ---- // ---- 

local Hero = {}
Hero.__index = Hero
setmetatable(Hero, {__index = Character})

function Hero:new()
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
        2,         -- atk
        2,          -- def
        2,          -- int
        2,          -- dex
        1,          -- crit
        3,          -- atkSpeed
        0,         -- coin
        false       -- isMonster
    )

    setmetatable(hero, self)
    return hero
end

return Hero