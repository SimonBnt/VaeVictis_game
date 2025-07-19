local STI = require("lib.STI.sti")

local WorldMap = {}

local map = nil

function WorldMap.load()
    if map then return end

    map = STI("assets/img/spriteSheet/worldMap/worldMap.lua")
end

function WorldMap.update(dt)
    if map then map:update(dt) end
end

function WorldMap.draw(heroPos)
    if map then
        map:draw()

        if heroPos then
            local tx, ty = heroPos.x, heroPos.y
            local layer = map.layers[1]
            if layer and layer.data and layer.data[ty] and layer.data[ty][tx] then
                local tile = layer.data[ty][tx]
                local tileSize = map.tilewidth

                love.graphics.setColor(1,1,0,0.5)
                love.graphics.rectangle("line", (tx-1)*tileSize, (ty-1)*tileSize, tileSize, tileSize)
                love.graphics.setColor(1,1,1,1)
            end
        end
    end
end

function WorldMap.getTileAt(col, row, layerName)
    if not map then return nil end
    local layer
    if layerName then
        layer = map.layers[layerName]
    else
        for _, l in ipairs(map.layers) do
            if l.type == "tilelayer" then
                layer = l
                break
            end
        end
    end
    if not layer or not layer.data then return nil end
    if not layer.data[row] then return nil end
    return layer.data[row][col]
end

function WorldMap.getMap()
    return map
end

function WorldMap.draw()
    if map then map:draw() end
end

return WorldMap