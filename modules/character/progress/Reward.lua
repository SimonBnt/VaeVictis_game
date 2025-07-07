local ShowTxt = require("modules.interface.ShowTxt")
local Item = require("modules.expedition.Item")
local manaShardsByClass = require("modules.expedition.inc.ManaShard")
local Particle = require("modules.interface.Particle")
local Bar = require("modules.character.inc.Bar")
local LevelUp = require("modules.character.progress.LevelUp")
local Potion = require("modules.expedition.inc.Potion")
local Tools = require("modules.expedition.inc.Tools")


local Reward = {}

function Reward.get(character, monster)
    local xpReward = monster.currentXp * monster.lvl
    local coinReward = monster.coin

    character.pendingXp = (character.pendingXp or 0) + xpReward
character.pendingCoin = (character.pendingCoin or 0) + coinReward

    -- Ajout d’un objet dans l’inventaire selon la classe du monstre
    if character.inventory then
        local manaShard = manaShardsByClass[monster.class]
        
        if manaShard then
            character.inventory:addItem(manaShard)
            -- ShowTxt.trigger("Objet obtenu : " .. manaShard, 300, 160)
        end
        
    end

    -- character.inventory:addItem(Potion.healthPotion)
    -- character.inventory:addItem(Potion.manaPotion)
    -- character.inventory:addItem(Tools.bomb)
    -- character.inventory:addItem(Tools.whetstone)
end

function Reward.update(character, dt)
    local xpSpeed = 500    
    local coinSpeed = 10
    
    if character.pendingXp and character.pendingXp >= 0 then
        local xpToAdd = math.min(xpSpeed * dt, character.pendingXp)

        character.currentXp = character.currentXp + xpToAdd
        character.pendingXp = character.pendingXp - xpToAdd
        
        if character.maxXp then
            local percentage = character.currentXp / character.maxXp
            local xpBarEndX = 64 + (Bar.barW * percentage) -- Position X de la fin de la barre
            
            if percentage > 1 then
                Particle:create("circle", 200, 300, -15, 15, -30, -10, 0.4, 1, 0.2, 0.4, xpBarEndX, character.xpStatutBarPosY + 1, 50, true, {0.7, 0.2, 1})
            end
        end
    end
    
    if character.maxXp then
        while character.currentXp >= character.maxXp do
            character.currentXp = character.currentXp - character.maxXp
            LevelUp.trigger(character)
            character.maxXp = character.maxXp + (character.lvl * 100)
        end
    end
    
    if character.pendingCoin and character.pendingCoin > 0 then
        local coinToAdd = math.min(coinSpeed * dt, character.pendingCoin)
        
        character.coin = character.coin + coinToAdd
        character.pendingCoin = character.pendingCoin - coinToAdd
    end
end

return Reward