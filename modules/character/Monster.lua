---- // ---- MODULES ---- // ---- 

local Character = require("modules.character.Character")
local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")
local MonsterList = require("modules.character.inc.MonsterList")

---- // ---- LOCAL VAR ---- // ---- 

math.randomseed(os.time())

-- local MonsterTypes = {
--     {
--         name = "Skelton",
--         posX = 480,
--         posY = 136,
--         currentHealth = 100,
--         maxHealth = 100,
--         atk = 10,
--         def = 1,
--         spriteKey = "skeleton"
--     },
--     {
--         name = "Rat géant",
--         posX = 480,
--         posY = 196,
--         currentHealth = 50,
--         maxHealth = 50,
--         atk = 5,
--         def = 1,
--         spriteKey = "giantRat"
--     },
--     {
--         name = "Loup",
--         posX = 480,
--         posY = 166,
--         currentHealth = 75,
--         maxHealth = 75,
--         atk = 8,
--         def = 1,
--         spriteKey = "wolf"
--     },
--     {
--         name = "Slime",
--         posX = 480,
--         posY = 206,
--         currentHealth = 60,
--         maxHealth = 60,
--         atk = 6,
--         def = 2,
--         spriteKey = "OldSlime"
--     }
-- }

---- // ---- MONSTER INITIALIZATION ---- // ----
local Monster = {}
Monster.__index = Monster
setmetatable(Monster, Character)

