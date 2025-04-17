local Particle = require("modules.interface.Particle")

local SlashEffect = {}
SlashEffect.__index = SlashEffect

function SlashEffect.trigger(target)
    if not animation then
        local defaultWidth, defaultHeight = 32, 32
        SlashEffect.createEffect(target, defaultWidth, defaultHeight)
        return
    end
    
    SlashEffect.createEffect(target)
end

function SlashEffect.createEffect(target, width, height)
    local startX = target.posX + (width / 2)
    local startY = target.posY - (height / 2)
    
    local endX = target.posX - (width / 2)
    local endY = target.posY + (height / 2)
    
    local dirX = endX - startX
    local dirY = endY - startY
   
    Particle:add(
        "slash",                            -- type
        startX,                             -- posX
        startY,                             -- posY
        dirX * 0.8,                         -- vX (direction x)
        dirY * 0.8,                         -- vY (direction y)
        0,                                  -- gravité
        1,                                  -- durée de vie
        1,                                  -- épaisseur du trait
        true,                               -- fade
        {1, 1, 1}                           -- couleur
    )
   
    -- Particle:create(
    --     "circle",
    --     10, 15,                             -- nombre min/max
    --     -50, 50,                            -- vX min/max
    --     -50, 50,                            -- vY min/max
    --     0.8, 1,                             -- durée de vie min/max
    --     1, 2,                               -- taille min/max
    --     endX, endY,                         -- position
    --     50,                                 -- gravité
    --     true,                               -- fade
    --     {1, 1, 1}                           -- couleur
    -- )
end

return SlashEffect