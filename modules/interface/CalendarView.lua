local Control = require("modules.control.Control")
local Calendar = require("modules.expedition.Calendar")
local Weather = require("modules.expedition.Weather")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager

resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local CalendarView = {}

CalendarView.page = 1

function CalendarView:draw()
    local days = Calendar:getMonthPage(self.page)
    local m = Calendar.months[self.page]
    
    -- Position et taille de la grille
    local cols, cellSize = 7, 48
    local x0, y0 = 120, 60

    -- Titre du mois
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf(m.name, x0, y0-40, cols*cellSize, "center")

    -- Affichage grille
    for i, day in ipairs(days) do
        local col = ((day.dayOfMonth + Calendar:getFirstWeekday(self.page) - 2) % 7) + 1
        local row = math.floor((day.dayOfMonth + Calendar:getFirstWeekday(self.page) - 2) / 7)
        local x = x0 + (col-1)*cellSize
        local y = y0 + row*cellSize

        -- Case
        love.graphics.setColor(0.5, 0.5, 0.5, 1)
        love.graphics.rectangle("fill", x, y, cellSize, cellSize)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("line", x, y, cellSize, cellSize)

        -- Case du jour courant
        if day.month == Calendar:getCurrentMonth() and day.dayOfMonth == select(2, Calendar:getCurrentMonth()) then
            love.graphics.setColor(0, 0.4, 1, 1)
            love.graphics.rectangle("fill", x, y, cellSize, cellSize)
        end

        -- Numéro du jour
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf(day.dayOfMonth, x, y+4, cellSize, "center")

        -- Icône météo (si tu as la fonction correspondante)
        spriteManager:drawSpriteCentered(day.weather, x+cellSize/2, y+cellSize/2+6, 1,1)
    end
end

-- Fonction utilitaire pour calculer le 1er jour de la semaine du mois (ici dimanche = 1)
function Calendar:getFirstWeekday(monthIndex)
    -- Tu peux adapter pour un vrai calcul de calendrier (ici on fait simple, commence toujours lundi)
    return 1
end

return CalendarView