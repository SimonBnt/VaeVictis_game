local Attack = {}
Attack.__index = Attack

function Attack:new(name, damage, key)
    local self = setmetatable({}, Attack)

    self.name = name            --name
    self.damage = damage        --damage
    self.key = key or ""            --keys

    return self
end

Attack.list = {
    default = {
        Attack:new("Engager", 10, "right"),
        Attack:new("Frappe", 20, "up"),
        Attack:new("Enchaîner", 30, "left"),
    },
    F = {
        slice = Attack:new("Trancher", 3),
        estoc = Attack:new("Estoc", 3),
    },
    E = {
        slash = Attack:new("Taille", 4),
        notch = Attack:new("Entaille", 4),
    },
    D = {
        seesaw = Attack:new("Coup de bascule", 5),
        halfMoon = Attack:new("Demi-lune", 5),
    },
    C = {
        backhand = Attack:new("Revers", 6),
        lowBlow = Attack:new("Coup bas", 6),
    },
    B = {
        thrust = Attack:new("Percée", 7),
        sweep = Attack:new("Balayage", 7),
    },
    A = {
        cleave = Attack:new("Fendoir", 8),
        lacerate = Attack:new("Lacérer", 8),
    },
    S = {
        execution = Attack:new("Éxécution", 9),
        evisceration = Attack:new("Éviscératon", 9),
    }
}

return Attack