local Item = require("modules.expedition.Item")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager

resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local Tools = {
    bomb = Item:new("Bomb", "Deals heavy explosive damage.", 2, true, 40, true, 64, 320),
    whetstone = Item:new("Whetstone", "Sharpen your weapon.", 1, true, 1.25, true, 96, 320),
}

function Tools.draw()
    spriteManager:drawSpriteCentered("bomb", Tools.bomb.posX, Tools.bomb.posY, 1,1)
    spriteManager:drawSpriteCentered("whetstone", Tools.whetstone.posX, Tools.whetstone.posY, 1,1)
end

return Tools