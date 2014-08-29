local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 3

CRAFTING.Name = "AK47 [ Total Cost : $10,000 ] "
CRAFTING.Results = "m9k_ak47"
CRAFTING.WorldModel = "models/weapons/w_ak47_m9k.mdl"
CRAFTING.Ingredients = { 'craft_wood', 'craft_wood', 'craft_wrench', 'craft_wrench', 'craft_wrench', 'craft_metal' }

CRAFTING.HeatSource = true
CRAFTING.WaterSource = false

function CRAFTING.OnCraft( ply )
	return true
end

function CRAFTING.AfterCraft( ply )
	
end

------------------------------------------------

RegisterCrafting( CRAFTING )