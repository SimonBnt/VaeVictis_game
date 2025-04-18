local Item = {}
Item.__index = Item

function Item:new(name, description, weight, isUsable, effect, isDisplayable, posX, posY)
    local self = setmetatable({}, Item)

    self.name = name
    self.description = description
    self.weight = weight

    self.isUsable = isUsable
    self.effect = isUsable and effect or nil

    self.isDisplayable = isDisplayable
    self.posX = isDisplayable and posX or nil
    self.posY = isDisplayable and posY or nil
    
    return self
end

return Item