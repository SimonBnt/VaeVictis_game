---- // ---- MODULES ---- // ---- 

local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")
local ShowTxt = require("modules.interface.ShowTxt")
local Particle = require("modules.interface.Particle")
local SlashEffect = require("modules.interface.SlashEffect")
local SpriteManager = require("modules.sprite.SpriteManager")
local Item = require("modules.expedition.Item")
local manaShardsByClass = require("modules.expedition.inc.ManaShard")
local Potion = require("modules.expedition.inc.Potion")

---- // ---- LOCAL VAR ---- // ---- 

local font = love.graphics.newFont(10)
local lvlFont = love.graphics.newFont(8)
local statutBarWitdh = 64

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
    self.canPerformHeavyAtk = isMonster and nil or false

    self.isStunned = false
    self.isAboutToAtk = isMonster and false or nil
    
    self.hasParried = false
    
    self.healthStatutBarPosY = 4
    self.manaStatutBarPosY = 10
    self.energyStatutBarPosY = 16
    self.xpStatutBarPosY = 22
    
    self.energyUsedByAtk = 20
    self.energyUsedByTakingAtk = 10
    self.energyUsedByMissingParry = 40

    -- Timers
    self.parryCooldown = 0
    self.monsterAttackTimer = isMonster and 0 or 0
    self.stunTimer = 0
    self.heavyAtkTimer = 0

    return self
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

    if not self.isMonster then
        math.floor(self:showCoinInPocket())
    end

    if self.isMonster and self.isAboutToAtk and self.currentEnergy >= self.energyUsedByAtk then
        self:isPreparingAtk()
    end
end

function Character:drawSpec()
    love.graphics.print("xp : " .. self.currentXp, 20, 120)
    love.graphics.print("maxXp : " .. self.maxXp, 20, 130)
    love.graphics.print("maxHealth : " .. self.maxHealth, 20, 140)
    love.graphics.print("maxMana : " .. self.maxMana, 20, 150)
    love.graphics.print("maxEnergy : " .. self.maxEnergy, 20, 160)
    love.graphics.print("atk : " .. self.atk, 20, 170)
    love.graphics.print("def : " .. self.def, 20, 180)
    love.graphics.print("int : " .. self.int, 20, 190)
    love.graphics.print("dex : " .. self.dex, 20, 200)
    love.graphics.print("crit : " .. self.crit, 20, 210)
    love.graphics.print("attackSpedd : " .. self.atkSpeed, 20, 220)
end

---- // ---- CHARCATER STATUT FUNCTION ---- // ---- 

function Character:useEnergy(amount)
    self.currentEnergy = math.max(0, self.currentEnergy - amount)
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

    Particle:create("circle", 10, 100, -50, 50, -80, -20, 0.5, 1.5, 1, 4, self.posX, self.posY, 100, true, {1,0,0})

    return damage
end

function Character:stun(target)
    target.isStunned = true
    target.stunTimer = 8 -- par défaut 8 secondes
    target.currentEnergy = 10
    ShowTxt.trigger(target.name .. " est étourdit", 200, 100)
end

function Character:updateStunState(target ,dt)
    if target.isStunned then
        target.stunTimer = target.stunTimer - dt

        if target.stunTimer <= 0 then
            target.isStunned = false
            target.stunTimer = 0
            ShowTxt.trigger(target.name .. " n'est plus étourdit", 200, 100)
        end
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

    Particle:create("circle", 800, 1000, -50, 50, -80, -20, 0.5, 1.5, 0.2, 1, self.posX, self.posY, 100, true, {1,1,0})
end

---- // ---- CHARCATER BATTLE FUNCTION ---- // ---- 

-- Fonction publique qui gère l'attaque en fonction du type de personnage
function Character:performAtk(target, dt, ShowDamageDealtAnimation)
    if self.isMonster then
        self:performMonsterAttack(target, dt, ShowDamageDealtAnimation)
    else
        self:performHeroAttack(target, dt, ShowDamageDealtAnimation)
    end
end

-- Gestion de l'attaque pour le héros
function Character:performHeroAttack(target, dt, ShowDamageDealtAnimation)
    if target.currentHealth <= 0 then
        return
    end
    
    -- Priorité à l'attaque lourde si disponible
    if self.canPerformHeavyAtk and self.canAtk then
        self:heavyAttack(target, ShowDamageDealtAnimation)
        self.canAtk = false
        self.canFightBack = false
        self.canPerformHeavyAtk = false
        return
    end
    
    -- Sinon, vérifier l'attaque normale ou contre-attaque
    if self.canAtk and self.currentEnergy >= self.energyUsedByAtk then
        if self.canCounterAtk then
            self:counterAttack(target, ShowDamageDealtAnimation)
        else
            self:normalAttack(target, ShowDamageDealtAnimation)
        end
        self.canAtk = false
        self.canFightBack = false
        return
    end
    
    -- Si aucune attaque normale n'est disponible, vérifier la riposte
    if self.canFightBack then
        self:fightBackAtk(target, ShowDamageDealtAnimation)
        self.canFightBack = false
        return
    end
