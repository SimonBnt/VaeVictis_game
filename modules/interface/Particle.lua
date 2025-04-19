local Particle = {}
Particle.__index = Particle
Particle.list = {}

function Particle:add(type, posX, posY, vX, vY, gravity, lifeTime, size, fade, color)
    local particle = {
        type = type,
        posX = posX,
        posY = posY,
        vX = vX,
        vY = vY,
        g = gravity,
        initialLifeTime = lifeTime,
        lifeTime = lifeTime,
        size = size,
        fade = fade,
        color = color or {1, 0, 0}
    }
    table.insert(Particle.list, particle)
end

function Particle:create(type, countMin, countMax, vXMin, vXMax, vYMin, vYMax, lifeTimeMin, lifeTimeMax, sizeMin, sizeMax, posX, posY, gravity, fade, color, direction)
    local particleCount = math.random(countMin, countMax)
    
    -- Si une direction est spécifiée, ajuster les plages de vélocité
    if direction then
        if direction == "up" then
            vYMin = -math.abs(vYMax) -- Force les valeurs négatives (vers le haut)
            vYMax = -math.abs(vYMin)
        elseif direction == "down" then
            vYMin = math.abs(vYMin) -- Force les valeurs positives (vers le bas)
            vYMax = math.abs(vYMax)
        elseif direction == "left" then
            vXMin = -math.abs(vXMax) -- Force les valeurs négatives (vers la gauche)
            vXMax = -math.abs(vXMin)
        elseif direction == "right" then
            vXMin = math.abs(vXMin) -- Force les valeurs positives (vers la droite)
            vXMax = math.abs(vXMax)
        elseif direction == "topleft" then
            vXMin = -math.abs(vXMax)
            vXMax = -math.abs(vXMin)
            vYMin = -math.abs(vYMax)
            vYMax = -math.abs(vYMin)
        elseif direction == "topright" then
            vXMin = math.abs(vXMin)
            vXMax = math.abs(vXMax)
            vYMin = -math.abs(vYMax)
            vYMax = -math.abs(vYMin)
        elseif direction == "bottomleft" then
            vXMin = -math.abs(vXMax)
            vXMax = -math.abs(vXMin)
            vYMin = math.abs(vYMin)
            vYMax = math.abs(vYMax)
        elseif direction == "bottomright" then
            vXMin = math.abs(vXMin)
            vXMax = math.abs(vXMax)
            vYMin = math.abs(vYMin)
            vYMax = math.abs(vYMax)
        end
    end
    
    for i = 1, particleCount do
        local vx = love.math.random(vXMin, vXMax)
        local vy = love.math.random(vYMin, vYMax)
        local lifetime = love.math.random(lifeTimeMin * 100, lifeTimeMax * 100) / 100 -- Pour plus de précision dans le random
        local size = love.math.random(sizeMin * 10, sizeMax * 10) / 10
       
        Particle:add(type, posX, posY, vx, vy, gravity, lifetime, size, fade, color)
    end
end

function Particle:update(dt)
    for i = #Particle.list, 1, -1 do
        local p = Particle.list[i]
        p.lifeTime = p.lifeTime - dt
        if p.lifeTime <= 0 then
            table.remove(Particle.list, i)
        else
            p.posX = p.posX + p.vX * dt
            p.posY = p.posY + p.vY * dt
            p.vY = p.vY + p.g * dt
        end
    end
end

function Particle:draw()
    for _, p in ipairs(Particle.list) do
        if p.fade then
            local alpha = p.lifeTime / p.initialLifeTime
            local color = p.color or {1, 1, 1}
            love.graphics.setColor(color[1], color[2], color[3], alpha)
        else
            local color = p.color or {1, 1, 1}
            love.graphics.setColor(color[1], color[2], color[3], 1)
        end
        if p.type == "circle" then
            love.graphics.circle("fill", p.posX, p.posY, p.size)
        elseif p.type == "slash" then
            -- Calcule la position finale (fin du trait) basée sur la vitesse
            local endX = p.posX + p.vX * (p.lifeTime / p.initialLifeTime) * 2
            local endY = p.posY + p.vY * (p.lifeTime / p.initialLifeTime) * 2
           
            -- Dessine une ligne pour l'effet de tranchant
            love.graphics.setLineWidth(p.size)
            love.graphics.line(p.posX, p.posY, endX, endY)
            love.graphics.setLineWidth(1)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

return Particle