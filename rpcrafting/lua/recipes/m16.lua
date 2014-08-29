local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 10

CRAFTING.Name = "M16 [ Total Cost : $14,000 ] "
CRAFTING.Results = "m9k_m16a4_acog"
CRAFTING.WorldModel = "models/weapons/w_dmg_m16ag.mdl"
CRAFTING.Ingredients = { 'craft_metal', 'craft_metal', 'craft_wrench', 'craft_wrench' }

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