end

-- Attaque normale du héros
function Character:normalAttack(target, ShowDamageDealtAnimation)
    -- self.isAttacking = true
    self.attackCooldown = 0

    self:useEnergy(self.energyUsedByAtk)

    if not target.isStunned then
        target:useEnergy(target.energyUsedByTakingAtk)
    end

    local damage = target:takeDamage(self.atk, target.def)
    ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

    ShowTxt.trigger("Vous attaquez " .. target.name, 200, 0)

    local animationName = target.isMonster and "monster_idle" or "hero_idle"
    SlashEffect.trigger(target, self.SpriteManager, animationName)

    if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
        self:stun(target)
    end

    -- if target.currentHealth <= 0 then
    --     target.isDead = true
    --     self:getReward(target)
    -- end
end

-- Attaque lourde du héros
function Character:heavyAttack(target, ShowDamageDealtAnimation)
    self.isAttacking = true
    self.attackCooldown = 0

    if not target.isStunned then
        target:useEnergy(target.energyUsedByTakingAtk)
    end

    local damage = target:takeDamage((self.atk * 3), target.def)
    ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

    ShowTxt.trigger("Vous ripostez et frappez " .. target.name .. " de tout votre force !", 200, 0)

    if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
        self:stun(target)
    end

    -- if target.currentHealth <= 0 then
    --     target.isDead = true
    --     self:getReward(target)
    -- end
end

-- Attaque riposte du héros
function Character:fightBackAtk(target, ShowDamageDealtAnimation)
    local ripostDamage = target.def * 1.5
    local damage = target:takeDamage(ripostDamage, target.def)
    ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

    ShowTxt.trigger("Vous ripostez et frappez " .. target.name, 200, 50)

    if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
        self:stun(target)
    end

    self.isStunned = false
    self.canFightBack = false

    -- if target.currentHealth <= 0 then
    --     target.isDead = true
    --     ShowTxt.trigger(target.name .. " est mort", 300, 200)
    --     self:getReward(target)
    -- end
end

-- Contre-attaque du héros
function Character:counterAttack(target, ShowDamageDealtAnimation)
    -- self.isAttacking = true
    self.attackCooldown = 0

    local damage = target:takeDamage(self.atk * 2, target.def)
    ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

    ShowTxt.trigger("Vous contre-attaquez et faites d'énormes dégâts à " .. target.name, 200, 50)

    if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
        self:stun(target)
    end

    self.isStunned = false
    self.canCounterAtk = false

    -- if target.currentHealth <= 0 then
    --     target.isDead = true
    --     ShowTxt.trigger(target.name .. " est mort", 300, 200)
    --     self:getReward(target)
    -- end
end

-- Gestion de l'attaque pour le monstre
function Character:performMonsterAttack(target, dt, ShowDamageDealtAnimation)
    if self.canAtk and not self.isAboutToAtk then
        self.isAboutToAtk = true
        self.monsterAttackTimer = 0
    end

    if self.isAboutToAtk then
        self.monsterAttackTimer = self.monsterAttackTimer + dt

        if self.monsterAttackTimer >= 1 then
            if target.hasParried then
                ShowTxt.trigger("Parade !", target.posX + 20, target.posY)
                ShowTxt.trigger("Vous pouvez riposter !", target.posX + 20, target.posY - 20)

                target.canFightBack = true
                target.currentEnergy = math.min(target.currentEnergy + 10, target.maxEnergy)

                if target.isStunned then
                    target.canCounterAtk = true

                    if target.currentEnergy < target.maxEnergy then
                        target.currentEnergy = target.currentEnergy + 40
                    end
                end

                target.hasParried = false
                self:resetMonsterAttack()

                return
            elseif self.currentEnergy >= self.energyUsedByAtk then
                self.isAttacking = true
                self:useEnergy(self.energyUsedByAtk)
        
                if not target.isStunned then
                    target:useEnergy(target.energyUsedByTakingAtk)
                end
        
                local damage = target:takeDamage(self.atk, target.def)
                ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)
        
                if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
                    self:stun(target, 2)
                    self:resetMonsterAttack()
                end
        
                -- if target.currentHealth <= 0 then
                --     target.isDead = true
                --     ShowTxt.trigger(target.name .. " est mort", 300, 200)
                -- end
        
                self:resetMonsterAttack()

                return 
            end
        end
    end
end

function Character:resetMonsterAttack()
    self.attackCooldown = 0
    self.isAboutToAtk = false
    self.monsterAttackTimer = 0
end

function Character:parry(target, dt)
    if self.parryCooldown and self.parryCooldown > 0 then
        self.parryCooldown = self.parryCooldown - dt

        return
    end

    if love.keyboard.isDown("left") then
        if target.isAboutToAtk and target.monsterAttackTimer <= 1 then
            if not self.hasParried then
                self.hasParried = true
            end
        else
            ShowTxt.trigger("Parade ratée !", self.posX + 20, self.posY)
            
            self.hasParried = false
            self.currentEnergy = math.max(0, self.currentEnergy - self.energyUsedByMissingParry)
            self.parryCooldown = 2
        end
    end
