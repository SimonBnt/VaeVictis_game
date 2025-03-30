local Control = {}

Control.keys = {
    left = false,
    right = false,
    leftReleased = true,
    rightReleased = true
}

function Control.keyPressed(key)
    if key == "left" then
        Control.keys.left = true
    elseif key == "right" then
        Control.keys.right = true
    elseif key == "escape" then
        love.event.quit()
    end
end

function Control.keyReleased(key)
    if key == "left" then
        Control.keys.left = false
    elseif key == "right" then
        Control.keys.right = false
    elseif key == "escape" then
        love.event.quit()
    end
end

function Control.isDown(direction)
    -- dans skillTree
    return Control.keys[direction] or false
end

function Control.loadFunction()
    function love.keypressed(key)
        Control.keyPressed(key)
    end
    
    function love.keyreleased(key)
        Control.keyReleased(key)
    end

    -- function love.mousepressed(x, y, button)
    --     if button == 1 then
    --         SkillTree:handleMouseClick(x, y)
    --     end
    -- end
end

return Control
