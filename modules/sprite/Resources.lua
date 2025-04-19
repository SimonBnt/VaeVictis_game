local Resources = {}
Resources.__index = Resources

function Resources:new()
    local instance = setmetatable({}, self)
    
    instance.toLoad = {
        -- interface
        coin = "assets/img/spriteSheet/interface/coin_spriteSheet.png",

        -- hero
        hero = "assets/img/sprite/hero/testSamurai_sprite_x64.png",
        -- hero = "assets/img/sprite/hero/testBloodBorne_sprite_x64.png",

        -- Item

        -- consumable

        -- tools

        -- offensive 

        bomb = "assets/img/sprite/item/consumable/tools/offensive/bomb.png",
        
        -- support

        whetstone = "assets/img/sprite/item/consumable/tools/support/whetstone.png",

        -- potion

        healthPotion = "assets/img/sprite/item/consumable/potion/healthPotion.png",
        manaPotion = "assets/img/sprite/item/consumable/potion/manaPotion.png",

        -- monster class
        -- F class
        giantRat = "assets/img/sprite/monster/giantRat.png",
        bat = "assets/img/sprite/monster/bat.jpg",
        wisp = "assets/img/sprite/monster/wisp.png",
        manEaterSpider = "assets/img/sprite/monster/manEaterSpider.jpg",
        orbit = "assets/img/sprite/monster/orbit.jpg",
        leavingMushroom = "assets/img/sprite/monster/leavingMushroom.jpg",
        juvenileSylvester = "assets/img/sprite/monster/juvenileSylvester.jpg",
        mutantLarva = "assets/img/sprite/monster/mutantLarva.jpg",
        spiritInBottle = "assets/img/sprite/monster/spiritInBottle.png",
        cursedSkull = "assets/img/sprite/monster/cursedSkull.png",
        
        -- E class
        grimlin = "assets/img/sprite/monster/grimlin.png",
        livingDead = "assets/img/sprite/monster/livingDead.png",
        carnivorousPlant = "assets/img/sprite/monster/carnivorousPlant.jpg",
        goliathSnail = "assets/img/sprite/monster/goliathSnail.jpg",
        murloc = "assets/img/sprite/monster/murloc.jpg",
        brazier = "assets/img/sprite/monster/brazier.jpg",
        juvenileSlime = "assets/img/sprite/monster/juvenileSlime.jpg",
        ectoplasm = "assets/img/sprite/monster/ectoplasm.png",
        juvenileKraken = "assets/img/sprite/monster/juvenileKraken.png",
        leprechaun = "assets/img/sprite/monster/leprechaun.png",

        -- D class
        wolf = "assets/img/sprite/monster/wolf.png",
        amalgam = "assets/img/sprite/monster/amalgam.jpg",
        giantScorpion = "assets/img/sprite/monster/giantScorpion.jpg",
        boa = "assets/img/sprite/monster/boa.jpg",
        goblin = "assets/img/sprite/monster/goblin.png",
        skeleton = "assets/img/spriteSheet/monster/skeleton_spriteSheet.png",
        wildBoar = "assets/img/sprite/monster/wildBoar.jpg",
        enchantedStump = "assets/img/sprite/monster/enchantedStump.jpg",
        kobold = "assets/img/sprite/monster/kobold.png",
        warriorToad = "assets/img/sprite/monster/warriorToad.png",

        -- C class
        ghoul = "assets/img/sprite/monster/ghoul.png",
        giantWorm = "assets/img/sprite/monster/giantWorm.png",
        banshee = "assets/img/sprite/monster/banshee.jpg",
        witch = "assets/img/sprite/monster/witch.jpg",
        slime = "assets/img/sprite/monster/slime.png",
        revenant = "assets/img/sprite/monster/revenant.png",
        giantWasp = "assets/img/sprite/monster/giantWasp.jpg",
        glutton = "assets/img/sprite/monster/glutton.png",
        gnoll = "assets/img/sprite/monster/gnoll.png",
        hags = "assets/img/sprite/monster/hags.png",
        
        -- B class
        mimic = "assets/img/sprite/monster/mimic.png",
        hobgoblin = "assets/img/sprite/monster/hobgoblin.jpg",
        failedExperiment = "assets/img/sprite/monster/failedExperiment.png",
        imp = "assets/img/sprite/monster/imp.jpg",
        courtesan = "assets/img/sprite/monster/courtesan.jpg",
        mandrake = "assets/img/sprite/monster/mandrake.jpg",
        chimera = "assets/img/sprite/monster/chimera.png",
        swampCreature = "assets/img/sprite/monster/swampCreature.png",
        sylvester = "assets/img/sprite/monster/sylvester.jpg",
        orc = "assets/img/sprite/monster/orc.png",
        
        -- A class
        reaper = "assets/img/sprite/monster/reaper.jpg",
        ent = "assets/img/sprite/monster/ent.png",
        vampire = "assets/img/sprite/monster/vampire.jpg",
        reptilian = "assets/img/sprite/monster/reptilian.jpg",
        abomination = "assets/img/sprite/monster/abomination.jpg",
        ogre = "assets/img/sprite/monster/ogre.jpg",
        golem = "assets/img/sprite/monster/golem.jpg",
        gorgon = "assets/img/sprite/monster/gorgon.jpg",
        succubus = "assets/img/sprite/monster/succubus.png",
        centaur = "assets/img/sprite/monster/centaur.png",
        
        -- S class
        griffin = "assets/img/sprite/monster/griffin.jpg",
        werewolf = "assets/img/sprite/monster/werewolf.jpg",
        raptor = "assets/img/sprite/monster/raptor.jpg",
        cyclops = "assets/img/sprite/monster/cyclops.png",
        wyvern = "assets/img/sprite/monster/wyvern.png",
        minotaur = "assets/img/sprite/monster/minotaur.jpg",
        berserker = "assets/img/sprite/monster/berserker.jpg",
        kraken = "assets/img/sprite/monster/kraken.png",
        troll = "assets/img/sprite/monster/troll.png",
        demon = "assets/img/sprite/monster/demon.jpg",
    }
    
    instance.images = {}
    
    for key, path in pairs(instance.toLoad) do
        if love.filesystem.getInfo(path) then
            local img = love.graphics.newImage(path)
            instance.images[key] = {
                image = img,
                isLoaded = true
            }
        else
            print("Warning: Image '" .. path .. "' does not exist.")
            instance.images[key] = {
                image = nil,
                isLoaded = false
            }
        end
    end

    return instance
end

function Resources:getImage(key)
    local resource = self.images[key]
    if resource and resource.isLoaded then
        return resource.image
    else
        error("Image '" .. key .. "' n'est pas chargée ou n'existe pas.")
    end
end

return Resources