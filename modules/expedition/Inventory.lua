local Potion = require("modules.expedition.inc.Potion")
local Tools = require("modules.expedition.inc.Tools")
local Control = require("modules.control.Control")
local ShowTxt = require("modules.interface.ShowTxt")
local Particle = require("modules.interface.Particle")

local Inventory = {}
Inventory.__index = Inventory

function Inventory:new()
    local self = setmetatable({}, Inventory)

    self.posX = 20
    self.posY = 50
    self.width = 150
    self.height = 100
    self.radius = 4
    self.currentWeight = 0
    self.maxWeight = 100

    self.isFull = false

    self.slot = {}

    self.hotkeys = {
        z = "Health potion",
        q = "Mana potion",
        s = "Bomb",
        d = "Whetstone"
    }

    return self
end

controlList = {
    z = Control.keys.z ,
    q = Control.keys.q,
    s = Control.keys.s,
    d = Control.keys.d,
}

function Inventory:getDisplayableItems()
    return {
        Potion.healthPotion,
        Potion.manaPotion,
        Tools.bomb,
        Tools.whetstone
    }
end

function Inventory:addItem(item)
    if not self.slot[item.n] then
        self.slot[item.n] = {
            data = item,
            count = 1
        }
    else
        self.slot[item.n].count = self.slot[item.n].count + 1
        self.currentWeight = self.currentWeight + item.w
    end
end

function Inventory:drawItemNameInInventory()
    love.graphics.setColor(1, 1, 1, 1)
    local x = self.posX + 10
    local y = self.posY + 10
    local lineHeight = 14
    local i = 0

    for itemName, itemEntry in pairs(self.slot) do
        love.graphics.print("- " .. itemEntry.data.n .. " x" .. itemEntry.count, x, y + i * lineHeight)
        i = i + 1
    end
end

function Inventory:getItemByName(itemName)
    return self.slot[itemName]
end

function Inventory:drawItemCountOnInterface()
    love.graphics.setColor(1, 1, 1, 1)

    for _, item in ipairs(self:getDisplayableItems()) do
        local entry = self:getItemByName(item.n)
        local count = entry and entry.count or 0
        love.graphics.print("x" .. count, item.pX, item.pY)
    end
end

function Inventory:useItem(key, hero, target)
    local itemName = self.hotkeys[key]
    if not itemName then return end

    local entry = self:getItemByName(itemName)
    if entry and entry.count > 0 and entry.data.isU then
        entry.count = entry.count - 1

        -- Apply effect if set
        if entry.data.e then
            if entry.data.n == "Bomb" then
                -- Utiliser currentHealth au lieu de hp
                target.currentHealth = math.max(0, target.currentHealth - entry.data.e)
                Particle:create("circle", 100, 200, -50, 50, -30, 20, 0.2, 1, 1, 4, target.posX, target.posY, 40, true, {1,0.6,0.2}) 
            elseif entry.data.n == "Health potion" then
                hero.currentHealth = math.min(hero.maxHealth, hero.currentHealth + entry.data.e)
                Particle:create("circle", 50, 100, -20, 20, 0, 40, 0.5, 1.5, 1, 3, hero.posX, hero.posY + 32, 20, true, {0,1,0.2}, "up") 
            elseif entry.data.n == "Mana potion" then
                hero.currentMana = math.min(hero.maxMana, hero.currentMana + entry.data.e)
                Particle:create("circle", 50, 100, -20, 20, 0, 40, 0.5, 1.5, 1, 3, hero.posX, hero.posY + 32, 20, true, {0,0.2,1}, "up") 
            elseif entry.data.n == "Whetstone" then
                hero.atk = hero.atk * entry.data.e
                Particle:create("circle", 10, 50, -20, 20, -30, -10, 0.5, 1.5, 1, 3, hero.posX, hero.posY, 40, true, {1,1,1}) 
            end
        end

        -- remove item if none remains
        if entry.count <= 0 then
            self.slot[itemName] = nil
        end

        ShowTxt.trigger("Objet utilisé : " .. entry.data.n, 300, 100)
    else
        ShowTxt.trigger("Aucun " .. itemName .. " à utiliser", 300, 100)
    end
end

function Inventory:handleInput(hero, target)
    for key, itemName in pairs(self.hotkeys) do
        if Control.keys[key] then
            self:useItem(key, hero, target)
            Control.keys[key] = false  -- To avoid spamming every frame
        end
    end
end

function Inventory:draw()
    -- Draw the inventory background
    love.graphics.setColor(0.2, 0.2, 0.2, 0.8)
    love.graphics.rectangle("fill", self.posX, self.posY, self.width, self.height, self.radius)
    
    -- Draw the border
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.rectangle("line", self.posX, self.posY, self.width, self.height, self.radius)
    
    -- Draw the title
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Inventaire", self.posX + 10, self.posY - 20)
    
    -- Draw the maximum weight that the inventory can contain
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(self.currentWeight .. "/" .. self.maxWeight, self.posX, self.posY)
    
    self:drawItemCountOnInterface()
    self:drawItemNameInInventory()
end

return Inventory
