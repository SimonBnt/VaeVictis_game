local GameState = require("modules.gamestate.GameState")
local LoadingScreen = require("modules.interface.LoadingScreen")

local Transition = {}

Transition.active = false
Transition.alpha = 0
Transition.duration = 0.5 -- durée du fade in/out en secondes
Transition.timer = 0
Transition.phase = "in"   -- "in" (noirci), "out" (dévoile)
Transition.nextState = nil
Transition.onSwitch = nil -- callback à exécuter au switch de state

function Transition:start(nextState, loadingFunction, onSwitch)
    self.active = true
    self.alpha = 0
    self.timer = 0
    self.phase = "in"
    self.nextState = nextState
    self.loadingFunction = loadingFunction
    self.onSwitch = onSwitch or nil
end

function Transition:update(dt)
    if self.active then
        self.timer = self.timer + dt
        local t = math.min(self.timer / self.duration, 1)
        if self.phase == "in" then
            self.alpha = t
            if t >= 1 then
                if self.loadingFunction then
                    LoadingScreen:start(self.loadingFunction, function()
                        GameState.current = self.nextState
                        if self.onSwitch then self.onSwitch() end
                        self.phase = "out"
                        self.timer = 0
                        self.loadingFunction = nil
                    end)
                    self.phase = "loading"
                    self.timer = 0
                else
                    if self.onSwitch then self.onSwitch() end
                    if self.nextState then GameState.current = self.nextState end
                    self.phase = "out"
                    self.timer = 0
                end
            end
        elseif self.phase == "loading" then
            LoadingScreen:update(dt)
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
    if self.active and self.phase == "loading" then
        LoadingScreen:draw()
    end
    if self.active and self.phase ~= "loading" then
        love.graphics.setColor(0, 0, 0, self.alpha)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return Transition