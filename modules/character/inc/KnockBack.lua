local KnockBack = {}

function KnockBack.trigger(target)
    target.knockbackOriginX = target.posX

    if target.isMonster then
        target.velocityX = 20
    else
        target.velocityX = -20
    end

    target.knockbackTimer = 0.8
    target.isReturningFromKnockback = false
end

function KnockBack.update(target, dt)
    if target.knockbackTimer > 0 then
        target.posX = target.posX + target.velocityX * dt
        target.knockbackTimer = target.knockbackTimer - dt

        -- gradually slow down the velocity
        target.velocityX = target.velocityX * 0.9

        if target.knockbackTimer <= 0 then
            target.knockbackTimer = 0
            target.isReturningFromKnockback = true
        end
    end
    
    if target.isReturningFromKnockback then
        local speed = 20
        local direction = target.knockbackOriginX - target.posX
    
        if math.abs(direction) < 1 then
            target.posX = target.knockbackOriginX
            target.isReturningFromKnockback = false
            target.knockbackOriginX = nil
        else
            target.posX = target.posX + direction * dt * speed
        end
    end
end

return KnockBack