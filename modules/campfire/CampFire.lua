local CampFire = {}

local spriteManager
local campfireFont = love.graphics.newFont(8)

CampFire.hud = {
    { name = "Inventaire", y = 20 },
    { name = "Carnet", y = 20 },
    { name = "Carte", y = 20 },
    { name = "Calendrier", y = 20 },
    { name = "Cuisiner", y = 20 },
    { name = "Organiser son arsenal", y = 20 },
    { name = "Journal de quete", y = 20 },
}

function CampFire.load(manager)
    spriteManager = manager
end

function CampFire.update(dt)
    if spriteManager then
        spriteManager:updateAnimation("campfireAnimation", dt)
    end
end

function CampFire.draw()
    local startX = 20
    local startY = 20
    local space = 20

    love.graphics.setFont(campfireFont)

    spriteManager:drawSpriteCentered("tent", 340, 260)
    spriteManager:drawSpriteCentered("log", 330, 290)
    spriteManager:drawSpriteCentered("bag", 350, 290)
    spriteManager:drawSpriteCentered("hero", 370, 260)
    
    if spriteManager then
        spriteManager:drawAnimation("campfireAnimation", 417, 260)
    end

    spriteManager:drawSpriteCentered("campfireCooking", 430, 265)

    local x = startX

    for i, choice in ipairs(CampFire.hud) do
        love.graphics.print(choice.name, x, startY)
        x = x + campfireFont:getWidth(choice.name) + space
    end
    
    love.graphics.print("Partir en expedition", 540, 300)
end

return CampFire