---- // ---- MODULES ---- // ---- 

-- local ShowTxt = require("modules.interface.ShowTxt")
-- local Item = require("modules.expedition.Item")
-- local Particle = require("modules.interface.Particle")
-- local SpriteManager = require("modules.sprite.SpriteManager")
-- local manaShardsByClass = require("modules.expedition.inc.ManaShard")
-- local Potion = require("modules.expedition.inc.Potion")
-- local Tools = require("modules.expedition.inc.Tools")

local SlashEffect = require("modules.interface.SlashEffect")
local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")
local Control = require("modules.control.Control")
local Attack = require("modules.character.inc.Attack")
local Bar = require("modules.character.inc.Bar")
local KnockBack = require("modules.character.inc.KnockBack")
local Damage = require("modules.character.inc.Damage")
local Stun = require("modules.character.inc.Stun")
local Reward = require("modules.character.progress.Reward")

---- // ---- LOCAL VAR ---- // ---- 

local font = love.graphics.newFont(10)
local infoFont = love.graphics.newFont(10)
love.graphics.setFont(font)

---- // ---- CHARACTER OBJECT ---- // ---- 

local Character = {}
Character.__index = Character

function Character:new(name, posX, posY, currentHealth, maxHealth, currentMana, maxMana, currentEnergy, maxEnergy, currentXp, maxXp, lvl, atk, def, int, dex, crit, atkSpeed, coin, soul, class, isMonster, inventory)
    local self = setmetatable({}, Character)

    self.name = name                            --name
    self.posX = posX                            --posX
    self.posY = posY                            --posY
    self.currentHealth = currentHealth          --currentHealth
    self.maxHealth = maxHealth                  --maxHealth
    self.currentMana = currentMana              --currentMana
    self.maxMana = maxMana                      --maxMana
    self.currentEnergy = currentEnergy          --currentEnergy
    self.maxEnergy = maxEnergy                  --maxEnergy
    self.currentXp = currentXp                  --currentXp
    self.maxXp = isMonster and nil or maxXp     --maxXp
    self.lvl = lvl                              --lvl
    self.atk = atk                              --atk
    self.def = def                              --def
    self.int = int                              --int
    self.dex = dex                              --dex
    self.crit = crit                            --crit
    self.atkSpeed = atkSpeed * dex              --atkSpeed
    self.coin = coin                            --coin
    self.soul = isMonster and soul or nil       --soul
    self.class = isMonster and class or nil     --class
    self.isMonster = isMonster

    self.inventory = inventory

    self.isDead = false
    self.isLowLvl = false

    self.attackCooldown = 0
    
    self.canAtk = false
    self.canCounterAtk = isMonster and nil or false
    self.canFightBack = isMonster and nil or false

    -- Initialise la liste d’attaques

    self.maxMoveSet = isMonster and nil or 7
    self.availableAtkList = {}
    self.atkIndex = 1
    self.combo = {}
    self.comboSuccessTimer = 1

    for _, atk in ipairs(Attack.list.default) do
        table.insert(self.availableAtkList, atk)
    end

    -- monster atk
    self.isAboutToAtk = false
    self.monsterAttackTimer = isMonster and 0 or 0
    
    -- bars position
    self.healthStatutBarPosY = 4
    self.manaStatutBarPosY = 10
    self.energyStatutBarPosY = 16
    self.xpStatutBarPosY = 22
    
    -- energy
    self.energyUsedByAtk = 10
    self.energyUsedByTakingAtk = 5
    self.energyUsedByMissingParry = 20
    
    -- parry
    self.parryCooldown = 0
    self.hasParried = false

    -- stun
    self.isStunned = false
    self.stunTimer = 0

    -- knockback
    self.velocityX = 0
    self.knockbackTimer = 0
    self.knockbackOriginX = nil
    self.isReturningFromKnockback = false

    return self
end

---- // ---- CHARACTER INTERFACE FUNCTION ---- // ---- 

function Character:info()
    love.graphics.setFont(infoFont)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.name, self.posX - 16, self.posY - 20)
    love.graphics.print("Lvl : " .. self.lvl, 138, 16)
    love.graphics.setFont(love.graphics.newFont()) -- reset to default font
end

function Character:coinInPocket()
    love.graphics.setFont(infoFont)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(math.floor(self.coin), 32, 8)
    love.graphics.setFont(love.graphics.newFont()) -- reset to default font
end

