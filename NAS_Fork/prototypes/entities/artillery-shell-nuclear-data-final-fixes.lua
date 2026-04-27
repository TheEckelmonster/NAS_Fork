local atomic_rocket = data.raw["projectile"]["atomic-rocket"]

local nuclear_artillery_projectile = util.table.deepcopy(data.raw["artillery-projectile"]["artillery-projectile"])
nuclear_artillery_projectile.name = "artillery-projectile-nuclear"

if (nuclear_artillery_projectile.action and not nuclear_artillery_projectile.action[1]) then
    nuclear_artillery_projectile.action = { nuclear_artillery_projectile.action, }
end

local actions = atomic_rocket.action[1] and atomic_rocket.action or { atomic_rocket.action, }
for k, v in pairs(actions) do
	table.insert(nuclear_artillery_projectile.action, v)
end

data:extend({ nuclear_artillery_projectile, })