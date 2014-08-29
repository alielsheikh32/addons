local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 11

CRAFTING.Name = "M24 [ Total Cost : $26,000 ] "
CRAFTING.Results = "m9k_m24"
CRAFTING.WorldModel = "models/weapons/w_snip_m24_6.mdl"
CRAFTING.Ingredients = { 'craft_metal', 'craft_metal', 'craft_metal', 'craft_metal', 'craft_wrench', 'craft_wrench' }

--CRAFTING.RestrictToGroup = { 'vip' }

CRAFTING.HeatSource = true
CRAFTING.WaterSource = false

function CRAFTING.OnCraft( ply )
	return true
end

function CRAFTING.AfterCraft( ply )

end

------------------------------------------------

RegisterCrafting( CRAFTING )