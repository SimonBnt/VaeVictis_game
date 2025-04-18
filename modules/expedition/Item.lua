local Item = {}
Item.__index = Item

function Item:new(name, description, weight, isUsable)
    local self = setmetatable({}, Item)

    self.name = name
    self.description = description
    self.weight = weight

    self.isUsable = isUsable
    
    return self
end

return Item