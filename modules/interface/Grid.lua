-- grid.lua
local Grid = {}

local spacing = 64

function Grid.draw()
    -- On récupère les dimensions de l'écran virtuel (ou réel)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()

    -- Définir une couleur pour la grille (blanc semi-transparent ici)
    love.graphics.setColor(1, 1, 1, 0.3)

    -- Dessiner les lignes verticales
    for x = 0, screenWidth, spacing do
        love.graphics.line(x, 0, x, screenHeight)
    end

    -- Dessiner les lignes horizontales
    for y = 0, screenHeight, spacing do
        love.graphics.line(0, y, screenWidth, y)
    end

    -- Réinitialiser la couleur
    love.graphics.setColor(1, 1, 1, 1)
end

return Grid
