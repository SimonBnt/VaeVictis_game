local Item = require("modules.expedition.Item")

local manaShardsByClass = {
    f = Item:new({
        n = "Mana Residue", 
        d = "Faint traces of magical energy. Almost useless, but still glows faintly.", 
        w = 0.1, 
    }),
    e = Item:new({
        n = "Raw Mana Shard", 
        d = "A coarse fragment imbued with raw magic.", 
        w = 0.2, 
    }),
    d = Item:new({
        n = "Polished Mana Shard", 
        d = "A well-shaped shard that resonates weakly with mana.", 
        w = 0.3, 
    }),
    c = Item:new({
        n = "Mana Shard", 
        d = "A standard fragment of refined mana. Useful for crafting.", 
        w = 0.4, 
    }),
    b = Item:new({
        n = "Greater Mana Shard", 
        d = "A strong shard pulsating with magical power.", 
        w = 0.6, 
    }),
    a = Item:new({
        n = "Overflowing Mana Shard", 
        d = "So much magic leaks from it, the air trembles nearby.", 
        w = 0.8, 
    }),
    s = Item:new({
        n = "Pure Mana", 
        d = "A crystallized essence of pure, untainted mana. Extremely rare.", 
        w = 1, 
    }),
}

return manaShardsByClass