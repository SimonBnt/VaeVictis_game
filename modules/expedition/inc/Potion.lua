local Item = require("modules.expedition.Item")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager

resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local Potion = {
    healthPotion = Item:new({
        n = "Health potion", 
        d = "Restores a small amount of health.", 
        w = 0.4, 
        isU = true, 
        e = 10, 
        isD = true, 
        pX = 20, 
        pY = 320
    }),
    manaPotion = Item:new({
        n = "Mana potion", 
        d = "Restores a small amount of mana.", 
        w = 0.4, 
        isU = true, 
        e = 20, 
        isD = true, 
        pX = 42, 
        pY = 320
    }),
}

function Potion.draw()
    spriteManager:drawSpriteCentered("healthPotion", Potion.healthPotion.pX, Potion.healthPotion.pY, 1,1)
    spriteManager:drawSpriteCentered("manaPotion", Potion.manaPotion.pX, Potion.manaPotion.pY, 1,1)
end

return Potion