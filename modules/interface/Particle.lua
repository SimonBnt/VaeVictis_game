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

function Particle:create(type, countMin, countMax, vXMin, vXMax, vYMin, vYMax, lifeTimeMin, lifeTimeMax, sizeMin, sizeMax, posX, posY, gravity, fade, color)
    local particleCount = math.min(countMin, countMax)

    for i = 1, particleCount do
        local vx = love.math.random(vXMin, vXMax)
        local vy = love.math.random(vYMin, vYMax)
        local lifetime = love.math.random(lifeTimeMin, lifeTimeMax)
        local size = love.math.random(sizeMin, sizeMax)
        
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
