---- // ---- MODULES ---- // ---- 

local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")
local showTxt = require("modules.interface.ShowTxt")

---- // ---- LOCAL VAR ---- // ---- 

local font = love.graphics.newFont(10)
local lvlFont = love.graphics.newFont(8)
local statutBarWitdh = 64

---- // ---- CHARACTER OBJECT ---- // ---- 

local Character = {}
Character.__index = Character

function Character:new(name, posX, posY, currentHealth, maxHealth, currentMana, maxMana, currentEnergy, maxEnergy, currentXp, maxXp, lvl, atk, def, int, dex, crit, atkSpeed, coin, isMonster)
    local character = {
        name = isMonster and name or "",        --name
        posX = posX,                            --posX
        posY = posY,                            --posY
        currentHealth = currentHealth,          --currentHealth
        maxHealth = maxHealth,                  --maxHealth
        currentMana = currentMana,              --currentMana
        maxMana = maxMana,                      --maxMana
        currentEnergy = currentEnergy,          --currentEnergy
        maxEnergy = maxEnergy,                  --maxEnergy
        currentXp = currentXp,                  --currentXp
        maxXp = isMonster and nil or maxXp,     --maxXp
        lvl = lvl,                              --lvl
        atk = atk,                              --atk
        def = def,                              --def
        int = int,                              --def
        dex = dex,                              --dex
        crit = crit,                            --crit
        atkSpeed = atkSpeed,                    --atkSpeed
        coin = coin,                            --coin
        isMonster = isMonster,

        isDead = false,
        isLowLvl = false,

        attackCooldown = 0,

        canAtk = false,
        isAttacking = false,
        hasParried = false,
        monsterAttackTimer = isMonster and 0 or 0,
        isAboutToAtk = isMonster and false or nil,
        isStunned = false,

        healthStatutBarPosY = 4,
        manaStatutBarPosY = 10,
        energyStatutBarPosY = 16,
        xpStatutBarPosY = 22,

        energyUsedByAtk = 20,
        energyUsedByTakingAtk = 10,
        energyUsedByMissingParry = 40

        -- several attack and monster too
    }

    setmetatable(character, self)
    self.__index = self

    return character
end

---- // ---- CHARCATER FUNCTION ---- // ---- 

function Character:showInfos()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.name, self.posX - 16, self.posY - 20)
    love.graphics.setFont(lvlFont)
    love.graphics.print("Lvl : " .. hero.lvl, 138, 16)
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
            love.graphics.setColor(0, 255, 0.5) -- Vert
        elseif percentage > 0.3 then
            love.graphics.setColor(255, 187, 0.5) -- Orange
        else
            love.graphics.setColor(255, 0, 0.5) -- Rouge
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

---- // ---- CHARCATER INTERFACE FUNCTION ---- // ---- 

function Character:statutBars(posX)
    self:createStatutBar(self.currentHealth, self.maxHealth, posX, self.healthStatutBarPosY, {0, 1, 0.5}, true) -- Barre de vie

    self:createStatutBar(self.currentMana, self.maxMana, posX, self.manaStatutBarPosY, {0, 0.5, 1}, false) -- Barre de mana

    self:createStatutBar(self.currentEnergy, self.maxEnergy, posX, self.energyStatutBarPosY, {1, 1, 0.5}, false) -- Barre d'enegie

    if not self.isMonster and self.maxXp then
        self:createStatutBar(self.currentXp, self.maxXp, posX, self.xpStatutBarPosY, {0.7, 0.2, 1}, false) -- Barre d'XP
    end
end

function Character:createActionBar(posX, posY)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", posX, posY, statutBarWitdh, 1)
    love.graphics.setColor(1, 0.2, 0.5)
    love.graphics.rectangle("fill", posX, posY, self.attackCooldown, 3)
    love.graphics.setColor(1, 1, 1)
end

function Character:actionBars()
    self:createActionBar(self.posX - 16, self.posY + 64)
end

-- afficher le nombre de coin en poche à coté du sprite de coin
function Character:showCoinInPocket()
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(self.coin, 32, 8)
end

-- afficher rond rouge à coté du monstre si il se prépare à attaquer
function Character:isPreparingAtk()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.posX + 16, self.posY, 4)
    love.graphics.setColor(1, 1, 1)
end

function Character:drawStatut(posX)
    self:showInfos()
    self:statutBars(posX)
    self:actionBars()

    if self.isMonster == false then
        self:showCoinInPocket()
    end

    if self.isMonster == true and self.isAboutToAtk and self.currentEnergy >= self.energyUsedByAtk then
        self:isPreparingAtk()
    end
end

---- // ---- CHARCATER STATUT FUNCTION ---- // ---- 

function Character:useEnergy(amount)
    self.currentEnergy = math.max(0, self.currentEnergy - amount)
end

---- // ---- CHARCATER BATTLE FUNCTION ---- // ---- 

