local Paralax = {}

Paralax.assets = {
    sky    = { image = love.graphics.newImage("assets/img/landscape/1.png"), speed = 0.2 },
    mountain = { image = love.graphics.newImage("assets/img/landscape/2.png"), speed = 0.4 },
    fog    = { image = love.graphics.newImage("assets/img/landscape/3.png"), speed = 0.7 },
    ground = { image = love.graphics.newImage("assets/img/landscape/4.png"), speed = 1.0 },
}

-- Wrapping horizontal (repeat) uniquement
for _, layer in pairs(Paralax.assets) do
    layer.image:setWrap("repeat", "clamp")
end

-- Création des quads
for _, layer in pairs(Paralax.assets) do
    layer.quad = love.graphics.newQuad(
        0, 0,
        layer.image:getWidth() * 3, -- largeur virtuelle
        324,
        layer.image:getWidth(),
        layer.image:getHeight()
    )
end

Paralax.scrolling = 0
Paralax.scrollingSpeed = 20

function Paralax.update(dt)
    Paralax.scrolling = Paralax.scrolling - Paralax.scrollingSpeed * dt
end

function Paralax.draw()
    local w = Paralax.assets.sky.image:getWidth()
    local localScroll = (Paralax.scrolling * Paralax.assets.sky.speed) % w

    love.graphics.draw(Paralax.assets.sky.image, Paralax.assets.sky.quad, -localScroll, y)

    for _, layer in ipairs({ Paralax.assets.mountain, Paralax.assets.fog, Paralax.assets.ground }) do
        
        -- on module par la largeur de l'image pour un wrap fluide
        love.graphics.draw(layer.image, layer.quad, 0, 0)
    end
end

return Paralax