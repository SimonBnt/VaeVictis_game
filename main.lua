---- // ---- LIBRARY ---- // ---- 

local Push = require("lib.PUSH.push")
local STI = require("lib.STI.sti")

---- // ---- MODULES ---- // ---- 

-- control
local Control = require("modules.control.Control")

-- gamestate
local GameState = require ("modules.gamestate.GameState")

-- gamemenu
local GameMenu = require("modules.gameMenu.GameMenu")

-- campfire
local CampFire = require("modules.campfire.CampFire")

-- worldmap
local WorldMap = require("modules.worldMap.WorldMap")

-- character
local Hero = require("modules.character.Hero")
local Monster = require("modules.character.Monster")

-- interface
local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")
local Paralax = require("modules.interface.Paralax")
local Grid = require("modules.interface.Grid")
local Particle = require("modules.interface.Particle")
local Break = require("modules.interface.Break")
local ShowTxt = require("modules.interface.ShowTxt")
local MoveSet = require("modules.interface.MoveSet")
local WeatherTimeline = require("modules.interface.WeatherTimeline")
local CalendarView = require("modules.interface.CalendarView")
local Coin = require("modules.interface.Coin")
local Transition = require("modules.interface.Transition")
local LoadingScreen = require("modules.interface.LoadingScreen")

-- sprite
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")
local ExportAllSpriteAnimation = require("modules.sprite.inc.ExportAllSpriteAnimation")

--  expedition
local Potion = require("modules.expedition.inc.Potion")
local Tools = require("modules.expedition.inc.Tools")
local Inventory = require("modules.expedition.Inventory")
local GameTime = require("modules.expedition.GameTime")
local Calendar = require("modules.expedition.Calendar")
local Quest = require("modules.expedition.Quest")

---- // ---- SCREEN PARAMETERS ---- // ---- 

local virtualWidth, virtualHeight = 640, 360
local windowWidth, windowHeight = love.window.getDesktopDimensions()

---- // ---- LOCAL VAR ---- // ---- 

local resources, spriteManager, exportAllSpriteAnimation

-- stocker les animations en cour --
damageAnimations = {}
monsterRespawnTimer = 0

