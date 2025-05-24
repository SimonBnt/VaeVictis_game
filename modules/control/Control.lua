local Control = {}

Control.keys = {
    -- action keys
    z = false,
    q = false,
    s = false,
    d = false,
    zReleased = true,
    qReleased = true,
    sReleased = true,
    dReleased = true,

    -- directional keys
    up = false,
    right = false,
    down = false,
    left = false,
    upReleased = true,
    rightReleased = true,
    downReleased = true,
    leftReleased = true,

    -- interface keys
    space = false,
    spaceReleased = true,
}

function Control.keyPressed(key)
    -- action keys
    if key == "z" then
        Control.keys.z = true
    elseif key == "q" then
        Control.keys.q = true
    elseif key == "s" then
        Control.keys.s = true
    elseif key == "d" then
        Control.keys.d = true
    end

    -- directional keys
    if key == "up" then
        Control.keys.up = true
    elseif key == "right" then
        Control.keys.right = true
    elseif key == "down" then
        Control.keys.down = true
    elseif key == "left" then
        Control.keys.left = true
    end

    -- interface keys
    if key == "escape" then
        love.event.quit()
    end

    if key == "space" then
        Control.keys.space = true
    end
end

function Control.keyReleased(key)
    -- action keys
    if key == "z" then
        Control.keys.z = false
    elseif key == "q" then
        Control.keys.q = false
    elseif key == "s" then
        Control.keys.s = false
    elseif key == "d" then
        Control.keys.d = false
    end

    -- directional keys
    if key == "up" then
        Control.keys.up = false
    elseif key == "right" then
        Control.keys.right = false
    elseif key == "down" then
        Control.keys.down = false
    elseif key == "left" then
        Control.keys.left = false
    end

    -- interface keys

    if key == "space" then
        Control.keys.space = false
    end
end

function Control.load()
    function love.keypressed(key)
        Control.keyPressed(key)
    end
    
    function love.keyreleased(key)
        Control.keyReleased(key)
    end
end

return Control
