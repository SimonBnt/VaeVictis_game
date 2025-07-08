local GameState = {}

GameState.current = "gamemenu" 

function GameState:set(newState)
    self.current = newState
end

return GameState