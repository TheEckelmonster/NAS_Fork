local mods = mods

local Startup_Settings_Constants = require("settings.startup.startup-settings-constants")

local Data_Utils = require("__TheEckelmonster-core-library__.libs.utils.data-utils")

local sa_active = mods and mods["space-age"] and true
local se_active = mods and mods["space-exploration"] and true

local setting_name = "ARTILLERY_SHELL_ATOMIC"

local get_research_prerequisites = function ()
    local setting = Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_PREREQUISITES"].default_value

    if (settings and settings.startup and settings.startup[Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_PREREQUISITES"].name]) then
        setting = settings.startup[Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_PREREQUISITES"].name].value
    end

    local prerequisites = {}

    --[[ Looks for:
            >= 0 commas,
            >= 0 space characters,
            >= 1 alphanumerics/dashes/space characters,
            >= 0 space characters,
            >= 0 commas,
            >= 0 space characters,
    ]]
    local search_pattern = ",*%s*([%w%-%s]+)%s*,*"
    local i, j, param = string.find(setting or "", search_pattern, 1)
    local possible_matches = {}
    local found_match = false

    local found_func = function (found_match, param, t, type)
        for _, j in pairs(t) do
            if (j.name == param) then
                found_match = true
                break
            elseif (j.name:find(param, 1, true)) then
                possible_matches[j.name] = { param = param }
            end
        end

        return found_match
    end

    while param ~= nil do

        --[[ Replace space characters with a dash; remove any prefixed dashes; remove any postfixed dashes ]]
        param = param:gsub("%s+", "-"):gsub("^%-+", ""):gsub("%-+$", "")

        for k, v in pairs(data.raw) do
            found_match = false
            if (k == "technology") then found_match = found_func(found_match, param, v, "technology")
            end

            if (found_match) then break end
        end

        if (found_match) then table.insert(prerequisites, param) end

        setting = string.sub(setting or "", j + 1, #setting)

        i, j, param = setting:find(search_pattern, 1)
    end

    -- if (#prerequisites <= 0) then
    --     for k, v in pairs(possible_matches) do
    --         table.insert(prerequisites, { type = "item", name = k, amount = v.param_val * get_input_multiplier(), })
    --     end
    -- end

    if (#prerequisites <= 0) then
        prerequisites = Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_PREREQUISITES"].prerequisites
    end

    return prerequisites
end
local get_research_ingredients = function ()
    local setting = Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_INGREDIENTS"].default_value

    if (settings and settings.startup and settings.startup[Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_INGREDIENTS"].name]) then
        setting = settings.startup[Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_INGREDIENTS"].name].value
    end

    local ingredients = {}

    --[[ Looks for:
            >= 0 commas,
            >= 0 space characters,
            >= 1 alphanumerics/dashes/space characters,
            >= 0 space characters,
            == 1 equals,
            >= 0 space characters,
            >= 1 digits,
            >= 0 space characters,
            >= 0 commas,
            >= 0 space characters,
    ]]
    local search_pattern = ",*%s*([%w%-%s]+)%s*=%s*(%d+)%s*,*"
    local i, j, param, param_val = string.find(setting or "", search_pattern, 1)
    local possible_matches = {}
    local found_match = false

    local found_func = function (param, param_val, t, type)
        for _, j in pairs(t) do
            if (j.name == param) then
                found_match = true
                break
            elseif (j.name:find(param, 1, true)) then
                possible_matches[j.name] = { param = param, param_val = param_val, }
            end
        end
    end

    while param ~= nil and param_val ~= nil do

        --[[ Replace space characters with a dash; remove any prefixed dashes; remove any postfixed dashes ]]
        param = param:gsub("%s+", "-"):gsub("^%-+", ""):gsub("%-+$", "")

        for k, v in pairs(data.raw) do
            found_match = false
            if (k == "technology") then found_func(param, param_val, v, "technology")
            end

            if (found_match) then break end
        end

        if (found_match) then table.insert(ingredients, { param, tonumber(param_val), }) end

        setting = string.sub(setting or "", j + 1, #setting)

        i, j, param, param_val = string.find(setting or "", search_pattern, 1)
    end

    -- if (#ingredients <= 0) then
    --     for k, v in pairs(possible_matches) do
    --         table.insert(ingredients, { type = "item", name = k, amount = v.param_val * get_input_multiplier(), })
    --     end
    -- end

    if (#ingredients <= 0) then
        ingredients = Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_INGREDIENTS"].ingredients
    end

    return ingredients
end

local technology_effects =
{
    {
        type = "unlock-recipe",
        recipe = "artillery-shell-nuclear",
    },
}

local technology = data.raw.technology["artillery-shell-nuclear"] or {
    type = "technology",
    name = "artillery-shell-nuclear",
    icon = "__base__/graphics/technology/atomic-bomb.png",
    icon_size = 256,
    icon_mipmaps = 4,
    effects = {},
    prerequisites = {},
    unit = {},
}

technology.prerequisites = get_research_prerequisites()
technology.unit = {
    ingredients = get_research_ingredients(),
    count = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_COUNT"].name, }),
    time = Data_Utils.get_startup_setting({ setting = Startup_Settings_Constants.settings[setting_name .. "_RESEARCH_TIME"].name, }),
}

for _, v in ipairs(technology_effects) do
    table.insert(technology.effects, v)
end

data:extend({ technology, })