end

---- // ---- CHARCATER POST BATTLE FUNCTION ---- // ---- 

function Character:getReward(monster)
    local xpReward = monster.currentXp * monster.lvl
    local coinReward = monster.coin

    self.pendingXp = self.pendingXp or 0 + xpReward
    self.pendingCoin = self.pendingCoin or 0 + coinReward

    -- Ajout d’un objet dans l’inventaire selon la classe du monstre
    if self.inventory then
        local manaShard = manaShardsByClass[monster.class]
        
        if manaShard then
            self.inventory:addItem(manaShard)
            -- ShowTxt.trigger("Objet obtenu : " .. manaShard, 300, 160)
        end
        
    end

    self.inventory:addItem(Potion.healthPotion)
end

function Character:updateReward(dt)
    local xpSpeed = 500    
    local coinSpeed = 10
    
    if self.pendingXp and self.pendingXp >= 0 then
        local xpToAdd = math.min(xpSpeed * dt, self.pendingXp)

        self.currentXp = self.currentXp + xpToAdd
        self.pendingXp = self.pendingXp - xpToAdd
        
        if self.maxXp then
            local percentage = self.currentXp / self.maxXp
            local xpBarEndX = 64 + (statutBarWitdh * percentage) -- Position X de la fin de la barre
            
            if percentage > 1 then
                Particle:create("circle", 200, 300, -15, 15, -30, -10, 0.4, 1, 0.2, 0.4, xpBarEndX, self.xpStatutBarPosY + 1, 50, true, {0.7, 0.2, 1})
            end
        end
    end
    
    if self.maxXp then
        while self.currentXp >= self.maxXp do
            self.currentXp = self.currentXp - self.maxXp
            self:lvlUp()
            self.maxXp = self.maxXp + (self.lvl * 100)
        end
    end
    
    if self.pendingCoin and self.pendingCoin > 0 then
        local coinToAdd = math.min(coinSpeed * dt, self.pendingCoin)
        self.coin = self.coin + coinToAdd
        self.pendingCoin = self.pendingCoin - coinToAdd
    end
end

---- // ---- CHARCATER UPDATE FUNCTION ---- // ---- 

function Character:updateAttackCooldown(dt)
    if not self.isStunned then
        self.attackCooldown = math.min((self.attackCooldown + dt * self.atkSpeed), statutBarWitdh) -- Remplissage progressif
        -- si la barre est remplie alors assigne la valeur true à canAtk
        self.canAtk = (self.attackCooldown == statutBarWitdh)
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

function Character:checkIfHeavyAtkIsAvailable(dt)
    if self.canFightBack and self.canAtk then
        if not self.canPerformHeavyAtk then
            self.canPerformHeavyAtk = true
            ShowTxt.trigger("Vous pouvez frapper fort ", 200, 200)
            self.heavyAtkTimer = 0  -- Réinitialiser le timer quand l'opportunité commence
        end
        
        self.heavyAtkTimer = self.heavyAtkTimer + dt
        
        if self.heavyAtkTimer >= 1 then
            self.canPerformHeavyAtk = false
            self.heavyAtkTimer = 0
            ShowTxt.trigger("Vous avez raté l'occasion de frapper fort ", 200, 200)
        end
    else
        -- Si les conditions ne sont plus remplies, désactiver l'attaque lourde
        self.canPerformHeavyAtk = false
    end
end

---- // ---- CHARCATER UPDATE FUNCTION GLOBAL CALL ---- // ---- 

function Character:update(target, dt, ShowDamageDealtAnimation)
    self:updateReward(dt)
    self:updateStunState(target, dt)

    

    if not self.isDead then
        self:updateAttackCooldown(dt)

        if not target.isDead then
            self:updateEnergyBar(dt)
        end

        -- hero
        if not self.isMonster then
            if love.keyboard.isDown("right") then
                self:performAtk(target, dt, ShowDamageDealtAnimation)
            end
            
            self:checkIfHeavyAtkIsAvailable(dt)
            self:parry(target, dt)
        end

        -- monster
        if self.isMonster then
            self:performAtk(target, dt, ShowDamageDealtAnimation)
        end
    end

    if self.isMonster then
        if self.currentHealth <= 0 then
            self.isDead = true
            ShowTxt.trigger(self.name .. " est mort", 300, 200)
            target:getReward(self)
        end
    else
        if self.currentHealth <= 0 then
            self.isDead = true
            ShowTxt.trigger(self.name .. " est mort", 300, 200)
        end
    end
end

---- // ---- CHARCATER DRAW FUNCTION GLOBAL CALL ---- // ---- 

function Character:draw(posX)
    self:drawStatut(posX)
end

return Character