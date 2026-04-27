local prefix = "nas-"

local items = {
    {
        setting  = "ARTILLERY_SHELL_ATOMIC",
        name = "artillery-shell-atomic",
        stack_size = 1,
        weight_modifier = 1,
        order = "a-a-s",
    },
}

local settings = {}
for i = 1, #items, 1 do
    settings[#settings+1] = {
        setting = items[i].setting  .. "_ORIGINAL_ICON",
        type = "bool-setting",
        name = prefix .. items[i].name .. "-original-icon",
        setting_type = "startup",
        order = (items[i].order or "") .. ("c[item]-c[" .. items[i].name .. "]-c[item]-c[original-icon]"),
        default_value = items[i].original_icon or false,
    }
    settings[#settings+1] = {
        setting = items[i].setting  .. "_WEIGHT_MODIFIER",
        type = "double-setting",
        name = prefix .. items[i].name .. "-weight-modifier",
        setting_type = "startup",
        order = (items[i].order or "") .. ("c[item]-c[" .. items[i].name .. "]-c[item]-e[weight-modifier]"),
        default_value = items[i].weight_modifier,
        maximum_value = 111,
        minimum_value = 1 / (10 ^ 10),
    }
    settings[#settings+1] = {
        setting = items[i].setting  .. "_STACK_SIZE",
        type = "int-setting",
        name = prefix .. items[i].name .. "-stack-size",
        setting_type = "startup",
        order = (items[i].order or "") .. ("c[item]-c[" .. items[i].name .. "]-c[item]-g[stack-size]"),
        default_value = items[i].stack_size,
        maximum_value = 200,
        minimum_value = 1,
    }
end

return settings