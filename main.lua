---- // ---- LIBRARY ---- // ---- 

local Push = require("lib.push")

---- // ---- MODULES ---- // ---- 

local Controls = require("modules.controls.Controls")
local ShowDamageDealtAnimation = require("modules.interface.ShowDamageDealtAnimation")
local Hero = require("modules.character.Hero")
local Monster = require("modules.character.Monster")
local Grid = require("modules.interface.Grid")
local Resources = require("modules.sprite.Resources")
local SpriteManager = require("modules.sprite.SpriteManager")
local ExportAllSpriteAnimation = require("modules.sprite.inc.ExportAllSpriteAnimation")

---- // ---- SCREEN PARAMETERS ---- // ---- 

local virtualWidth, virtualHeight = 640, 360
local windowWidth, windowHeight = love.window.getDesktopDimensions()

---- // ---- LOCAL VAR ---- // ---- 

local resources, spriteManager, exportAllSpriteAnimation
local gameState = true

-- stocker les animations en cour --
damageAnimations = {}

                            ---- // ---- LOAD ---- // ---- 

function love.load()
    -- screen parameter + push setup
    love.graphics.setDefaultFilter("nearest", "nearest")

    Push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {fullscreen = false, vsync = true, resizable = true, pixelperfect = true})

    -- load every resources and modules
    Controls.loadFunction()
    resources = Resources:new()
    spriteManager = SpriteManager:new(resources)

    -- all sprite here
    exportAllSpriteAnimation = ExportAllSpriteAnimation:new(spriteManager)

    -- hero and monster instances initialization
    hero = Hero:new()
    monster = Monster:new()
end

                            ---- // ---- UPDATE ---- // ---- 

function love.update(dt)
    if gameState then
        -- Character update function
        hero:update(monster, dt, ShowDamageDealtAnimation)
        monster:update(hero, dt, ShowDamageDealtAnimation)

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

    -- interface
    Grid.draw()
    spriteManager:drawAnimation("coinAnimation", 0, 0)
    
    -- hero
    hero:draw(64)
    hero:drawSpec()

    -- monster
    monster:draw(512)

    -- draw the hero sprite
    spriteManager:drawSpriteCentered("hero", hero.posX, hero.posY - 4, 2,2)

    -- sprite sheet animation draw function
    local monsterAnimationKey = monster.spriteKey .. "Animation"
    spriteManager:drawAnimation(monsterAnimationKey, monster.posX - 32, monster.posY, 1, 1)

   -- damage animation loop draw function
    ShowDamageDealtAnimation:drawAnimationLoop()

---- // ---- PUSH FINISH ---- // ---- 

    Push:finish()
end
