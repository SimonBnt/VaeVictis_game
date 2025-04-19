---- // ---- MODULES ---- // ---- 

local Character = require("modules.character.Character")
local MonsterList = require("modules.character.inc.MonsterList")

---- // ---- LOCAL VAR ---- // ---- 

math.randomseed(os.time())

---- // ---- MONSTER INITIALIZATION ---- // ----

local Monster = {}
Monster.__index = Monster
setmetatable(Monster, Character)

function Monster:new()
    local selectedMonster = MonsterList.F[1] -- par défaut le premier monstre

    local throw = math.random(1, 6)

    if throw == 1 then
        selectedMonster = MonsterList.F[1]
    elseif throw == 2 then
        selectedMonster = MonsterList.D[1]
    elseif throw == 3 then
        selectedMonster = MonsterList.D[5]
    elseif throw == 4 then
        selectedMonster = MonsterList.D[6]
    elseif throw == 5 then
        selectedMonster = MonsterList.C[5]
    end

    -- local selectedClass

    -- local classThrow = math.random(1, 100)
    -- local monsterThrow = math.random(1, 100)

    -- if classThrow <= 15 then
    --     -- selectedClass = F
    --     if monsterThrow <= 10 then
    --         selectedMonster = MonsterList.F[1]
    --     elseif monsterThrow > 10 and monsterThrow <= 20 then
    --         selectedMonster = MonsterList.F[2]
    --     elseif monsterThrow > 20 and monsterThrow <= 30 then
    --         selectedMonster = MonsterList.F[3]
    --     elseif monsterThrow > 30 and monsterThrow <= 40 then
    --         selectedMonster = MonsterList.F[4]
    --     elseif monsterThrow > 40 and monsterThrow <= 50 then
    --         selectedMonster = MonsterList.F[5]
    --     elseif monsterThrow > 50 and monsterThrow <= 60 then
    --         selectedMonster = MonsterList.F[6]
    --     elseif monsterThrow > 60 and monsterThrow <= 70 then
    --         selectedMonster = MonsterList.F[7]
    --     elseif monsterThrow > 70 and monsterThrow <= 80 then
    --         selectedMonster = MonsterList.F[8]
    --     elseif monsterThrow > 80 and monsterThrow <= 90 then
    --         selectedMonster = MonsterList.F[9]
    --     elseif monsterThrow > 90 then
    --         selectedMonster = MonsterList.F[10]
    --     end
    -- elseif classThrow > 15 and classThrow <= 30 then
    --     -- selectedClass = E
    --     if monsterThrow <= 10 then
    --         selectedMonster = MonsterList.E[1]
    --     elseif monsterThrow > 10 and monsterThrow <= 20 then
    --         selectedMonster = MonsterList.E[2]
    --     elseif monsterThrow > 20 and monsterThrow <= 30 then
    --         selectedMonster = MonsterList.E[3]
    --     elseif monsterThrow > 30 and monsterThrow <= 40 then
    --         selectedMonster = MonsterList.E[4]
    --     elseif monsterThrow > 40 and monsterThrow <= 50 then
    --         selectedMonster = MonsterList.E[5]
    --     elseif monsterThrow > 50 and monsterThrow <= 60 then
    --         selectedMonster = MonsterList.E[6]
    --     elseif monsterThrow > 60 and monsterThrow <= 70 then
    --         selectedMonster = MonsterList.E[7]
    --     elseif monsterThrow > 70 and monsterThrow <= 80 then
    --         selectedMonster = MonsterList.E[8]
    --     elseif monsterThrow > 80 and monsterThrow <= 90 then
    --         selectedMonster = MonsterList.E[9]
    --     elseif monsterThrow > 90 then
    --         selectedMonster = MonsterList.E[10]
    --     end
    -- elseif classThrow > 30 and classThrow <= 45 then
    --     -- selectedClass = D
    --     if monsterThrow <= 10 then
    --         selectedMonster = MonsterList.D[1]
    --     elseif monsterThrow > 10 and monsterThrow <= 20 then
    --         selectedMonster = MonsterList.D[2]
    --     elseif monsterThrow > 20 and monsterThrow <= 30 then
    --         selectedMonster = MonsterList.D[3]
    --     elseif monsterThrow > 30 and monsterThrow <= 40 then
    --         selectedMonster = MonsterList.D[4]
    --     elseif monsterThrow > 40 and monsterThrow <= 50 then
    --         selectedMonster = MonsterList.D[5]
    --     elseif monsterThrow > 50 and monsterThrow <= 60 then
    --         selectedMonster = MonsterList.D[6]
    --     elseif monsterThrow > 60 and monsterThrow <= 70 then
    --         selectedMonster = MonsterList.D[7]
    --     elseif monsterThrow > 70 and monsterThrow <= 80 then
    --         selectedMonster = MonsterList.D[8]
    --     elseif monsterThrow > 80 and monsterThrow <= 90 then
    --         selectedMonster = MonsterList.D[9]
    --     elseif monsterThrow > 90 then
    --         selectedMonster = MonsterList.D[10]
    --     end
    -- elseif classThrow > 45 and classThrow <= 60 then
    --     -- selectedClass = C
    --     if monsterThrow <= 10 then
    --         selectedMonster = MonsterList.C[1]
    --     elseif monsterThrow > 10 and monsterThrow <= 20 then
    --         selectedMonster = MonsterList.C[2]
    --     elseif monsterThrow > 20 and monsterThrow <= 30 then
    --         selectedMonster = MonsterList.C[3]
    --     elseif monsterThrow > 30 and monsterThrow <= 40 then
    --         selectedMonster = MonsterList.C[4]
    --     elseif monsterThrow > 40 and monsterThrow <= 50 then
    --         selectedMonster = MonsterList.C[5]
    --     elseif monsterThrow > 50 and monsterThrow <= 60 then
    --         selectedMonster = MonsterList.C[6]
    --     elseif monsterThrow > 60 and monsterThrow <= 70 then
    --         selectedMonster = MonsterList.C[7]
    --     elseif monsterThrow > 70 and monsterThrow <= 80 then
    --         selectedMonster = MonsterList.C[8]
    --     elseif monsterThrow > 80 and monsterThrow <= 90 then
    --         selectedMonster = MonsterList.C[9]
    --     elseif monsterThrow > 90 then
    --         selectedMonster = MonsterList.C[10]
    --     end
    -- elseif classThrow > 60 and classThrow <= 75 then
    --     -- selectedClass = B
    --     if monsterThrow <= 10 then
    --         selectedMonster = MonsterList.B[1]
    --     elseif monsterThrow > 10 and monsterThrow <= 20 then
    --         selectedMonster = MonsterList.B[2]
    --     elseif monsterThrow > 20 and monsterThrow <= 30 then
    --         selectedMonster = MonsterList.B[3]
    --     elseif monsterThrow > 30 and monsterThrow <= 40 then
    --         selectedMonster = MonsterList.B[4]
    --     elseif monsterThrow > 40 and monsterThrow <= 50 then
    --         selectedMonster = MonsterList.B[5]
    --     elseif monsterThrow > 50 and monsterThrow <= 60 then
    --         selectedMonster = MonsterList.B[6]
    --     elseif monsterThrow > 60 and monsterThrow <= 70 then
    --         selectedMonster = MonsterList.B[7]
    --     elseif monsterThrow > 70 and monsterThrow <= 80 then
    --         selectedMonster = MonsterList.B[8]
    --     elseif monsterThrow > 80 and monsterThrow <= 90 then
    --         selectedMonster = MonsterList.B[9]
    --     elseif monsterThrow > 90 then
    --         selectedMonster = MonsterList.B[10]
    --     end
    -- elseif classThrow > 75 and classThrow <= 90 then
    --     -- selectedClass = A
    --     if monsterThrow <= 10 then
    --         selectedMonster = MonsterList.A[1]
    --     elseif monsterThrow > 10 and monsterThrow <= 20 then
    --         selectedMonster = MonsterList.A[2]
    --     elseif monsterThrow > 20 and monsterThrow <= 30 then
    --         selectedMonster = MonsterList.A[3]
    --     elseif monsterThrow > 30 and monsterThrow <= 40 then
    --         selectedMonster = MonsterList.A[4]
    --     elseif monsterThrow > 40 and monsterThrow <= 50 then
    --         selectedMonster = MonsterList.A[5]
    --     elseif monsterThrow > 50 and monsterThrow <= 60 then
    --         selectedMonster = MonsterList.A[6]
    --     elseif monsterThrow > 60 and monsterThrow <= 70 then
    --         selectedMonster = MonsterList.A[7]
    --     elseif monsterThrow > 70 and monsterThrow <= 80 then
    --         selectedMonster = MonsterList.A[8]
    --     elseif monsterThrow > 80 and monsterThrow <= 90 then
    --         selectedMonster = MonsterList.A[9]
    --     elseif monsterThrow > 90 then
    --         selectedMonster = MonsterList.A[10]
    --     end
    -- elseif classThrow > 90 then
    --     -- selectedClass = S
    --     if monsterThrow <= 10 then
    --         selectedMonster = MonsterList.S[1]
    --     elseif monsterThrow > 10 and monsterThrow <= 20 then
    --         selectedMonster = MonsterList.S[2]
    --     elseif monsterThrow > 20 and monsterThrow <= 30 then
    --         selectedMonster = MonsterList.S[3]
    --     elseif monsterThrow > 30 and monsterThrow <= 40 then
    --         selectedMonster = MonsterList.S[4]
    --     elseif monsterThrow > 40 and monsterThrow <= 50 then
    --         selectedMonster = MonsterList.S[5]
    --     elseif monsterThrow > 50 and monsterThrow <= 60 then
    --         selectedMonster = MonsterList.S[6]
    --     elseif monsterThrow > 60 and monsterThrow <= 70 then
    --         selectedMonster = MonsterList.S[7]
    --     elseif monsterThrow > 70 and monsterThrow <= 80 then
    --         selectedMonster = MonsterList.S[8]
    --     elseif monsterThrow > 80 and monsterThrow <= 90 then
    --         selectedMonster = MonsterList.S[9]
    --     elseif monsterThrow > 90 then
    --         selectedMonster = MonsterList.S[10]
    --     end
    -- end

    local monster = Character:new(
        selectedMonster.name,               -- name
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
        selectedMonster.lvl,                -- lvl
        selectedMonster.atk,                -- atk
        selectedMonster.def,                -- def
        selectedMonster.int,                -- int
        selectedMonster.dex,                -- dex
        selectedMonster.crit,               -- crit
        selectedMonster.atkSpeed,           -- atkSpeed
        selectedMonster.coin,               -- coin
        selectedMonster.soul,               -- soul
        selectedMonster.class,              -- class
        true                                -- isMonster
    )
    
    monster.spriteKey = selectedMonster.spriteKey
    
    setmetatable(monster, self)
    monster.monsterAttackTimer = 0
   
    return monster
end

return Monster
