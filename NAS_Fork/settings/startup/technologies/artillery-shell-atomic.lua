local mods = mods
local script = script

local sa_active = mods and mods["space-age"] and true or script and script.active_mods and script.active_mods["space-age"] and true
local se_active = mods and mods["space-exploration"] and true or script and script.active_mods and script.active_mods["space-exploration"] and true

local prefix = "nas-"

local technology = {
    {
        setting  = "ARTILLERY_SHELL_ATOMIC",
        name = "artillery-shell-atomic",
        count = 5000,
        research_time = 60,
        prerequisites = {
            "atomic-bomb",
            "artillery",
        },
        ingredients = {
            { name = "automation-science-pack", amount = 1, },
            { name = "logistic-science-pack",   amount = 1, },
            { name = "chemical-science-pack",   amount = 1, },
            { name = "military-science-pack",   amount = 1, },
            { name = "utility-science-pack",    amount = 1, },
            sa_active and { name = "space-science-pack", amount = 1, } or nil,
            sa_active and { name = "metallurgic-science-pack", amount = 1, } or nil,
        },
        order = "a-a-s",
    },
}

local settings = {}

for i = 1, #technology, 1 do
    settings[#settings+1] = {
        setting = technology[i].setting .. "_RESEARCH_PREREQUISITES",
        type = "string-setting",
        name = prefix .. technology[i].name .. "-research-prerequisites",
        setting_type = "startup",
        order = (technology[i].order or "") .. ("c[technology]-c[" .. technology[i].name .. "]-g[technology]-c[research-prerequisites]"),
        default_value = nil,
        allow_blank = true,
        auto_trim = true,
        prerequisites = technology[i].prerequisites,
    }
    settings[#settings+1] = {
        setting = technology[i].setting .. "_RESEARCH_INGREDIENTS",
        type = "string-setting",
        name = prefix .. technology[i].name .. "-research-ingredients",
        setting_type = "startup",
        order = (technology[i].order or "") .. ("c[technology]-c[" .. technology[i].name .. "]-g[technology]-e[research-ingredients]"),
        default_value = nil,
        allow_blank = true,
        auto_trim = true,
        ingredients = technology[i].ingredients
    }
    settings[#settings+1] = {
        setting = technology[i].setting .. "_RESEARCH_TIME",
        type = "int-setting",
        name = prefix .. technology[i].name .. "-research-time",
        setting_type = "startup",
        order = (technology[i].order or "") .. ("c[technology]-c[" .. technology[i].name .. "]-g[technology]-g[research-time]"),
        default_value = technology[i].research_time,
        minimum_value = 1,
        maximum_value = 2 ^ 42,
    }
    settings[#settings+1] = {
        setting = technology[i].setting .. "_RESEARCH_COUNT",
        type = "int-setting",
        name = prefix .. technology[i].name .. "-research-count",
        setting_type = "startup",
        order = (technology[i].order or "") .. ("c[technology]-c[" .. technology[i].name .. "]-g[technology]-h[research-count]"),
        default_value = technology[i].count,
        minimum_value = 1,
        maximum_value = 2 ^ 42,
    }
end

return settings