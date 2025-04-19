local Item = require("modules.expedition.Item")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager

resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local Potion = {
    healthPotion = Item:new("Health potion", "Restores a small amount of health.", 0.4, true, 10, true, 20, 320),
    manaPotion = Item:new("Mana potion", "Restores a small amount of mana.", 0.4, true, 20, true, 42, 320),
}

function Potion.draw()
    spriteManager:drawSpriteCentered("healthPotion", Potion.healthPotion.posX, Potion.healthPotion.posY, 1,1)
    spriteManager:drawSpriteCentered("manaPotion", Potion.manaPotion.posX, Potion.manaPotion.posY, 1,1)
end

return Potion