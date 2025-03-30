local ShowDamageDealtAnimation = {}
ShowDamageDealtAnimation.__index = ShowDamageDealtAnimation

function ShowDamageDealtAnimation.new(damage, x, y)
    local self = setmetatable({}, ShowDamageDealtAnimation)
    self.damage = damage
    self.x = x
    self.y = y
    self.startY = y + 32     -- Position de référence (le centre du character)
    self.timer = 0
    self.duration = 1.5      -- Durée totale de l'animation (pour ajustements éventuels)
    self.vy = -200           -- Vitesse verticale initiale (vers le haut)
    self.gravity = 600       -- Accélération due à la gravité
    self.vx = 20             -- Vitesse horizontale constante vers la droite
    self.bounceDamping = 0.6 -- Amortissement lors des rebonds
    self.bounces = 3         -- Nombre maximum de rebonds
    self.currentBounce = 0
    self.finished = false
    return self
end

function ShowDamageDealtAnimation:update(dt)
    if self.finished then return end

    self.timer = self.timer + dt

    -- Mise à jour horizontale : déplacement constant vers la droite
    self.x = self.x + self.vx * dt

    -- Mise à jour verticale : effet projectile avec gravité et rebonds
    self.vy = self.vy + self.gravity * dt
    self.y = self.y + self.vy * dt

    -- Gestion des rebonds : lorsque le texte atteint la position de référence
    if self.y >= self.startY then
        self.y = self.startY
        if self.currentBounce < self.bounces then
            self.vy = -self.vy * self.bounceDamping
            self.currentBounce = self.currentBounce + 1
        else
            self.finished = true
        end
    end
end

function ShowDamageDealtAnimation:draw()
    if self.finished then return end
    love.graphics.setColor(1, 0, 0)  -- Texte en rouge pour les dégâts
    love.graphics.print(self.damage, self.x, self.y)
    love.graphics.setColor(1, 1, 1)  -- Réinitialisation de la couleur
end

function ShowDamageDealtAnimation.trigger(damage, x, y)
    local anim = ShowDamageDealtAnimation.new(damage, x, y)
    table.insert(damageAnimations, anim)
end

function ShowDamageDealtAnimation:animationLoop(dt)
    for i = #damageAnimations, 1, -1 do
        local anim = damageAnimations[i]
        anim:update(dt)
        if anim.finished then
            table.remove(damageAnimations, i)
        end
    end
end

function ShowDamageDealtAnimation:drawAnimationLoop()
    for _, anim in ipairs(damageAnimations) do
        anim:draw()
    end
end

return ShowDamageDealtAnimation
