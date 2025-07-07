---- // ---- LIBRARY ---- // ---- 

local Push = require("lib.push")

---- // ---- MODULES ---- // ---- 

-- control

local Control = require("modules.control.Control")

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

---- // ---- SCREEN PARAMETERS ---- // ---- 

local virtualWidth, virtualHeight = 640, 320
local windowWidth, windowHeight = love.window.getDesktopDimensions()

---- // ---- LOCAL VAR ---- // ---- 

local resources, spriteManager, exportAllSpriteAnimation
local gameState = true

-- stocker les animations en cour --
damageAnimations = {}
monsterRespawnTimer = 0

                            ---- // ---- LOAD ---- // ---- 

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    Push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {fullscreen = true, vsync = true, resizable = true, pixelperfect = true})

    resources = Resources:new()
    spriteManager = SpriteManager:new(resources)
    exportAllSpriteAnimation = ExportAllSpriteAnimation:new(spriteManager)
    
    gameState = "gamemenu"
    Control.load()

    function love.keypressed(key)
        Control.keyPressed(key)

        -- game menu
        if gameState == "gamemenu" then
            if key == "up" then
                GameMenu.moveUp()
                return
            elseif key == "down" then
                GameMenu.moveDown()
                return
            elseif key == "return" then
                if GameMenu.selected == 1 then
                    gameState = "campfire"
                    CampFire:load(spriteManager)
                elseif GameMenu.selected == 5 then
                    love.event.quit()
                end
                return
            end
        end

        -- campfire
        if gameState == "campfire" then
            if key == "return" then
                gameState = "worldmap"
            end
            return
        end

        -- worldmap
        if gameState == "worldmap" then
            if key == "return" then
                gameState = "expedition"
                hero = Hero:new(inventory)
                monster = Monster:new()
                inventory = Inventory:new()
                Coin:load(spriteManager)
            end
            return
        end

        -- prefightevent
        if gameState == "prefightevent" then
            
        end

        -- expedition
        if gameState == "expedition" then
            -- open calendar
            if key == "c" then
                gameState = "calendar"
                return
            end
            
            -- open inventory
            if key == "i" then
                gameState = "inventory"
                return
            end

            -- trigger break
            if key == "space" then
                gameState = "break"
                return
            end
        end

        -- stop break
        if gameState == "break" then
            if key == "space" then
                gameState = "expedition"
            end
            return
        end

        -- close inventory
        if gameState == "inventory" then
            if key == "i" then
                gameState = "expedition"
            end
            return
        end

        -- calendar pages and close
        if gameState == "calendar" then
            if key == "c" then
                gameState = "expedition"
            end

            if key == "right" then
                CalendarView.page = math.min(CalendarView.page + 1, #Calendar.months)
            elseif key == "left" then
                CalendarView.page = math.max(CalendarView.page - 1, 1)
            end
            return
        end
    end
end

                            ---- // ---- UPDATE ---- // ---- 

function love.update(dt)
    if gameState == "campfire" then
        Paralax:update(dt)
        CampFire:update(dt)
    elseif gameState == "expedition" then
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

---- // ---- START TO DRAW ---- // ---- 

    if gameState == "gamemenu" then
        GameMenu.draw()
    elseif gameState == "campfire" then
        Paralax:draw()
        CampFire.draw()
    elseif gameState == "worldmap" then
        WorldMap.draw()
    elseif gameState == "expedition" then
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
    elseif gameState == "break" then
        Break.draw()
    elseif gameState == "calendar" then
        CalendarView:draw()
    elseif gameState == "inventory" then
        inventory:draw()
    end

---- // ---- PUSH FINISH ---- // ---- 

    Push:finish()
end
