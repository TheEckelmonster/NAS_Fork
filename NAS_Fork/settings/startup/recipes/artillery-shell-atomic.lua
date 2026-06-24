local mods = mods
local script = script

local sa_active = mods and mods["space-age"] and true or script and script.active_mods and script.active_mods["space-age"]
local se_active = mods and mods["space-exploration"] and true or script and script.active_mods and script.active_mods["space-exploration"]

local prefix = "nas-"

local uranium_235 = (sa_active or se_active) and 100 or 30

local recipes = {
    {
        setting  = "ARTILLERY_SHELL_ATOMIC",
        name = "artillery-shell-atomic",
        energy_required = 50,
        crafting_machines = { "crafting", },
        ingredients = {
            { type = "item",  name = "artillery-shell", amount = 1, },
            { type = "item",  name = "uranium-235",     amount = uranium_235, },
        },
        results = {
            { type = "item",  name = "artillery-shell-nuclear", amount = 1, },
        },
        order = "a-a-s",
    },
}

local settings = {}
for i = 1, #recipes, 1 do
    settings[#settings+1] = {
        setting = recipes[i].setting  .. "_CRAFTING_TIME",
        type = "double-setting",
        name = prefix .. recipes[i].name .. "-crafting-time",
        setting_type = "startup",
        order = (recipes[i].order or "") .. ("c[recipe]-c[" .. recipes[i].name .. "]-e[recipe]-c[crafting-time]"),
        default_value = recipes[i].energy_required,
        maximum_value = 2 ^ 11,
        minimum_value = 0.0001
    }
    settings[#settings+1] = {
        type = "string-setting",
        setting = recipes[i].setting  .. "_RECIPE",
        name = prefix .. recipes[i].name .. "-recipe",
        setting_type = "startup",
        order = (recipes[i].order or "") .. ("c[recipe]-c[" .. recipes[i].name .. "]-e[recipe]-e[recipe]"),
        ingredients = recipes[i].ingredients,
        default_value = nil,
        allow_blank = true,
        auto_trim = true,
    }
    settings[#settings+1] = {
        setting = recipes[i].setting  .. "_RESULTS",
        type = "string-setting",
        name = prefix .. recipes[i].name .. "-results",
        setting_type = "startup",
        order = (recipes[i].order or "") .. ("c[recipe]-c[" .. recipes[i].name .. "]-e[recipe]-g[results]"),
        results = recipes[i].results,
        default_value = nil,
        allow_blank = true,
        auto_trim = true,
    }
    settings[#settings+1] = {
        setting = recipes[i].setting  .. "_CRAFTING_MACHINES",
        type = "string-setting",
        name = prefix .. recipes[i].name .. "-crafting-machines",
        setting_type = "startup",
        order = (recipes[i].order or "") .. ("c[recipe]-c[" .. recipes[i].name .. "]-e[recipe]-k[-crafting-machines]"),
        default_value = recipes[i].crafting_machines and recipes[i].crafting_machines[1] or "",
        allow_blank = false,
        auto_trim = true,
    }
    settings[#settings+1] = {
        type = "double-setting",
        setting = recipes[i].setting  .. "_EMISSIONS_MULTIPLIER",
        name = prefix .. recipes[i].name .. "-emissions-multiplier",
        setting_type = "startup",
        order = (recipes[i].order or "") .. ("c[recipe]-c[" .. recipes[i].name .. "]-e[recipe]-m[emissions-multiplier]"),
        default_value = recipes[i].emissions_multiplier or 1,
        maximum_value = 111,
        minimum_value = 0.0001,
        hidden = recipes[i].hidden,
    }
end

return settings