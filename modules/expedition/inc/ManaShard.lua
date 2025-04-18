local Item = require("modules.expedition.Item")

local manaShardsByClass = {
    f = Item:new("Mana Residue", "Faint traces of magical energy. Almost useless, but still glows faintly.", 0.1, false),
    e = Item:new("Raw Mana Shard", "A coarse fragment imbued with raw magic.", 0.2, false),
    d = Item:new("Polished Mana Shard", "A well-shaped shard that resonates weakly with mana.", 0.3, false),
    c = Item:new("Mana Shard", "A standard fragment of refined mana. Useful for crafting.", 0.4, false),
    b = Item:new("Greater Mana Shard", "A strong shard pulsating with magical power.", 0.6, false),
    a = Item:new("Overflowing Mana Shard", "So much magic leaks from it, the air trembles nearby.", 0.8, false),
    s = Item:new("Pure Mana", "A crystallized essence of pure, untainted mana. Extremely rare.", 1, false)
}

return manaShardsByClass