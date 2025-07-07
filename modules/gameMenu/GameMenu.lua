local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")

local resources, spriteManager

resources = Resources:new()
spriteManager = SpriteManager:new(resources)

local GameMenu = {}

local menuFont = love.graphics.newFont(12)

local x = 20 

GameMenu.list = {
    { name = "Lancer la partie", y = 120 },
    { name = "Haut faits",       y = 140 },
    { name = "Codex",            y = 160 },
    { name = "Option",           y = 180 },
    { name = "Quitter",          y = 200 },
}

GameMenu.selected = 1 -- Index du choix actuellement sélectionné

-- Fonction pour afficher la flèche à droite du texte sélectionné
function GameMenu.arrow()
    local choice = GameMenu.list[GameMenu.selected]
    local text = choice.name
    local textX = x
    local textY = choice.y

    local textWidth = menuFont:getWidth(text)
    local textHeight = menuFont:getHeight()

    local arrowX = textX + textWidth + 8
    local arrowY = textY + (textHeight / 2)

    spriteManager:drawSpriteCentered("leftArrow", arrowX, arrowY)
end

function GameMenu.moveUp()
    GameMenu.selected = GameMenu.selected - 1
    if GameMenu.selected < 1 then
        GameMenu.selected = #GameMenu.list -- Boucle tout en bas
    end
end

function GameMenu.moveDown()
    GameMenu.selected = GameMenu.selected + 1
    if GameMenu.selected > #GameMenu.list then
        GameMenu.selected = 1 -- Boucle tout en haut
    end
end

function GameMenu.draw()
    love.graphics.setFont(menuFont)
    for i, choice in ipairs(GameMenu.list) do
        love.graphics.print(choice.name, x, choice.y)
    end
    GameMenu.arrow()
end

return GameMenu