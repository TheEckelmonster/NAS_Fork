local mods = mods
local script = script

local __Data_Utils = require("base-data-utils")

local sa_active = mods and mods["space-age"] and true or script and script.active_mods and script.active_mods["space-age"]
local se_active = mods and mods["space-exploration"] and true or script and script.active_mods and script.active_mods["space-exploration"]

local startup_settings_constants = {}

startup_settings_constants.settings = {}

--[[ Bomb ]]
__Data_Utils.foreach(function(params)
    if (params and params.setting) then startup_settings_constants.settings[params.setting] = params end
end, __Data_Utils.unpack(require("settings.startup.quality.artillery-shell-atomic")))

__Data_Utils.foreach(
    function(params) if (params and params.setting) then startup_settings_constants.settings[params.setting] = params end
end, __Data_Utils.unpack(require("settings.startup.items.artillery-shell-atomic")))
__Data_Utils.foreach(
    function(params) if (params and params.setting) then startup_settings_constants.settings[params.setting] = params end
end, __Data_Utils.unpack(require("settings.startup.recipes.artillery-shell-atomic")))
__Data_Utils.foreach(function(params)
    if (params and params.setting) then startup_settings_constants.settings[params.setting] = params end
end, __Data_Utils.unpack(require("settings.startup.technologies.artillery-shell-atomic")))

-- [[ crafting-categories ]]
if (sa_active) then
    local sa_crafting_categories =
    {
        "captive-spawner-process",
        "chemistry-or-cryogenics",
        "cryogenics",
        "cryogenics-or-assembling",
        "crafting-with-fluid-or-metallurgy",
        "crushing",
        "electronics-or-assembling",
        "electromagnetics",
        "electronics",
        "electronics-with-fluid",
        "metallurgy",
        "metallurgy-or-assembling",
        "organic",
        "organic-or-assembling",
        "organic-or-chemistry",
        "organic-or-hand-crafting",
        "pressing",
    }

    __Data_Utils.foreach(function(params)
        if (params and params.setting and params.setting:find("_CRAFTING_MACHINE$")) then
            -- startup_settings_constants.settings[params.setting] = params
            for k, v in pairs(sa_crafting_categories) do
                table.insert(params.allowed_values, v)
            end
        end
    end, __Data_Utils.unpack(startup_settings_constants.settings))
end

if (se_active) then
    local se_crafting_categories =
    {
        "arcosphere",
        -- "condenser-turbine",
        -- "big-turbine",
        "casting",
        "kiln",
        -- "delivery-cannon",
        -- "delivery-cannon-weapon",
        -- "fixed-recipe", -- generic group for anything with a fixed recipe, not chosen by player
        "fuel-refining",
        "core-fragment-processing",
        "lifesupport", -- same as "space-lifesupport" but can be on land
        "melting",
        "nexus",
        "pulverising",
        "crafting-or-electromagnetics",
        -- "hard-recycling", -- no conflict with "recycling"
        -- "hand-hard-recycling", -- no conflict with "recycling"
        "se-electric-boiling", -- needs to be SE specific otherwise energy values will be off
        "space-accelerator",
        "space-astrometrics",
        "space-biochemical",
        "space-collider",
        "space-crafting", -- same as basic assembling but only in space
        "space-decontamination",
        "space-electromagnetics",
        "space-elevator",
        "space-materialisation",
        "space-genetics",
        "space-gravimetrics",
        "space-growth",
        "space-hypercooling",
        "space-laser",
        "space-lifesupport", -- same as "lifesupport" but can only be in space
        "space-manufacturing",
        "space-mechanical",
        "space-observation-gammaray",
        "space-observation-xray",
        "space-observation-uv",
        "space-observation-visible",
        "space-observation-infrared",
        "space-observation-microwave",
        "space-observation-radio",
        "space-plasma",
        "space-radiation",
        "space-radiator",
        -- "space-hard-recycling", -- no conflict with "recycling"
        "space-research",
        "space-spectrometry",
        "space-supercomputing-1",
        "space-supercomputing-2",
        "space-supercomputing-3",
        "space-supercomputing-4",
        "space-thermodynamics",
        -- "spaceship-console",
        -- "spaceship-antimatter-engine",
        -- "spaceship-ion-engine",
        -- "spaceship-rocket-engine",
        -- "pressure-washing",
        -- "dummy",
        -- "no-category"
    }

    __Data_Utils.foreach(function(params)
        if (params and params.setting and params.setting:find("_CRAFTING_MACHINE$")) then
            -- startup_settings_constants.settings[params.setting] = params
            for k, v in pairs(se_crafting_categories) do
                table.insert(params.allowed_values, v)
            end
        end
    end, __Data_Utils.unpack(startup_settings_constants.settings))
