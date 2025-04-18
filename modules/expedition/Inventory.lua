local Inventory = {}
Inventory.__index = Inventory

function Inventory:new(posX, posY, width, height, radius)
    local self = setmetatable({}, Inventory)

    self.posX = 300
    self.posY = 250
    self.width = 150
    self.height = 100
    self.radius = 4

    self.isFull = false

    self.slot = {}

    return self
end

function Inventory:draw()
    -- Dessiner le fond de l'inventaire
    love.graphics.setColor(0.2, 0.2, 0.2, 0.8)
    love.graphics.rectangle("fill", self.posX, self.posY, self.width, self.height, self.radius)
    
    -- Dessiner la bordure
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.rectangle("line", self.posX, self.posY, self.width, self.height, self.radius)
    
    -- Dessiner les emplacements d'objets
    -- self:drawSlots()
    
    -- Dessiner le titre
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Inventaire", self.posX + 10, self.posY - 20)

    self:drawItems()
end

function Inventory:drawItems()
    love.graphics.setColor(1, 1, 1, 1)
    local x = self.posX + 10
    local y = self.posY + 10
    local lineHeight = 14

    for i, item in ipairs(self.slot) do
        love.graphics.print("- " .. item, x, y + (i - 1) * lineHeight)
    end
end


-- function Inventory:drawSlots()
--     -- Supposons que nous avons une grille de 3x3 emplacements
--     local slotSize = 25
--     local padding = 5
    
--     for row = 0, 2 do
--         for col = 0, 2 do
--             local x = self.posX + padding + (col * (slotSize + padding))
--             local y = self.posY + padding + (row * (slotSize + padding))
            
--             -- Dessiner l'emplacement
--             love.graphics.setColor(0.3, 0.3, 0.3, 1)
--             love.graphics.rectangle("fill", x, y, slotSize, slotSize, 3)
--             love.graphics.setColor(0.6, 0.6, 0.6, 1)
--             love.graphics.rectangle("line", x, y, slotSize, slotSize, 3)
            
--             -- Dessiner l'objet s'il existe à cet emplacement
--             local index = row * 3 + col + 1
--             if self.slot[index] then
--                 self:drawItem(self.slot[index], x, y, slotSize)
--             end
--         end
--     end
-- end

-- function Inventory:drawItem(item, x, y, slotSize)
--     -- Dessiner l'objet (simpliste pour l'exemple)
--     love.graphics.setColor(item.color or {1, 0, 0, 1})
--     love.graphics.rectangle("fill", x + 5, y + 5, slotSize - 10, slotSize - 10)
    
--     -- Afficher le nombre si l'objet est empilable
--     if item.count and item.count > 1 then
--         love.graphics.setColor(1, 1, 1, 1)
--         love.graphics.print(item.count, x + slotSize - 10, y + slotSize - 15)
--     end
-- end

-- function Inventory:addItem(item)
--     -- Vérifier si l'objet existe déjà et est empilable
--     for i, existingItem in ipairs(self.slot) do
--         if existingItem.id == item.id and existingItem.stackable then
--             existingItem.count = existingItem.count + (item.count or 1)
--             return true
--         end
--     end
    
--     -- Trouver un emplacement vide
--     for i = 1, 9 do
--         if not self.slot[i] then
--             self.slot[i] = item
--             if not item.count and item.stackable then
--                 item.count = 1
--             end
--             return true
--         end
--     end
    
--     -- Inventaire plein
--     self.isFull = true
--     return false
-- end

-- function Inventory:useItem(index, target)
--     local item = self.slot[index]
--     if not item then return false end
    
--     -- Utiliser l'objet
--     if item.onUse then
--         local result = item.onUse(target)
        
--         -- Réduire le compteur si empilable
--         if item.stackable then
--             item.count = item.count - 1
--             if item.count <= 0 then
--                 self.slot[index] = nil
--             end
--         else
--             self.slot[index] = nil
--         end
        
--         self.isFull = false
--         return result
--     end
    
--     return false
-- end

return Inventory
