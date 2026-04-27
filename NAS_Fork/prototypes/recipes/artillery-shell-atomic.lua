local Data_Utils = require("__TheEckelmonster-core-library__.libs.utils.data-utils")
local Startup_Settings_Constants = require("settings.startup.startup-settings-constants")

local __Data_Utils = require("data-utils")

local setting = "ARTILLERY_SHELL_ATOMIC"

local icons =
    Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting .. "_ORIGINAL_ICON"].name, })
and
    {
        {
            icon = "__NAS_Fork__/graphics/artillery-shell-nuclear.png",
            icon_size = 32,
        },
    }
or
    {
        {
            icon = "__NAS_Fork__/graphics/icons/artillery-shell-nuclear.png",
            icon_size = 64,
        },
    }

data:extend({
    __Data_Utils.create_recipe({
        setting_name = setting,
        name = "artillery-shell-nuclear",
        icons = icons,
        enabled = false,
        subgroup = "ammo",
        order = "d[explosive-cannon-shell]-d[artillery]2",
    })
})