local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 9

CRAFTING.Name = "M4A1 [ Total Cost : $8,000 ] "
CRAFTING.Results = "m9k_m4a1"
CRAFTING.WorldModel = "models/weapons/w_rif_m4a1.mdl"
CRAFTING.Ingredients = { 'craft_wood', 'craft_wood', 'craft_wrench', 'craft_metal' }

CRAFTING.HeatSource = true
CRAFTING.WaterSource = false

function CRAFTING.OnCraft( ply )
	return true
end

function CRAFTING.AfterCraft( ply )

end

------------------------------------------------

RegisterCrafting( CRAFTING )