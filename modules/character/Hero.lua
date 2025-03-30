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
        "",     -- name
        160,        -- posX
        208,        -- posY
        100,        -- currentHealth
        100,        -- maxHealth
        100,        -- currentMana
        100,        -- maxMana
        0,          -- currentEnergy
        100,        -- maxEnergy
        0,          -- currentXp
        100,        -- maxXp
        50,         -- atk
        1,          -- def
        1,          -- int
        1,          -- dex
        1,          -- crit
        50,          -- atkSpeed
        1,          -- lvl
        20,         -- coin
        false       -- isMonster
    )
    setmetatable(hero, self)
    return hero
end

---- // ---- HERO FUNCTION ---- // ---- 

function Hero:heroAtk(monster, ShowDamageDealtAnimation)
    if self.canAtk and monster.currentHealth > 0 then
        self.isAttacking = true
        self.attackCooldown = 0

        local damage = monster:takeDamage(hero.atk, self.def)

        ShowDamageDealtAnimation.trigger(damage, monster.posX, monster.posY)
    end
end

function Hero:lvlUp()
    self.lvl = self.lvl + 1
    self.currentXp = 0
    self.maxHealth = self.maxHealth + 20  -- Increase max health
    self.maxMana = self.maxMana + 10      -- Increase max mana
    self.currentHealth = self.maxHealth   -- Restore health to max
end

function Hero:isBlocking()
    if hero.isBlocking then
        love.graphics.setColor(1,1,1,1)
        love.graphics.print("attack blocked", 0 ,0)
    end
end

function Hero:showCoinInPocket()
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(hero.coin, 32, 8)
end

---- // ---- UPDATE HERO FUNCTION ---- // ---- 

function Hero:heroUpdateFunction(monster, ShowDamageDealtAnimation, dt) 
    if hero.canAtk and love.keyboard.isDown("right") then
        hero:heroAtk(monster, ShowDamageDealtAnimation)
    end
end

return Hero