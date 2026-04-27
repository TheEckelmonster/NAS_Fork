local prefix = "nas-"

local entities = {
    {
        setting  = "ARTILLERY_SHELL_ATOMIC",
        name = "artillery-shell-atomic",
        do_pollution = true,
        order = "a-a-s",
        hidden = true,
    },
}

local settings = {}
for i = 1, #entities, 1 do
    settings[#settings+1] = {
        setting = entities[i].setting  .. "_AREA_MULTIPLIER",
        type = "double-setting",
        name = prefix .. entities[i].name .. "-area-multiplier",
        setting_type = "startup",
        order = (entities[i].order or "") .. ("c[entity]-c[" .. entities[i].name .. "]-c[entity]-d[area-multiplier]"),
        default_value = 1,
        maximum_value = 11,
        minimum_value = 1,
        hidden = entities[i].hidden,
    }
    settings[#settings+1] = {
        setting = entities[i].setting  .. "_DAMAGE_MULTIPLIER",
        type = "double-setting",
        name = prefix .. entities[i].name .. "-damage-multiplier",
        setting_type = "startup",
        order = (entities[i].order or "") .. ("c[entity]-c[" .. entities[i].name .. "]-c[entity]-d[damage-multiplier]"),
        default_value = 1,
        maximum_value = 11,
        minimum_value = 1,
        hidden = entities[i].hidden,
    }
    settings[#settings+1] = {
        setting = entities[i].setting  .. "_REPEAT_MULTIPLIER",
        type = "double-setting",
        name = prefix .. entities[i].name .. "-repeat-multiplier",
        setting_type = "startup",
        order = (entities[i].order or "") .. ("c[entity]-c[" .. entities[i].name .. "]-c[entity]-d[repeat-multiplier]"),
        default_value = 1,
        maximum_value = 11,
        minimum_value = 1,
        hidden = entities[i].hidden,
    }
    settings[#settings+1] = {
        setting = entities[i].setting  .. "_DO_POLLUTION",
        type = "bool-setting",
        name = prefix .. entities[i].name .. "-do-pollution",
        setting_type = "startup",
        order = (entities[i].order or "") .. ("c[entity]-c[" .. entities[i].name .. "]-c[entity]-d[do-pollution]"),
        default_value = entities[i].do_pollution or false,
        hidden = entities[i].hidden or true,
    }
    settings[#settings+1] = {
        setting = entities[i].setting  .. "_FIRE_WAVE",
        type = "bool-setting",
        name = prefix .. entities[i].name .. "-fire-wave",
        setting_type = "startup",
        order = (entities[i].order or "") .. ("c[entity]-c[" .. entities[i].name .. "]-c[entity]-d[fire-wave]"),
        default_value = entities[i].fire_wave or false,
        hidden = entities[i].hidden or true,
    }
    settings[#settings+1] = {
        setting = entities[i].setting  .. "_LAVA_CRATER",
        type = "bool-setting",
        name = prefix .. entities[i].name .. "-lava-crater",
        setting_type = "startup",
        order = (entities[i].order or "") .. ("c[entity]-c[" .. entities[i].name .. "]-c[entity]-d[lava-crater]"),
        default_value = entities[i].lava_crater or false,
        hidden = entities[i].hidden or true,
    }
end

return settings