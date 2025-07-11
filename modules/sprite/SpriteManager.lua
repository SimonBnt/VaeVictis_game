local SpriteManager = {}
SpriteManager.__index = SpriteManager

function SpriteManager:new(resources)
    local instance = setmetatable({}, self)

    instance.resources = resources  -- Lien avec le module Resources
    instance.animations = {}       -- Table pour stocker les animations

    return instance
end

-- Fonction pour découper une spritesheet en quads

function SpriteManager:createQuads(imageKey, frameWidth, frameHeight)
    local imageData = self.resources:getImage(imageKey)
    local quads = {}
    local imageWidth = imageData:getWidth()
    local imageHeight = imageData:getHeight()

    -- Découpage des quads (une table contenant les frames)

    for y = 0, (imageHeight / frameHeight) - 1 do
        for x = 0, (imageWidth / frameWidth) - 1 do
            local quad = love.graphics.newQuad(
                x * frameWidth, y * frameHeight, -- Position dans la spritesheet
                frameWidth, frameHeight,        -- Taille du frame
                imageWidth, imageHeight         -- Dimensions de l'image
            )

            table.insert(quads, quad)
        end
    end

    return quads
end

-- Ajoute une animation

function SpriteManager:addAnimation(name, imageKey, frameWidth, frameHeight, frameDuration)
    local quads = self:createQuads(imageKey, frameWidth, frameHeight)

    self.animations[name] = {
        quads = quads,
        imageKey = imageKey,
        frameDuration = frameDuration,
        elapsedTime = 0,
        currentFrame = 1
    }
end

-- Met à jour l'animation (appelé dans love.update)

function SpriteManager:updateAnimation(name, dt)
    local animation = self.animations[name]

    if animation then
        animation.elapsedTime = animation.elapsedTime + dt

        if animation.elapsedTime >= animation.frameDuration then
            animation.elapsedTime = animation.elapsedTime - animation.frameDuration
            animation.currentFrame = animation.currentFrame + 1

            if animation.currentFrame > #animation.quads then
                animation.currentFrame = 1
            end
        end
    end
end

function SpriteManager:drawSpriteCentered(imageKey, x, y, scaleX, scaleY)
    local image = self.resources:getImage(imageKey)
    
    -- Calculer l'offset pour centrer l'image
    local offsetX = image:getWidth() / 2
    local offsetY = image:getHeight() / 2
    
    -- Dessiner l'image centrée
    love.graphics.draw(
        image, 
        x - offsetX, 
        y - offsetY, 
        0, 
        scaleX or 1, 
        scaleY or 1
    )
end

-- Dessine une animation (appelé dans love.draw)

function SpriteManager:drawAnimation(name, x, y, scaleX, scaleY)
    local animation = self.animations[name]

    if animation then
        local quad = animation.quads[animation.currentFrame]
        local image = self.resources:getImage(animation.imageKey)

        love.graphics.draw(image, quad, x, y, 0, scaleX or 1, scaleY or 1)
    end
end

return SpriteManager
