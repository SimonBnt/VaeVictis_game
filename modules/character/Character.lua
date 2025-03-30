---- // ---- MODULES ---- // ---- 

local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")

---- // ---- LOCAL VAR ---- // ---- 

local font = love.graphics.newFont(10)
local lvlFont = love.graphics.newFont(8)
local statutBarWitdh = 64

---- // ---- CHARACTER OBJECT ---- // ---- 

local Character = {}
Character.__index = Character

function Character:new(name, posX, posY, currentHealth, maxHealth, currentMana, maxMana, currentXp, maxXp, currentEnergy, maxEnergy, atk, def, int, dex, crit, atkSpeed, lvl, coin, isMonster)
    local character = {
        name = isMonster and name or "",
        posX = posX,
        posY = posY,
        currentHealth = currentHealth,
        maxHealth = maxHealth,
        currentMana = currentMana,
        maxMana = maxMana,
        currentEnergy = currentEnergy,
        maxEnergy = maxEnergy,
        atk = atk,
        def = def,
        int = int,
        dex = dex,
        crit = crit,
        lvl = isMonster and nil or lvl,
        currentXp = currentXp,
        maxXp = isMonster and nil or maxXp,
        atkSpeed = atkSpeed,
        coin = coin,
        isMonster = isMonster,
        isDead = false,
        attackCooldown = 0,
        canAtk = false,
        isAttacking = false,
        isBlocking = false,
        monsterAttackTimer = isMonster and 0 or 0,
        isPreparingAtk = isMonster and false or nil,

        healthStatutBarPosY = 4,
        manaStatutBarPosY = 10,
        energyStatutBarPosY = 16,
        xpStatutBarPosY = 22,

        -- energybar
        -- several attack and monster too
    }

    setmetatable(character, self)
    self.__index = self

    return character
end

function Character:showInfos()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.name, self.posX - 16, self.posY - 20)
    love.graphics.setFont(lvlFont)
    love.graphics.print("Lvl : " .. hero.lvl, 138, 10)
end

function Character:createStatutBar(current, max, posX, posY, color, isHealthBar)
    love.graphics.setFont(font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", posX, posY, statutBarWitdh, 1)

    local percentage = current / max
    local barLength = statutBarWitdh * percentage

    -- Changement de couleur uniquement pour la barre de vie
    if isHealthBar then
        if percentage >= 0.5 then
            love.graphics.setColor(0, 255, 0) -- Vert
        elseif percentage > 0.3 then
            love.graphics.setColor(255, 187, 0) -- Orange
        else
            love.graphics.setColor(255, 0, 0) -- Rouge
        end
    else
        love.graphics.setColor(color) -- Couleur par défaut pour les autres barres
    end

    love.graphics.rectangle("fill", posX, posY, barLength, 3)

    -- Texte de la barre
    -- love.graphics.setColor(1, 1, 1)
    -- local text = current .. "/" .. max
    -- local textWidth = font:getWidth(text)
    -- local textHeight = font:getHeight()
    -- local textX = posX + (32 - textWidth) / 2
    -- local textY = posY + (4 - textHeight) / 2

    -- love.graphics.print(text, textX, textY)
end

function Character:statutBars(posX)
    self:createStatutBar(self.currentHealth, self.maxHealth, posX, self.healthStatutBarPosY, {0, 1, 0}, true) -- Barre de vie
    self:createStatutBar(self.currentMana, self.maxMana, posX, self.manaStatutBarPosY, {0, 0, 1}, false) -- Barre de mana

    if not self.isMonster and self.maxXp then
        self:createStatutBar(self.currentXp, self.maxXp, posX, self.xpStatutBarPosY, {1, 0.1, 1}, false) -- Barre d'XP
    end
end

-- function Character:statutBars()
--     self:createStatutBar(self.currentHealth, self.maxHealth, self.posX, self.healthStatutBarPosY, {0, 1, 0}, true) -- Barre de vie
--     self:createStatutBar(self.currentMana, self.maxMana, self.posX, self.manaStatutBarPosY, {0, 0, 1}, false) -- Barre de mana

--     if not self.isMonster and self.maxXp then
--         self:createStatutBar(self.currentXp, self.maxXp, self.posX, self.xpStatutBarPosY, {1, 0.1, 1}, false) -- Barre d'XP
--     end
-- end

function Character:createActionBar(posX, posY)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", posX, posY, statutBarWitdh, 1)
    love.graphics.setColor(1, 0.2, 0.5)
    love.graphics.rectangle("fill", posX, posY, self.attackCooldown, 3)
end

function Character:actionBars()
    self:createActionBar(self.posX - 16, self.posY + 64)
end

function Character:updateAttackCooldown(dt)
    self.attackCooldown = math.min(self.attackCooldown + dt * self.atkSpeed, statutBarWitdh) -- Remplissage progressif
    self.canAtk = (self.attackCooldown == statutBarWitdh)
end

function Character:drawStatut(posX)
    self:showInfos()
    self:statutBars(posX)
    self:actionBars()
end

function Character:takeDamage(atk, def)
    atkThrow = math.random(1, 10)
    defThrow = math.random(1,10)
    attack = atkThrow + atk
    defence = defThrow + def
    damage = math.max(0, attack - defence)

    if self.currentHealth > 0 then
        self.currentHealth = math.max(0, self.currentHealth - damage)
    end

    return damage
end

return Character