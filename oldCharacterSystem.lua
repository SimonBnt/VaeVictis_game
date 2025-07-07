function Character:performAtk(target, dt, ShowDamageDealtAnimation)
    if self.isMonster then
        self:performMonsterAttack(target, dt, ShowDamageDealtAnimation)
    else
        self:performHeroAttack(target, dt, ShowDamageDealtAnimation)
    end
end

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


---- // ---- CHARCATER UPDATE FUNCTION GLOBAL CALL ---- // ---- 

function Character:update(target, dt, ShowDamageDealtAnimation)
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

    
end