local Coin = {}

local spriteManager

function Coin:load(manager)
    spriteManager = manager
end

function Coin:update(dt)
    if spriteManager then
        spriteManager:updateAnimation("coinAnimation", dt)
    end
end

function Coin.draw()
    if spriteManager then
        spriteManager:drawAnimation("coinAnimation", 0, 0)
    end
end

return Coin