function Character:createStatutBar(posX)
    Bar.create(self.currentHealth, self.maxHealth, posX, self.healthStatutBarPosY, {0, 1, 0.5}, true) -- Barre de vie

    Bar.create(self.currentMana, self.maxMana, posX, self.manaStatutBarPosY, {0, 0.5, 1}, false) -- Barre de mana

    Bar.create(self.currentEnergy, self.maxEnergy, posX, self.energyStatutBarPosY, {1, 1, 0.5}, false) -- Barre d'enegie

    if not self.isMonster and self.maxXp then
        Bar.create(self.currentXp, self.maxXp, posX, self.xpStatutBarPosY, {0.7, 0.2, 1}, false) -- Barre d'XP
    end
end

function Character:createActionBars()
    Bar.createActionBar(self.posX - 16, self.posY - 24, self.attackCooldown)
end

function Character:isPreparingAtk()
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", self.posX + 16, self.posY, 2)
    love.graphics.setColor(1, 1, 1)
end

function Character:actionBarIsFull()
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle("fill", self.posX + 20, self.posY, 2)
    love.graphics.setColor(1, 1, 1)
end

function Character:drawStatut(posX)
    self:info()
    self:coinInPocket()
    self:createStatutBar(posX)
    self:createActionBars()
end

---- // ---- CHARACTER FIGHT FUNCTION ---- // ---- 

function Character:heroAtk(target, attack)
    if target.currentHealth <= 0 then return end

    self:useEnergy(self.energyUsedByAtk)
    Damage.take(target, attack)
    ShowDamageDealtAnimation.trigger(attack.damage, target.posX, target.posY)

    if not target.isStunned then
        target:useEnergy(target.energyUsedByTakingAtk)
    end

    -- local animationName = target.isMonster and "monster_idle" or "hero_idle"
    -- SlashEffect.trigger(target, self.SpriteManager, animationName)

    if target.currentHealth <= 0 then
        target.isDead = true
        Reward.get(self, target)
    end

    if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
        Stun.trigger(target)
    end
end

---- // ---- CHARACTER STATUT UPDATE FUNCTION ---- // ---- 

function Character:useEnergy(amount)
    self.currentEnergy = math.max(0, self.currentEnergy - amount)
end

function Character:updateCooldown(dt)
    if not self.isStunned then
        self.attackCooldown = math.min((self.attackCooldown + dt * self.atkSpeed), Bar.barW) -- Remplissage progressif

        -- si la barre est remplie alors assigne la valeur true à canAtk
        self.canAtk = (self.attackCooldown == Bar.barW)
    end
end

function Character:updateEnergyBar(dt)
    if self.currentEnergy < self.maxEnergy and not self.isStunned then
        if self.isMonster then
            self.currentEnergy = math.min(self.currentEnergy + (dt * self.dex), self.maxEnergy)
        else
            self.currentEnergy = math.min(self.currentEnergy + (dt * self.dex), self.maxEnergy)
        end
    end
end

function Character:isComboSuccessful()
    if #self.combo ~= #self.availableAtkList then
        return false
    end
 
    for i = 1, #self.combo do
        if self.combo[i] ~= self.availableAtkList[i] then
            return false
        end
    end

    return true
end

---- // ---- CHARACTER UPDATE FUNCTION GLOBAL CALL ---- // ---- 

function Character:update(target, dt, ShowDamageDealtAnimation)
    self:updateCooldown(dt)
    self:updateEnergyBar(dt)
    KnockBack.update(target, dt)
    Stun.update(target, dt)
    Reward.update(self, dt)

    if not self.isMonster and self.canAtk then
        self.isAboutToAtk = Control.keys.down
    else
        self.isAboutToAtk = false
    end

    if not self.isMonster and self.isAboutToAtk and self.currentEnergy >= self.energyUsedByAtk then
        local currentAttack = self.availableAtkList[self.atkIndex]

        if currentAttack and Control.keys[currentAttack.key] then
            self:heroAtk(target, currentAttack)

            -- Avance au prochain coup seulement après une attaque réussie
            self.atkIndex = self.atkIndex % #self.availableAtkList + 1
            table.insert(self.combo, currentAttack)

            if self:isComboSuccessful() then
                self.attackCooldown = 0
                self.combo = {}
            end
        end
    end
end

---- // ---- CHARACTER DRAW FUNCTION GLOBAL CALL ---- // ---- 

function Character:draw(posX)
    self:drawStatut(posX)

    if self.canAtk then
        self:actionBarIsFull()
    end

    local posY = 0

    for _, atk in pairs(self.combo) do
        love.graphics.print(atk.name, 300, posY)
        posY = posY + 10
    end
    
    if self.canAtk and self.currentEnergy >= self.energyUsedByAtk then
        if isMonster then
            self:isPreparingAtk()
        elseif self.isAboutToAtk then
            self:isPreparingAtk()
        end
    end
end

return Character