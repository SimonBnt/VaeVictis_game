local Item = require("modules.expedition.Item")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager

resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local Potion = {
    healthPotion = Item:new("Health potion", "Restores a small amount of health.", 0.4, false, 20, true, 32, 320),
}

function Potion.drawHealthPotion()
    spriteManager:drawSpriteCentered("healthPotion", Potion.healthPotion.posX, Potion.healthPotion.posY, 1,1)
end

return Potion