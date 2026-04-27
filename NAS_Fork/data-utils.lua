local type = type

local tbl = {}

local Startup_Settings_Constants = require("settings.startup.startup-settings-constants")

local Data_Utils = require("__TheEckelmonster-core-library__.libs.utils.data-utils")

local Setting_Utils = require("settings.settings-utils")

function tbl.create_recipe(params)
    if (not params or not type(params) == "table") then return end

    local setting_name = params.setting_name
    local name = params.name
    local enabled = params.enabled or false
    local icon = params.icon
    local icons = params.icons
    local auto_recycle = params.auto_recycle or true
    local subgroup = params.subgroup
    local order = params.order
    local crafting_machine_tint = params.crafting_machine_tint
    if (type(crafting_machine_tint) ~= "table") then
        crafting_machine_tint = nil
    else
        if (    not crafting_machine_tint.primary
            and not crafting_machine_tint.secondary
            and not crafting_machine_tint.tertiary
            and not crafting_machine_tint.quaternary
        ) then crafting_machine_tint = nil end
    end

    return  {
        type = "recipe",
        name = name,
        enabled = enabled,
        icon = icon,
        icons = icons,
        category = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting_name .. "_CRAFTING_MACHINE"].name, }),
        subgroup = subgroup,
        order = order,
        energy_required = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting_name .. "_CRAFTING_TIME"].name, }),
        emissions_multiplier = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting_name .. "_EMISSIONS_MULTIPLIER"].name, }) or 1,
        ingredients = Setting_Utils.get_recipe_ingredients({
            recipe_setting = Startup_Settings_Constants.settings[setting_name .. "_RECIPE"],
        }) or Startup_Settings_Constants.settings[setting_name .. "_RECIPE"].ingredients,
        results = Setting_Utils.get_recipe_results({
            recipe_setting = Startup_Settings_Constants.settings[setting_name .. "_RESULTS"],
        }) or Startup_Settings_Constants.settings[setting_name .. "_RESULTS"].results,
        additional_categories = Setting_Utils.get_additional_crafting_machines({
            default_value = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting_name .. "_ADDITIONAL_CRAFTING_MACHINES"].name, }),
        }),
        crafting_machine_tint = crafting_machine_tint,
        auto_recycle = auto_recycle,
    }
end

return tbl