function Monster:new()
    -- local monsterType = MonsterTypes[1]
    -- local throw = math.random(0, 100)
    
    -- if throw <= 20 then
    --     monsterType = MonsterTypes[2]  -- Rat
    -- elseif throw > 20 and throw <= 40 then
    --     monsterType = MonsterTypes[3]  -- Wolf
    -- elseif throw > 40 and throw <= 60 then
    --     monsterType = MonsterTypes[4]  -- Slime
    -- end

    local selectedMonster = MonsterList.F[1] -- par défaut le premier monstre
    local selectedClass

    local classThrow = math.random(1, 100)
    local monsterThrow = math.random(1, 100)

    if classThrow <= 15 then
        -- selectedClass = F
        if monsterThrow <= 10 then
            selectedMonster = MonsterList.F[1]
        elseif monsterThrow > 10 and monsterThrow <= 20 then
            selectedMonster = MonsterList.F[2]
        elseif monsterThrow > 20 and monsterThrow <= 30 then
            selectedMonster = MonsterList.F[3]
        elseif monsterThrow > 30 and monsterThrow <= 40 then
            selectedMonster = MonsterList.F[4]
        elseif monsterThrow > 40 and monsterThrow <= 50 then
            selectedMonster = MonsterList.F[5]
        elseif monsterThrow > 50 and monsterThrow <= 60 then
            selectedMonster = MonsterList.F[6]
        elseif monsterThrow > 60 and monsterThrow <= 70 then
            selectedMonster = MonsterList.F[7]
        elseif monsterThrow > 70 and monsterThrow <= 80 then
            selectedMonster = MonsterList.F[8]
        elseif monsterThrow > 80 and monsterThrow <= 90 then
            selectedMonster = MonsterList.F[9]
        elseif monsterThrow > 90 then
            selectedMonster = MonsterList.F[10]
        end
    elseif classThrow > 15 and classThrow <= 30 then
        -- selectedClass = E
        if monsterThrow <= 10 then
            selectedMonster = MonsterList.E[1]
        elseif monsterThrow > 10 and monsterThrow <= 20 then
            selectedMonster = MonsterList.E[2]
        elseif monsterThrow > 20 and monsterThrow <= 30 then
            selectedMonster = MonsterList.E[3]
        elseif monsterThrow > 30 and monsterThrow <= 40 then
            selectedMonster = MonsterList.E[4]
        elseif monsterThrow > 40 and monsterThrow <= 50 then
            selectedMonster = MonsterList.E[5]
        elseif monsterThrow > 50 and monsterThrow <= 60 then
            selectedMonster = MonsterList.E[6]
        elseif monsterThrow > 60 and monsterThrow <= 70 then
            selectedMonster = MonsterList.E[7]
        elseif monsterThrow > 70 and monsterThrow <= 80 then
            selectedMonster = MonsterList.E[8]
        elseif monsterThrow > 80 and monsterThrow <= 90 then
            selectedMonster = MonsterList.E[9]
        elseif monsterThrow > 90 then
            selectedMonster = MonsterList.E[10]
        end
    elseif classThrow > 30 and classThrow <= 45 then
        -- selectedClass = D
        if monsterThrow <= 10 then
            selectedMonster = MonsterList.D[1]
        elseif monsterThrow > 10 and monsterThrow <= 20 then
            selectedMonster = MonsterList.D[2]
        elseif monsterThrow > 20 and monsterThrow <= 30 then
            selectedMonster = MonsterList.D[3]
        elseif monsterThrow > 30 and monsterThrow <= 40 then
            selectedMonster = MonsterList.D[4]
        elseif monsterThrow > 40 and monsterThrow <= 50 then
            selectedMonster = MonsterList.D[5]
        elseif monsterThrow > 50 and monsterThrow <= 60 then
            selectedMonster = MonsterList.D[6]
        elseif monsterThrow > 60 and monsterThrow <= 70 then
            selectedMonster = MonsterList.D[7]
        elseif monsterThrow > 70 and monsterThrow <= 80 then
            selectedMonster = MonsterList.D[8]
        elseif monsterThrow > 80 and monsterThrow <= 90 then
            selectedMonster = MonsterList.D[9]
        elseif monsterThrow > 90 then
            selectedMonster = MonsterList.D[10]
        end
    elseif classThrow > 45 and classThrow <= 60 then
        -- selectedClass = C
        if monsterThrow <= 10 then
            selectedMonster = MonsterList.C[1]
        elseif monsterThrow > 10 and monsterThrow <= 20 then
            selectedMonster = MonsterList.C[2]
        elseif monsterThrow > 20 and monsterThrow <= 30 then
            selectedMonster = MonsterList.C[3]
        elseif monsterThrow > 30 and monsterThrow <= 40 then
            selectedMonster = MonsterList.C[4]
        elseif monsterThrow > 40 and monsterThrow <= 50 then
            selectedMonster = MonsterList.C[5]
        elseif monsterThrow > 50 and monsterThrow <= 60 then
            selectedMonster = MonsterList.C[6]
        elseif monsterThrow > 60 and monsterThrow <= 70 then
            selectedMonster = MonsterList.C[7]
        elseif monsterThrow > 70 and monsterThrow <= 80 then
            selectedMonster = MonsterList.C[8]
        elseif monsterThrow > 80 and monsterThrow <= 90 then
            selectedMonster = MonsterList.C[9]
        elseif monsterThrow > 90 then
            selectedMonster = MonsterList.C[10]
        end
    elseif classThrow > 60 and classThrow <= 75 then
        -- selectedClass = B
        if monsterThrow <= 10 then
            selectedMonster = MonsterList.B[1]
        elseif monsterThrow > 10 and monsterThrow <= 20 then
            selectedMonster = MonsterList.B[2]
        elseif monsterThrow > 20 and monsterThrow <= 30 then
            selectedMonster = MonsterList.B[3]
        elseif monsterThrow > 30 and monsterThrow <= 40 then
            selectedMonster = MonsterList.B[4]
        elseif monsterThrow > 40 and monsterThrow <= 50 then
            selectedMonster = MonsterList.B[5]
        elseif monsterThrow > 50 and monsterThrow <= 60 then
            selectedMonster = MonsterList.B[6]
        elseif monsterThrow > 60 and monsterThrow <= 70 then
            selectedMonster = MonsterList.B[7]
        elseif monsterThrow > 70 and monsterThrow <= 80 then
            selectedMonster = MonsterList.B[8]
        elseif monsterThrow > 80 and monsterThrow <= 90 then
            selectedMonster = MonsterList.B[9]
        elseif monsterThrow > 90 then
            selectedMonster = MonsterList.B[10]
        end
    elseif classThrow > 75 and classThrow <= 90 then
        -- selectedClass = A
        if monsterThrow <= 10 then
            selectedMonster = MonsterList.A[1]
        elseif monsterThrow > 10 and monsterThrow <= 20 then
            selectedMonster = MonsterList.A[2]
        elseif monsterThrow > 20 and monsterThrow <= 30 then
            selectedMonster = MonsterList.A[3]
        elseif monsterThrow > 30 and monsterThrow <= 40 then
            selectedMonster = MonsterList.A[4]
        elseif monsterThrow > 40 and monsterThrow <= 50 then
            selectedMonster = MonsterList.A[5]
        elseif monsterThrow > 50 and monsterThrow <= 60 then
            selectedMonster = MonsterList.A[6]
        elseif monsterThrow > 60 and monsterThrow <= 70 then
            selectedMonster = MonsterList.A[7]
        elseif monsterThrow > 70 and monsterThrow <= 80 then
            selectedMonster = MonsterList.A[8]
        elseif monsterThrow > 80 and monsterThrow <= 90 then
            selectedMonster = MonsterList.A[9]
        elseif monsterThrow > 90 then
            selectedMonster = MonsterList.A[10]
        end
    elseif classThrow > 90 then
        -- selectedClass = S
        if monsterThrow <= 10 then
            selectedMonster = MonsterList.S[1]
        elseif monsterThrow > 10 and monsterThrow <= 20 then
            selectedMonster = MonsterList.S[2]
        elseif monsterThrow > 20 and monsterThrow <= 30 then
            selectedMonster = MonsterList.S[3]
        elseif monsterThrow > 30 and monsterThrow <= 40 then
            selectedMonster = MonsterList.S[4]
        elseif monsterThrow > 40 and monsterThrow <= 50 then
            selectedMonster = MonsterList.S[5]
        elseif monsterThrow > 50 and monsterThrow <= 60 then
            selectedMonster = MonsterList.S[6]
        elseif monsterThrow > 60 and monsterThrow <= 70 then
            selectedMonster = MonsterList.S[7]
        elseif monsterThrow > 70 and monsterThrow <= 80 then
            selectedMonster = MonsterList.S[8]
        elseif monsterThrow > 80 and monsterThrow <= 90 then
            selectedMonster = MonsterList.S[9]
        elseif monsterThrow > 90 then
            selectedMonster = MonsterList.S[10]
        end
    end

    local monster = Character:new(
        -- monsterType.name,     -- name
        -- monsterType.posX,     -- posX
        -- monsterType.posY,     -- posY
        -- monsterType.currentHealth,  -- currentHealth
        -- monsterType.maxHealth,      -- maxHealth
        -- 100,        -- currentMana
        -- 100,        -- currentEnergy
        -- 10,         -- currentXp
        -- 100,        -- maxXp
        -- monsterType.atk,      -- atk
        -- monsterType.def,      -- def
        -- 1,          -- int
        -- 1,          -- dex
        -- 1,          -- crit
        -- 10,         -- atkSpeed
        -- 1,          -- lvl
        -- 10,         -- coin
        -- true        -- isMonster

    selectedMonster.name,                   -- name
        selectedMonster.posX,               -- posX
        selectedMonster.posY,               -- posY
        selectedMonster.currentHealth,      -- currentHealth
        selectedMonster.maxHealth,          -- maxHealth
        selectedMonster.currentMana,        -- currentMana
        selectedMonster.maxMana,            -- maxMana
        selectedMonster.currentEnergy,      -- currentEnergy
        selectedMonster.maxEnergy,          -- maxEnergy
        selectedMonster.currentXp,          -- currentXp
        selectedMonster.maxXp,              -- maxXp
        selectedMonster.atk,                -- atk
        selectedMonster.def,                -- def
        selectedMonster.int,                -- int
        selectedMonster.dex,                -- dex
        selectedMonster.crit,               -- crit
        selectedMonster.atkSpeed,           -- atkSpeed
        selectedMonster.lvl,                -- lvl
        selectedMonster.coin,               -- coin
        true                                -- isMonster
    )
    
    monster.spriteKey = selectedMonster.spriteKey
    -- monster.spriteKey = monsterType.spriteKey
    
    setmetatable(monster, self)
    monster.monsterAttackTimer = 0
    monster.isPreparingAtk = false
   
    return monster
