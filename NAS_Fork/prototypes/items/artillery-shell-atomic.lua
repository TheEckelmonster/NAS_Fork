local Data_Utils = require("__TheEckelmonster-core-library__.libs.utils.data-utils")

local Startup_Settings_Constants = require("settings.startup.startup-settings-constants")

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
    {
        type = "ammo",
        name = "artillery-shell-nuclear",
        icons = icons,
        ammo_category = "artillery-shell",
        ammo_type =
        {
            category = "artillery-shell",
            target_type = "position",
            action =
            {
                type = "direct",
                action_delivery =
                {
                    type = "artillery",
                    projectile = "artillery-projectile-nuclear",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    source_effects =
                    {
                        type = "create-explosion",
                        entity_name = "artillery-cannon-muzzle-flash"
                    }
                }
            }
        },
        enabled = false,
        subgroup = "ammo",
        order = "d[explosive-cannon-shell]-d[artillery]2",
        stack_size = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting .. "_STACK_SIZE"].name,  }),
        weight = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting .. "_WEIGHT_MODIFIER"].name, }) * tons,
    }
})