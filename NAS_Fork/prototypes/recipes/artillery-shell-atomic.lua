local Data_Utils = require("data-utils")
local setting = "ARTILLERY_SHELL_ATOMIC"

data:extend({
    Data_Utils.create_recipe({
        setting_name = setting,
        name = "artillery-shell-nuclear",
        enabled = false,
        subgroup = "ammo",
        order = "d[explosive-cannon-shell]-d[artillery]2",
    })
})