local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 1

CRAFTING.Name = "Piece of Metal"
CRAFTING.Results = "craft_metal"
CRAFTING.WorldModel = "models/gibs/metal_gib4.mdl"
CRAFTING.Ingredients = { 'craft_pole', 'craft_wrench' }

CRAFTING.HeatSource = true
CRAFTING.WaterSource = false

function CRAFTING.OnCraft( ply )
	return true
end

function CRAFTING.AfterCraft( ply )
	
end

------------------------------------------------

RegisterCrafting( CRAFTING )