local GameTime = {}

GameTime.minutes = 480 -- Commence à 08:00
GameTime.speed = 0.1    -- Minutes par seconde

-- Retourne true si un jour s'est écoulé
function GameTime:update(dt)
    local minutesToAdd = dt * 60 * self.speed
    self.minutes = self.minutes + minutesToAdd

    if self.minutes >= 1440 then
        self.minutes = self.minutes - 1440
        return true -- Un nouveau jour a commencé !
    end

    return false -- Toujours le même jour
end

function GameTime:getTime()
    local totalMinutes = math.floor(self.minutes)
    local hours = math.floor(totalMinutes / 60)
    local minutes = totalMinutes % 60
    return string.format("%02d:%02d", hours, minutes)
end

function GameTime:draw()
    love.graphics.print("Heure : " .. self:getTime(), 280, 0)
end

return GameTime