end

local create_recipe_string = function (data)
    if (not data or type(data) ~= "table") then return end
    if (not data.ingredients or type(data.ingredients) ~= "table") then return end
    if (not data.setting or type(data.setting) ~= "table") then return end

    for k, v in pairs(data.ingredients) do
        if (not data.setting.default_value or data.setting.default_value == "") then
            data.setting.default_value =
                v.name
                .. "="
                .. (
                        v.amount
                    or
                        v.amount_min
                        .. "-" ..
                        v.amount_max
                )
                .. (
                            v.probability
                        and "%" .. v.probability
                    or
                        ""
                )
        else
            data.setting.default_value =
                data.setting.default_value
                .. ","
                .. v.name
                .. "="
                .. (
                        v.amount
                    or
                        v.amount_min
                        .. "-" ..
                        v.amount_max
                )
                .. (
                            v.probability
                        and "%" .. v.probability
                    or
                        ""
                )
        end

        if (v.temperature or v.percent_spoiled) then
            data.setting.default_value = data.setting.default_value .. "{"
            data.setting.default_value = data.setting.default_value .. (
                        v.temperature
                    and "temperature=" .. v.temperature .. "C,"
                or
                    ""
            )
            data.setting.default_value = data.setting.default_value .. (
                        v.percent_spoiled
                    and "percent_spoiled=" .. v.percent_spoiled
                or
                    ""
            )

            data.setting.default_value = data.setting.default_value .. "}"
        end
    end
end
local create_results_string = create_recipe_string

local create_research_prerequisites_string = function (data)
    if (not data or type(data) ~= "table") then return end
    if (not data.prerequisites or type(data.prerequisites) ~= "table") then return end
    if (not data.setting or type(data.setting) ~= "table") then return end

    for k, v in pairs(data.prerequisites) do
        if (not data.setting.default_value or data.setting.default_value == "") then
            data.setting.default_value = v
        else
            data.setting.default_value = data.setting.default_value .. ",".. v
        end
    end
end

local create_research_ingredients_string = function (data)
    if (not data or type(data) ~= "table") then return end
    if (not data.ingredients or type(data.ingredients) ~= "table") then return end
    if (not data.setting or type(data.setting) ~= "table") then return end

    for k, v in pairs(data.ingredients) do
        if (not data.setting.default_value or data.setting.default_value == "") then
            data.setting.default_value =
                v.name
                .. "="
                .. v.amount
        else
            data.setting.default_value =
                data.setting.default_value
                .. ","
                .. v.name
                .. "="
                .. v.amount
        end
    end
end

for _, setting in ipairs({
    { recipe = "ARTILLERY_SHELL_ATOMIC_RECIPE", result = "ARTILLERY_SHELL_ATOMIC_RESULTS", },
}) do
    if (startup_settings_constants.settings[setting.recipe]) then
        if (setting.recipe) then create_recipe_string({  ingredients = startup_settings_constants.settings[setting.recipe].ingredients, setting = startup_settings_constants.settings[setting.recipe], }) end
        if (setting.result) then create_results_string({ ingredients = startup_settings_constants.settings[setting.result].results,     setting = startup_settings_constants.settings[setting.result], }) end
    end
end

for _, setting in ipairs({
    { prerequisites = "ARTILLERY_SHELL_ATOMIC_RESEARCH_PREREQUISITES", ingredients = "ARTILLERY_SHELL_ATOMIC_RESEARCH_INGREDIENTS", },
}) do
    if (startup_settings_constants.settings[setting.prerequisites or ""] or startup_settings_constants.settings[setting.ingredients or ""]) then
        if (setting.prerequisites) then create_research_prerequisites_string({ prerequisites = startup_settings_constants.settings[setting.prerequisites].prerequisites, setting = startup_settings_constants.settings[setting.prerequisites], }) end
        if (setting.ingredients) then create_research_ingredients_string({     ingredients   = startup_settings_constants.settings[setting.ingredients].ingredients,     setting = startup_settings_constants.settings[setting.ingredients],   }) end
    end
end

return startup_settings_constants