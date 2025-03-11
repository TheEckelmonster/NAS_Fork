
-- nuclear artillery shell
local nuclear_artillery_projectile = util.table.deepcopy(data.raw["artillery-projectile"]["artillery-projectile"])
nuclear_artillery_projectile.name = "artillery-projectile-nuclear"

for k, v in pairs(data.raw["projectile"]["atomic-rocket"].action.action_delivery.target_effects) do
	table.insert(nuclear_artillery_projectile.action.action_delivery.target_effects, v)
end

local uranium_cost = 30

if mods ["space-age"] then
	uranium_cost = 100
end

data:extend(
	{
		nuclear_artillery_projectile,
		{
			type = "ammo",
			name = "artillery-shell-nuclear",
			icon = "__NAS_Fork__/graphics/artillery-shell-nuclear.png",
			icon_size = 32,
			ammo_category = "artillery-shell",
			ammo_type =
			{
				category = "artillery-shell",
				target_type = "position",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "artillery",
						projectile = "artillery-projectile-nuclear",
						starting_speed = 1,
						direction_deviation = 0,
						range_deviation = 0,
						source_effects =
						{
							type = "create-explosion",
							entity_name = "artillery-cannon-muzzle-flash"
						}
					}
				}
			},
			subgroup = "ammo",
			order = "d[explosive-cannon-shell]-d[artillery]2",
			stack_size = 1
		},
		{
			type = "recipe",
			name = "artillery-shell-nuclear",
			enabled = false,
			energy_required = 50,
			ingredients =
			{
				{type = "item", name = "artillery-shell", amount = 1},
				{type = "item", name = "uranium-235", amount = uranium_cost}
			},
			results = {{type = "item", name = "artillery-shell-nuclear", amount = 1}}
		},
		{
			type = "technology",
			name = "artillery-shell-nuclear",
			icon_size = 256, icon_mipmaps = 4,
			icon = "__base__/graphics/technology/atomic-bomb.png",
			effects =
			{
				{
					type = "unlock-recipe",
					recipe = "artillery-shell-nuclear"
				},
			},
			prerequisites = {"atomic-bomb", "artillery"},
			unit =
			{
				ingredients =
				{
					{"automation-science-pack", 1},
					{"logistic-science-pack", 1},
					{"chemical-science-pack", 1},
					{"military-science-pack", 1},
					{"utility-science-pack", 1},
				},
				time = 15,
				count = 1000
			},
			order = "d-e-f"
		}
	}
)