function Character:performAtk(target, dt, ShowDamageDealtAnimation)
    -- hero attack logic
    if self.isMonster == false then
        if self.canAtk and target.currentHealth > 0 and self.currentEnergy >= self.energyUsedByAtk then
            self.isAttacking = true
            self.attackCooldown = 0
    
            self:useEnergy(self.energyUsedByAtk)
            target:useEnergy(self.energyUsedByTakingAtk)
    
            local damage = target:takeDamage(hero.atk, self.def)
    
            ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

            if target.isDead == false and target.currentEnergy <= target.energyUsedByTakingAtk then
                target.isStunned = true
            end
            
            if target.currentHealth <= 0 then
                target.isDead = true
                self:getReward(target)
            end
        end
    end

    -- monster attack logic
    if self.isMonster == true then
        if self.canAtk and not self.isAboutToAtk then
            self.isAboutToAtk = true
            self.monsterAttackTimer = 0
        end
    
        if self.isAboutToAtk then
            self.monsterAttackTimer = self.monsterAttackTimer + dt
    
            if self.monsterAttackTimer >= 1 then
                if target.hasParried then
                    if target.isStunned == true then
                        target.currentEnergy = (target.maxEnergy / 0.4)
                    end

                    target.hasParried = false -- Reset le blocage après l'attaque
                elseif self.currentEnergy >= self.energyUsedByAtk then
                    self.isAttacking = true
                    self:useEnergy(self.energyUsedByAtk)
                    target:useEnergy(self.energyUsedByTakingAtk)
    
                    local damage = target:takeDamage(self.atk, self.def)
                    ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

                    self.attackCooldown = 0
                end
    
                self.isAboutToAtk = false
            end
        end
    end
end

function Character:getReward(monster)
    local xpReward = math.floor(monster.currentXp * monster.lvl)
    local coinReward = monster.coin

    self.pendingXp = (self.pendingXp or 0) + xpReward
    self.pendingCoin = (self.pendingCoin or 0) + coinReward
end

function Character:updateReward(dt)
    local xpSpeed = 500    
    local coinSpeed = 10

    -- Mise à jour progressive de l'XP
    if self.pendingXp and self.pendingXp >= 0 then
        local xpToAdd = math.min(xpSpeed * dt, self.pendingXp)

        self.currentXp = self.currentXp + xpToAdd
        self.pendingXp = self.pendingXp - xpToAdd
    end
    
    if self.maxXp then
        while self.currentXp >= self.maxXp do
            self.currentXp = self.currentXp - self.maxXp
            self:lvlUp()
            self.maxXp = self.maxXp + math.floor(self.lvl * 100)
        end
    end

    if self.pendingCoin and self.pendingCoin > 0 then
        local coinToAdd = math.min(coinSpeed * dt, self.pendingCoin)
        self.coin = self.coin + coinToAdd
        self.pendingCoin = self.pendingCoin - coinToAdd
    end
end

function Character:lvlUp()
    self.lvl = self.lvl + 1
    
    self.maxHealth = self.maxHealth + 10
    self.maxMana   = self.maxMana + 10
    self.maxEnergy = self.maxEnergy + 10
    
    self.atk = self.atk + 1
    self.def = self.def + 1
    self.int = self.int + 1
    self.dex = self.dex + 1
    self.crit = self.crit + 1
    self.atkSpeed = self.atkSpeed + 1
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

function Character:parry(target, dt)
    if self.parryCooldown and self.parryCooldown > 0 then
        self.parryCooldown = self.parryCooldown - dt
        return
    end

    if love.keyboard.isDown("left") then
        if target.isAboutToAtk and target.monsterAttackTimer < 1 then
            if self.hasParried == false then
                self.hasParried = true
                showTxt("vous avez bloqué l'attaque", 0, 0)
            else
                self.hasParried = false
            end
        else
            --if parry == miss
            self.currentEnergy = math.max(0, self.currentEnergy - self.energyUsedByMissingParry)
            self.parryCooldown = 2
        end
    end
end

---- // ---- CHARCATER UPDATE FUNCTION ---- // ---- 

function Character:updateAttackCooldown(dt)
    if self.isStunned == false then
        self.attackCooldown = math.min((self.attackCooldown + dt * self.atkSpeed), statutBarWitdh) -- Remplissage progressif
        self.canAtk = (self.attackCooldown == statutBarWitdh)
    end
end

function Character:updateEnergyBar(dt)
    if self.currentEnergy < self.maxEnergy then
        self.currentEnergy = math.min(self.currentEnergy + dt, self.maxEnergy)
    end
end

---- // ---- CHARCATER UPDATE FUNCTION GLOBAL CALL ---- // ---- 

function Character:update(target, dt, ShowDamageDealtAnimation)
    self:updateReward(dt)

    if self.isDead == false then
        self:updateAttackCooldown(dt)

        if target.isDead == false then
            self:updateEnergyBar(dt)
        end

        -- hero
        if self.isMonster == false then
            if love.keyboard.isDown("right") then
                self:performAtk(target, dt, ShowDamageDealtAnimation)
            end
    
            self:parry(target, dt)
        end

        -- monster
        if self.isMonster == true then
            self:performAtk(target, dt, ShowDamageDealtAnimation)
        end
    end
end

function Character:drawSpec()
    love.graphics.print("xp : " .. self.currentXp, 300, 100)
    love.graphics.print("maxXp : " .. self.maxXp, 300, 120)
    love.graphics.print("maxHealth : " .. self.maxHealth, 300, 140)
    love.graphics.print("maxMana : " .. self.maxMana, 300, 160)
    love.graphics.print("maxEnergy : " .. self.maxEnergy, 300, 180)
    love.graphics.print("atk : " .. self.atk, 300, 200)
    love.graphics.print("def : " .. self.def, 300, 220)
    love.graphics.print("int : " .. self.int, 300, 240)
    love.graphics.print("dex : " .. self.dex, 300, 260)
    love.graphics.print("crit : " .. self.crit, 300, 280)
    love.graphics.print("attackSpedd : " .. self.atkSpeed, 300, 300)
end

function Character:draw(posX)
    self:drawStatut(posX)

    if self.hasParried == true then
        showTxt("Parade !", 300, 100)
    end

    if self.isDead == true then
        showTxt(self.name .. " est mort", 300, 50)
    end

    if self.isStunned == true and self.isDead == false then
        showTxt(self.name .. " est étourdit et ne peut plus attaquer", 300, 150)
    end
end

return Character