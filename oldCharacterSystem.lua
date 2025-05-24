function Character:takeDamage(atk, def)
    atkThrow = math.random(1, 10)
    defThrow = math.random(1,10)
    attack = atkThrow + atk
    defence = defThrow + def
    damage = math.max(0, attack - defence)

    if self.currentHealth > 0 then
        self.currentHealth = math.max(0, self.currentHealth - damage)

        self.knockbackOriginX = self.posX

        if self.isMonster then
            self.velocityX = 20
        else
            self.velocityX = -20
        end

        self.knockbackTimer = 0.8
        self.isReturningFromKnockback = false
    end

    Particle:create("circle", 5, 20, -50, 50, -50, 20, 0.5, 1.5, 1, 4, self.posX, self.posY, 100, true, {1,0,0})
    return damage
end

function Character:updateKnockBackTimer(dt)
    if self.knockbackTimer > 0 then
        self.posX = self.posX + self.velocityX * dt
        self.knockbackTimer = self.knockbackTimer - dt

        -- gradually slow down the velocity
        self.velocityX = self.velocityX * 0.9

        if self.knockbackTimer <= 0 then
            self.knockbackTimer = 0
            self.isReturningFromKnockback = true
        end
    end
    
    if self.isReturningFromKnockback then
        local speed = 20
        local direction = self.knockbackOriginX - self.posX
    
        if math.abs(direction) < 1 then
            self.posX = self.knockbackOriginX
            self.isReturningFromKnockback = false
            self.knockbackOriginX = nil
        else
            self.posX = self.posX + direction * dt * speed
        end
    end
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
    self:useEnergy(self.energyUsedByAtk)

    if not target.isStunned then
        target:useEnergy(target.energyUsedByTakingAtk)
    end

    local damage = target:takeDamage(self.atk, target.def)
    ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

    local animationName = target.isMonster and "monster_idle" or "hero_idle"
    SlashEffect.trigger(target, self.SpriteManager, animationName)

    if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
        self:stun(target)
    end
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
end

-- Contre-attaque du héros
function Character:counterAttack(target, ShowDamageDealtAnimation)
    self.attackCooldown = 0

    local damage = target:takeDamage(self.atk * 2, target.def)
    ShowDamageDealtAnimation.trigger(damage, target.posX, target.posY)

    ShowTxt.trigger("Vous contre-attaquez et faites d'énormes dégâts à " .. target.name, 200, 50)

    if not target.isDead and target.currentEnergy <= target.energyUsedByTakingAtk and not target.isStunned then
        self:stun(target)
    end

    self.isStunned = false
    self.canCounterAtk = false
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

    if Control.keys.left then
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

    -- self.inventory:addItem(Potion.healthPotion)
    -- self.inventory:addItem(Potion.manaPotion)
    -- self.inventory:addItem(Tools.bomb)
    -- self.inventory:addItem(Tools.whetstone)
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



---- // ---- CHARCATER UPDATE FUNCTION GLOBAL CALL ---- // ---- 

function Character:update(target, dt, ShowDamageDealtAnimation)
    self:updateReward(dt)
    self:updateStunState(target, dt)
    self:updateKnockBackTimer(dt)

    if not self.isDead then
        self:updateAttackCooldown(dt)

        if not target.isDead then
            self:updateEnergyBar(dt)
        end

        -- hero
        if not self.isMonster then
            if Control.keys.right then
                -- 1) Passe à l’attaque suivante si la liste n’est pas vide
                if #self.availableAtkList > 0 then
                    self.atkIndex = (self.atkIndex % #self.availableAtkList) + 1

                    -- si on atteint la fin de la liste alors on reset attackCooldown
                    self.attackCooldown = 0

                    self.currentAttack = self.availableAtkList[self.atkIndex]
                end

                -- 2) (optionnel) Lance l’attaque actuelle
                if self.currentAttack then
                    -- self:performHeroAttack(target, dt, ShowDamageDealtAnimation)
                end
            end
            
            if self.inventory then
                self.inventory:handleInput(self, target)
            end

            -- self:parry(target, dt)
        end

        -- monster
        if self.isMonster then
            -- self:performAtk(target, dt, ShowDamageDealtAnimation)
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