end

---- // ---- MONSTER FUNCTION ---- // ---- 

function Monster:monsterIsDefeated(hero)
    if monsterDefeated then
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Monster Defeated!", 300, 100)
        love.graphics.print("Hero obtain: " .. hero.currentXp .. " xp", 300, 120)
    end
end

function Monster:monsterDeath(hero)
    self.isDead = true
    hero.currentXp = hero.currentXp + self.currentXp

    if hero.currentXp >= hero.maxXp then
        hero:lvlUp()
    end

    monsterDefeated = true -- Ajout d'une variable pour afficher le message
end

function Monster:monsterAtk(hero, dt, ShowDamageDealtAnimation)
    if self.canAtk and not self.isPreparingAtk then
        self.isPreparingAtk = true
        self.monsterAttackTimer = 0
    end

    if self.isPreparingAtk then
        self.monsterAttackTimer = self.monsterAttackTimer + dt

        if self.monsterAttackTimer >= 1 then
            if hero.isBlocking then
                hero.isBlocking = false -- Reset le blocage après l'attaque
            else
                self.isAttacking = true

                local damage = hero:takeDamage(self.atk, self.def)
                ShowDamageDealtAnimation.trigger(damage, hero.posX, hero.posY)
            end

            self.attackCooldown = 0
            self.isPreparingAtk = false
        end
    end
end

function Monster:isPreparingAtk()
    if monster.isPreparingAtk then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("fill", monster.posX + 16, monster.posY, 4)
        love.graphics.setColor(1, 1, 1)  -- Reset couleur
    end
end

---- // ---- UPDATE MONSTER FUNCTION ---- // ---- 

function Monster:monsterUpdateFunction(hero, ShowDamageDealtAnimation, dt) 
    if monster.isPreparingAtk and monster.monsterAttackTimer < 1 and love.keyboard.isDown("left") then
        if not hero.isBlocking then
            hero.isBlocking = true
        else
            hero.isBlocking = false 
        end
    end

    if monster.canAtk then
        monster:monsterAtk(hero, dt, ShowDamageDealtAnimation)
    end

    if monster.currentHealth <= 0 and not monster.isDead then
        monster:monsterDeath(hero)
        gameState = false  -- Arrêter le jeu après la mort du monstre
    end
end

return Monster
