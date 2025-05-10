local Item = {}
Item.__index = Item

-- p = parameters
-- n = name
-- d = description
-- w = weight
-- isU = isUsable
-- e = effect
-- isD = isDisplayable
-- pX = positionX
-- pY = positionY
-- isOTS = isOnlyToSell

-- all parameters not passed are automatically set to nil, unless default parameters are added, in which case those are those which are passed with priority

function Item:new(p)
    local self = setmetatable({}, Item)

    self.n = p.n or "Unknown"
    self.d = p.d or ""
    self.w = p.w or 0

    self.isU = p.isU or false
    self.e = self.isU and p.e or nil

    self.isD = p.isD or false
    self.pX = self.isD and p.pX or nil
    self.pY = self.isD and p.pY or nil

    self.isOTS = p.isOTS or false

    return self
end

return Item