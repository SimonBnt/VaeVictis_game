local Control = require("modules.control.Control")

local Break = {}

function Break.trigger(gameState)
    if gameState == "gameIsRunning" then
        gameState = "break"
    elseif gameState == "break" then
        gameState = "gameIsRunning"
    end

    return gameState
end

function Break.draw()
    love.graphics.print("Pause", 300, 150)
end

return Break