local worldMapLoaded = false
local heroMapX, heroMapY = 5, 5

                            ---- // ---- LOAD ---- // ---- 

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    Push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {fullscreen = true, vsync = true, resizable = true, pixelperfect = true})

    resources = Resources:new()
    spriteManager = SpriteManager:new(resources)
    exportAllSpriteAnimation = ExportAllSpriteAnimation:new(spriteManager)
    
    GameState.current = "gamemenu"
    Control.load()

    function love.keypressed(key)
        Control.keyPressed(key)

        -- game menu
        if GameState.current == "gamemenu" then
            if key == "up" then
                GameMenu.moveUp()
                return
            elseif key == "down" then
                GameMenu.moveDown()
                return
            elseif key == "return" then
                if GameMenu.selected == 1 then
                    Transition:start("campfire", function(setProgress)
                        for i=1, 20 do
                            setProgress(i/20)
                            coroutine.yield()
                        end
                    end, function()
                        CampFire.load(spriteManager)
                    end)
                elseif GameMenu.selected == 5 then
                    love.event.quit()
                end
                return
            end
        end

        -- loading
        if GameState.current == "loading" then
            
        end

        -- campfire
        if GameState.current == "campfire" then
            if key == "return" then
                Transition:start("worldmap", function(setProgress)
                        for i=1, 20 do
                            setProgress(i/20)
                            coroutine.yield()
                        end
                    end, function()
                        if not worldMapLoaded then
                            WorldMap.load()
                            worldMapLoaded = true
                        end
                    end)
                end
            return
        end

        -- worldmap
        if GameState.current == "worldmap" then
            local oldX, oldY = heroMapX, heroMapY

            if key == "up" then
                heroMapY = math.max(1, heroMapY-1)
            elseif key == "down" then
                heroMapY = math.min(WorldMap.getMap().height, heroMapY+1)
            elseif key == "left" then
                heroMapX = math.max(1, heroMapX-1)
            elseif key == "right" then
                heroMapX = math.min(WorldMap.getMap().width, heroMapX+1)
            elseif key == "return" then
                Transition:start("expedition", function(setProgress)
                        for i=1, 20 do
                            setProgress(i/20)
                            coroutine.yield()
                        end
                    end, function()
                        hero = Hero:new(inventory)
                        monster = Monster:new()
                        inventory = Inventory:new()
                        Coin:load(spriteManager)
                    end)
                end

                local map = WorldMap.getMap()

                -- if map then
                --     local tileCave = WorldMap.getTileAt(heroMapX, heroMapY, "cave")
                --     local tileVillage = WorldMap.getTileAt(heroMapX, heroMapY, "house") -- ou layer "village" si tu as une couche dédiée
                --     if tileCave and tileCave.id > 0 then
                --         GameState.current = "cave"
                --         -- Tu pourras charger une nouvelle map ici
                --         return
                --     elseif tileVillage and tileVillage.id > 0 then
                --         GameState.current = "village"
                --         -- Charger une nouvelle map village ici
                --         return
                --     end
                -- end
            return
        end

        -- prefightevent
        if GameState.current == "prefightevent" then
            
            -- choice
            -- trigger choice
        end

        -- expedition
        if GameState.current == "expedition" then
            -- open calendar
            if key == "c" then
                GameState.current = "calendar"
                return
            end
            
            -- open inventory
            if key == "i" then
                GameState.current = "inventory"
                return
            end

            -- trigger break
            if key == "space" then
                GameState.current = "break"
                return
            end
        end

        -- get reward and soul
        -- postFightResultSheet
        -- scene + hero move
        -- loop x 3
        -- worldmap
        -- choose other destination
        -- loop

        -- stop break
        if GameState.current == "break" then
            if key == "space" then
                GameState.current = "expedition"
            end
            return
        end

        -- close inventory
        if GameState.current == "inventory" then
            if key == "i" then
                GameState.current = "expedition"
            end
            return
        end

        -- calendar pages and close
        if GameState.current == "calendar" then
            if key == "c" then
                GameState.current = "expedition"
            end

            if key == "right" then
                CalendarView.page = math.min(CalendarView.page + 1, #Calendar.months)
            elseif key == "left" then
                CalendarView.page = math.max(CalendarView.page - 1, 1)
            end
            return
        end

        -- tableau de résultat de fin d'expedition
    end
end

                            ---- // ---- UPDATE ---- // ---- 

function love.update(dt)
    Transition:update(dt)
    if Transition.active then return end

    if GameState.current == "campfire" then
        Paralax:update(dt)
        CampFire.update(dt)
    elseif GameState.current == "worldmap" then   
        WorldMap.update(dt)
    elseif GameState.current == "expedition" then
        local isNewDay = GameTime:update(dt)
        Calendar:update(isNewDay)
        Paralax:update(dt)
        Coin:update(dt)
        hero:update(monster, dt, ShowDamageDealtAnimation)
        ShowDamageDealtAnimation:animationLoop(dt)

        if monster and monster.isDead then
            monsterRespawnTimer = monsterRespawnTimer + dt
            
            if monsterRespawnTimer >= 2 then
                monsterRespawnTimer = 0
                monster = Monster:new() -- Créer un nouveau monstre
                ShowTxt.trigger("Un " .. monster.name .. " apparaît !", 300, 100)
            end
        else
            monster:update(hero, dt, ShowDamageDealtAnimation)
        end

        -- monsterList
        -- F class monsters
        spriteManager:updateAnimation("giantRat", dt)
        spriteManager:updateAnimation("bat", dt)
        spriteManager:updateAnimation("wisp", dt)
        spriteManager:updateAnimation("manEaterSpider", dt)
        spriteManager:updateAnimation("orbit", dt)
        spriteManager:updateAnimation("leavingMushroom", dt)
        spriteManager:updateAnimation("juvenileSylvester", dt)
        spriteManager:updateAnimation("mutantLarva", dt)
        spriteManager:updateAnimation("spiritInBottle", dt)
        spriteManager:updateAnimation("cursedSkull", dt)

        -- E class monsters
        spriteManager:updateAnimation("grimlin", dt)
        spriteManager:updateAnimation("livingDead", dt)
        spriteManager:updateAnimation("carnivorousPlant", dt)
        spriteManager:updateAnimation("goliathSnail", dt)
        spriteManager:updateAnimation("murloc", dt)
        spriteManager:updateAnimation("brazier", dt)
        spriteManager:updateAnimation("juvenileSlime", dt)
        spriteManager:updateAnimation("ectoplasm", dt)
        spriteManager:updateAnimation("juvenileKraken", dt)
        spriteManager:updateAnimation("leprechaun", dt)

        -- D class monsters
        spriteManager:updateAnimation("wolf", dt)
        spriteManager:updateAnimation("amalgam", dt)
        spriteManager:updateAnimation("giantScorpion", dt)
        spriteManager:updateAnimation("boa", dt)
        spriteManager:updateAnimation("goblin", dt)
        spriteManager:updateAnimation("skeleton", dt)
        spriteManager:updateAnimation("wildBoar", dt)
        spriteManager:updateAnimation("enchantedStump", dt)
        spriteManager:updateAnimation("kobold", dt)
        spriteManager:updateAnimation("warriorToad", dt)

        -- C class monsters
        spriteManager:updateAnimation("ghoul", dt)
        spriteManager:updateAnimation("giantWorm", dt)
        spriteManager:updateAnimation("banshee", dt)
        spriteManager:updateAnimation("witch", dt)
        spriteManager:updateAnimation("slime", dt)
        spriteManager:updateAnimation("revenant", dt)
        spriteManager:updateAnimation("giantWasp", dt)
        spriteManager:updateAnimation("glutton", dt)
        spriteManager:updateAnimation("gnoll", dt)
        spriteManager:updateAnimation("hags", dt)

        -- B class monsters
        spriteManager:updateAnimation("mimic", dt)
        spriteManager:updateAnimation("hobgoblin", dt)
        spriteManager:updateAnimation("failedExperiment", dt)
        spriteManager:updateAnimation("imp", dt)
        spriteManager:updateAnimation("courtesan", dt)
        spriteManager:updateAnimation("mandrake", dt)
        spriteManager:updateAnimation("chimera", dt)
        spriteManager:updateAnimation("swampCreature", dt)
        spriteManager:updateAnimation("sylvester", dt)
        spriteManager:updateAnimation("orc", dt)

        -- A class monsters
        spriteManager:updateAnimation("reaper", dt)
        spriteManager:updateAnimation("ent", dt)
        spriteManager:updateAnimation("vampire", dt)
        spriteManager:updateAnimation("reptilian", dt)
        spriteManager:updateAnimation("abomination", dt)
        spriteManager:updateAnimation("ogre", dt)
        spriteManager:updateAnimation("golem", dt)
        spriteManager:updateAnimation("gorgon", dt)
        spriteManager:updateAnimation("succubus", dt)
        spriteManager:updateAnimation("centaur", dt)

        -- S class monsters
        spriteManager:updateAnimation("griffin", dt)
        spriteManager:updateAnimation("werewolf", dt)
        spriteManager:updateAnimation("raptor", dt)
        spriteManager:updateAnimation("cyclops", dt)
        spriteManager:updateAnimation("wyvern", dt)
        spriteManager:updateAnimation("minotaur", dt)
        spriteManager:updateAnimation("berserker", dt)
        spriteManager:updateAnimation("kraken", dt)
        spriteManager:updateAnimation("troll", dt)
        spriteManager:updateAnimation("demon", dt)

        Particle:update(dt)
        ShowTxt.update(dt)
    end
end

                            ---- // ---- RESIZE CALLBACK ---- // ---- 

function love.resize(w,h)
    Push:resize(w,h)
end                            

                            ---- // ---- DRAW ---- // ---- 

function love.draw()

---- // ---- PUSH START ---- // ---- 

    Push:start()
    -- love.graphics.scale(1,1)
---- // ---- START TO DRAW ---- // ---- 

    if GameState.current == "gamemenu" then
        GameMenu.draw()
    elseif GameState.current == "campfire" then
        Paralax:draw()
        CampFire.draw()
    elseif GameState.current == "worldmap" then
        WorldMap.draw({x = heroMapX, y = heroMapY})

        local map = WorldMap.getMap()

        if map then
            local tileSize = map.tilewidth
            local px = (heroMapX-1) * tileSize + tileSize/2
            local py = (heroMapY-1) * tileSize + tileSize/2
            
            spriteManager:drawSpriteCentered("hero", px, py, 0.5, 0.5)
        end
    elseif GameState.current == "expedition" then
        Paralax:draw()
        GameTime:draw()
        WeatherTimeline.draw(Calendar, GameTime)
        Potion.draw()
        Tools.draw()
        MoveSet.draw(hero)
        Coin.draw()
        Particle:draw()
        ShowDamageDealtAnimation:drawAnimationLoop()
        ShowTxt.draw()
        -- Grid.draw()
        
        hero:draw(64)
        spriteManager:drawSpriteCentered("hero", hero.posX, hero.posY - 4, 1,1)

        monster:draw(512)
        local monsterAnimationKey = monster.spriteKey .. "Animation"
        spriteManager:drawAnimation(monsterAnimationKey, monster.posX - 32, monster.posY, 1, 1)
    elseif GameState.current == "break" then
        Break.draw()
    elseif GameState.current == "calendar" then
        CalendarView:draw()
    elseif GameState.current == "inventory" then
        inventory:draw()
    end

    Transition:draw()

---- // ---- PUSH FINISH ---- // ---- 

    Push:finish()
end
