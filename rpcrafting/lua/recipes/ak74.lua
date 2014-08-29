local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 4

CRAFTING.Name = "AK74 [ Total Cost : $15,000 ] "
CRAFTING.Results = "m9k_ak74"
CRAFTING.WorldModel = "models/weapons/w_tct_ak47.mdl"
CRAFTING.Ingredients = { 'craft_wood', 'craft_wood', 'craft_wrench', 'craft_wrench', 'craft_metal', 'craft_metal' }

CRAFTING.HeatSource = true
CRAFTING.WaterSource = false

function CRAFTING.OnCraft( ply )
	return true
end

function CRAFTING.AfterCraft( ply )

end

------------------------------------------------

RegisterCrafting( CRAFTING )