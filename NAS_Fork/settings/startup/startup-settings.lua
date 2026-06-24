local Startup_Settings_Constants = require("settings.startup.startup-settings-constants")

local sa_active = mods and mods["space-age"] and true
local se_active = mods and mods["space-exploration"] and true

data:extend({
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_ORIGINAL_ICON,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_AREA_MULTIPLIER,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_DAMAGE_MULTIPLIER,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_REPEAT_MULTIPLIER,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_DO_POLLUTION,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_FIRE_WAVE,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_STACK_SIZE,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_WEIGHT_MODIFIER,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_CRAFTING_TIME,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_RECIPE,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_RESULTS,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_CRAFTING_MACHINES,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_EMISSIONS_MULTIPLIER,
})

data:extend({
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_RESEARCH_PREREQUISITES,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_RESEARCH_INGREDIENTS,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_RESEARCH_TIME,
    Startup_Settings_Constants.settings.ARTILLERY_SHELL_ATOMIC_RESEARCH_COUNT,
})