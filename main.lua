---- // ---- LIBRARY ---- // ---- 

local Push = require("lib.push")

---- // ---- MODULES ---- // ---- 

local Control = require("modules.control.Control")
local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")
local Hero = require("modules.character.Hero")
local Monster = require("modules.character.Monster")
local Grid = require("modules.interface.Grid")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")
local ExportAllSpriteAnimation = require("modules.sprite.inc.ExportAllSpriteAnimation")
local Paralax = require("modules.interface.Paralax")
local Particle = require("modules.interface.Particle")
local Break = require("modules.interface.Break")
local ShowTxt = require("modules.interface.ShowTxt")
local MoveSet = require("modules.interface.MoveSet")
local Inventory = require("modules.expedition.Inventory")
local Potion = require("modules.expedition.inc.Potion")
local Tools = require("modules.expedition.inc.Tools")


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
    gameState = "gameIsRunning"
    -- screen parameter + push setup
    love.graphics.setDefaultFilter("nearest", "nearest")

    Push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {fullscreen = true, vsync = true, resizable = true, pixelperfect = true})

    -- load every resources and modules
    Control.load()
    resources = Resources:new()
    spriteManager = SpriteManager:new(resources)

    -- all sprite here
    exportAllSpriteAnimation = ExportAllSpriteAnimation:new(spriteManager)

    -- inventory
    inventory = Inventory:new()

    -- hero and monster instances initialization
    hero = Hero:new(inventory)
    monster = Monster:new()

    function love.keypressed(key)
        Control.keyPressed(key)

        if key == "space" then
            if gameState == "gameIsRunning" then
                gameState = "break"
            elseif gameState == "break" then
                gameState = "gameIsRunning"
            end
        end
    end
end

                            ---- // ---- UPDATE ---- // ---- 

function love.update(dt)
    if gameState == "gameIsRunning" then
        Paralax.update(dt)

        spriteManager:updateAnimation("heroAnimation", dt)

        -- Character update function
        hero:update(monster, dt, ShowDamageDealtAnimation)

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

        -- animation loop if animation currently in "damageAnimation{}"
        ShowDamageDealtAnimation:animationLoop(dt)

        -- sprite sheet animation update function
        spriteManager:updateAnimation("coinAnimation", dt)

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
    
    -- if Control.keys.space then
    --     gameState = Break.trigger(gameState)
    -- end
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

    -- if gameState == "gameIsRunning" then

        -- interface
        Paralax.draw()
        spriteManager:drawAnimation("coinAnimation", 0, 0)
        Potion.draw()
        Tools.draw()
        MoveSet.draw(hero)
        -- inventory:draw()
        
        -- hero
        hero:draw(64)
        -- hero:drawSpec()
        -- spriteManager:drawAnimation("heroAnimation", hero.posX, hero.posY)

        -- draw the hero sprite
        spriteManager:drawSpriteCentered("hero", hero.posX, hero.posY - 4, 1,1)

        -- monster
        monster:draw(512)

        -- sprite sheet animation draw function
        local monsterAnimationKey = monster.spriteKey .. "Animation"
        spriteManager:drawAnimation(monsterAnimationKey, monster.posX - 32, monster.posY, 1, 1)

        -- damage animation loop draw function
        ShowDamageDealtAnimation:drawAnimationLoop()

        -- Draw particles
        Particle:draw()

        -- Draw active messages
        ShowTxt.draw()

        -- Grid.draw()

    -- elseif gameState == "break" then
    if gameState == "break" then
        Break.draw()
    end

---- // ---- PUSH FINISH ---- // ---- 

    Push:finish()
end
