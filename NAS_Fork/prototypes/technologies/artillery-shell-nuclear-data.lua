local mods = mods

local sa_active = mods and mods["space-age"] and true
local se_active = mods and mods["space-exploration"] and true

if (se_active) then return end

local technology = {
    type = "technology",
    name = "artillery-shell-nuclear",
    icon = "__base__/graphics/technology/atomic-bomb.png",
    icon_size = 256,
    icon_mipmaps = 4,
    effects = {},
    prerequisites = {},
    unit = {},
}

data:extend({ technology, })