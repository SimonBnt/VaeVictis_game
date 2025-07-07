local Control = require("modules.control.Control")

local Break = {}

function Break.draw()
    love.graphics.print("Pause", 300, 150)
end

return Break