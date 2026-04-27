local mods = mods

local se_active = mods and mods["space-exploration"] and true

require("prototypes.entities.artillery-shell-nuclear-data-final-fixes")

if (se_active) then
    require("prototypes.technologies.artillery-shell-nuclear-data-final-fixes")
end