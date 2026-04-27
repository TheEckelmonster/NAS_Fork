local mods = mods

local se_active = mods and mods["space-exploration"] and true

if (not se_active) then
    require("prototypes.technologies.artillery-shell-nuclear-data-updates")
end