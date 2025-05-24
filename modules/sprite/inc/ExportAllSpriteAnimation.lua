---- // ---- MODULES ---- // ---- 


---- // ---- LOCAL VAR ---- // ---- 
local ExportAllSpriteAnimation = {}
ExportAllSpriteAnimation.__index = ExportAllSpriteAnimation

function ExportAllSpriteAnimation:new(spriteManager)
    local sprite = setmetatable({}, self)

    sprite.toExport = {
    -- interface
    spriteManager:addAnimation("coinAnimation", "coin", 32, 32, 0.2),

    -- héro
    -- spriteManager:addAnimation("heroAnimation", "hero", 64, 64, 0.2),
    spriteManager:addAnimation("heroAnimation", "hero", 128, 128, 0.2),
    -- monster class
    -- F
    spriteManager:addAnimation("giantRatAnimation", "giantRat", 64, 64, 0.2),
    spriteManager:addAnimation("batAnimation", "bat", 64, 64, 0.2),
    spriteManager:addAnimation("wispAnimation", "wisp", 64, 64, 0.2),
    spriteManager:addAnimation("manEaterSpiderAnimation", "manEaterSpider", 64, 64, 0.2),
    spriteManager:addAnimation("orbitAnimation", "orbit", 64, 64, 0.2),
    spriteManager:addAnimation("leavingMushroomAnimation", "leavingMushroom", 64, 64, 0.2),
    spriteManager:addAnimation("juvenileSylvesterAnimation", "juvenileSylvester", 64, 64, 0.2),
    spriteManager:addAnimation("mutantLarvaAnimation", "mutantLarva", 64, 64, 0.2),
    spriteManager:addAnimation("spiritInBottleAnimation", "spiritInBottle", 64, 64, 0.2),
    spriteManager:addAnimation("cursedSkullAnimation", "cursedSkull", 64, 64, 0.2),
    
    -- E
    spriteManager:addAnimation("grimlinAnimation", "grimlin", 64, 64, 0.2),
    spriteManager:addAnimation("livingDeadAnimation", "livingDead", 64, 64, 0.2),
    spriteManager:addAnimation("carnivorousPlantAnimation", "carnivorousPlant", 64, 64, 0.2),
    spriteManager:addAnimation("goliathSnailAnimation", "goliathSnail", 64, 64, 0.2),
    spriteManager:addAnimation("murlocAnimation", "murloc", 64, 64, 0.2),
    spriteManager:addAnimation("brazierAnimation", "brazier", 64, 64, 0.2),
    spriteManager:addAnimation("juvenileSlimeAnimation", "juvenileSlime", 64, 64, 0.2),
    spriteManager:addAnimation("ectoplasmAnimation", "ectoplasm", 64, 64, 0.2),
    spriteManager:addAnimation("juvenileKrakenAnimation", "juvenileKraken", 64, 64, 0.2),
    spriteManager:addAnimation("leprechaunAnimation", "leprechaun", 64, 64, 0.2),

    -- D
    spriteManager:addAnimation("wolfAnimation", "wolf", 64, 64, 0.2),
    spriteManager:addAnimation("amalgamAnimation", "amalgam", 64, 64, 0.2),
    spriteManager:addAnimation("giantScorpionAnimation", "giantScorpion", 64, 64, 0.2),
    spriteManager:addAnimation("boaAnimation", "boa", 64, 64, 0.2),
    spriteManager:addAnimation("goblinAnimation", "goblin", 64, 64, 0.2),
    spriteManager:addAnimation("skeletonAnimation", "skeleton", 64, 64, 0.2),
    spriteManager:addAnimation("wildBoarAnimation", "wildBoar", 64, 64, 0.2),
    spriteManager:addAnimation("enchantedStumpAnimation", "enchantedStump", 64, 64, 0.2),
    spriteManager:addAnimation("koboldAnimation", "kobold", 64, 64, 0.2),
    spriteManager:addAnimation("warriorToadAnimation", "warriorToad", 64, 64, 0.2),

    -- C
    spriteManager:addAnimation("ghoulAnimation", "ghoul", 64, 64, 0.2),
    spriteManager:addAnimation("giantWormAnimation", "giantWorm", 64, 64, 0.2),
    spriteManager:addAnimation("bansheeAnimation", "banshee", 64, 64, 0.2),
    spriteManager:addAnimation("witchAnimation", "witch", 64, 64, 0.2),
    spriteManager:addAnimation("slimeAnimation", "slime", 64, 64, 0.2),
    spriteManager:addAnimation("revenantAnimation", "revenant", 64, 64, 0.2),
    spriteManager:addAnimation("gluttonAnimation", "glutton", 64, 64, 0.2),
    spriteManager:addAnimation("gnollAnimation", "gnoll", 64, 64, 0.2),
    spriteManager:addAnimation("hagsAnimation", "hags", 64, 64, 0.2),
    
    -- B
    spriteManager:addAnimation("mimicAnimation", "mimic", 64, 64, 0.2),
    spriteManager:addAnimation("hobgoblinAnimation", "hobgoblin", 64, 64, 0.2),
    spriteManager:addAnimation("failedExperimentAnimation", "failedExperiment", 64, 64, 0.2),
    spriteManager:addAnimation("impAnimation", "imp", 64, 64, 0.2),
    spriteManager:addAnimation("courtesanAnimation", "courtesan", 64, 64, 0.2),
    spriteManager:addAnimation("mandrakeAnimation", "mandrake", 64, 64, 0.2),
    spriteManager:addAnimation("chimeraAnimation", "chimera", 64, 64, 0.2),
    spriteManager:addAnimation("swampCreatureAnimation", "swampCreature", 64, 64, 0.2),
    spriteManager:addAnimation("sylvesterAnimation", "sylvester", 64, 64, 0.2),
    spriteManager:addAnimation("orcAnimation", "orc", 64, 64, 0.2),
    
    -- A
    spriteManager:addAnimation("reaperAnimation", "reaper", 64, 64, 0.2),
    spriteManager:addAnimation("entAnimation", "ent", 64, 64, 0.2),
    spriteManager:addAnimation("vampireAnimation", "vampire", 64, 64, 0.2),
    spriteManager:addAnimation("reptilianAnimation", "reptilian", 64, 64, 0.2),
    spriteManager:addAnimation("abominationAnimation", "abomination", 64, 64, 0.2),
    spriteManager:addAnimation("ogreAnimation", "ogre", 64, 64, 0.2),
    spriteManager:addAnimation("golemAnimation", "golem", 64, 64, 0.2),
    spriteManager:addAnimation("gorgonAnimation", "gorgon", 64, 64, 0.2),
    spriteManager:addAnimation("succubusAnimation", "succubus", 64, 64, 0.2),
    spriteManager:addAnimation("centaurAnimation", "centaur", 64, 64, 0.2),
    
    -- S
    spriteManager:addAnimation("griffinAnimation", "griffin", 64, 64, 0.2),
    spriteManager:addAnimation("werewolfAnimation", "werewolf", 64, 64, 0.2),
    spriteManager:addAnimation("raptorAnimation", "raptor", 64, 64, 0.2),
    spriteManager:addAnimation("cyclopsAnimation", "cyclops", 64, 64, 0.2),
    spriteManager:addAnimation("wyvernAnimation", "wyvern", 64, 64, 0.2),
    spriteManager:addAnimation("minotaurAnimation", "minotaur", 64, 64, 0.2),
    spriteManager:addAnimation("berserkerAnimation", "berserker", 64, 64, 0.2),
    spriteManager:addAnimation("krakenAnimation", "kraken", 64, 64, 0.2),
    spriteManager:addAnimation("trollAnimation", "troll", 64, 64, 0.2),
    spriteManager:addAnimation("demonAnimation", "demon", 64, 64, 0.2),
    }

    return sprite
end

return ExportAllSpriteAnimation