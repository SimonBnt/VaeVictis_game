local Item = require("modules.expedition.Item")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager

resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local Tools = {
    bomb = Item:new({
        n = "Bomb", 
        d = "Deals heavy explosive damage.", 
        w = 2, 
        isU = true, 
        e = 40, 
        isD = true, 
        pX = 64, 
        pY = 300
    }),
    whetstone = Item:new({
        name = "Whetstone", 
        d = "Sharpen your weapon.", 
        w = 1, 
        isU = true, 
        e = 1.25, 
        isD = true, 
        pX = 96, 
        pY = 300
    }),
}

function Tools.draw()
    spriteManager:drawSpriteCentered("bomb", Tools.bomb.pX, Tools.bomb.pY, 1,1)
    spriteManager:drawSpriteCentered("whetstone", Tools.whetstone.pX, Tools.whetstone.pY, 1,1)
end

return Tools