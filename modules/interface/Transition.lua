local GameState = require("modules.gamestate.GameState")

local Transition = {}

Transition.active = false
Transition.alpha = 0
Transition.duration = 0.5 -- durée du fade in/out en secondes
Transition.timer = 0
Transition.phase = "in"   -- "in" (noirci), "out" (dévoile)
Transition.nextState = nil
Transition.onSwitch = nil -- callback à exécuter au switch de state

function Transition:start(nextState, onSwitch)
    self.active = true
    self.alpha = 0
    self.timer = 0
    self.phase = "in"
    self.nextState = nextState
    self.onSwitch = onSwitch or nil
end

function Transition:update(dt)
    if self.active then
        self.timer = self.timer + dt
        local t = math.min(self.timer / self.duration, 1)
        if self.phase == "in" then
            self.alpha = t
            if t >= 1 then
                if self.onSwitch then self.onSwitch() end
                if self.nextState then GameState:set(self.nextState) end
                self.phase = "out"
                self.timer = 0
            end
        else -- "out"
            self.alpha = 1 - t
            if t >= 1 then
                self.active = false
                self.timer = 0
            end
        end
    end
end

function Transition:draw()
    if self.active then
        love.graphics.setColor(0, 0, 0, self.alpha)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return Transition