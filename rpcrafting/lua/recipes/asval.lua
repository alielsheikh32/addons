local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 5

CRAFTING.Name = "AS VAL [ Total Cost : $15,000 ] "
CRAFTING.Results = "m9k_val"
CRAFTING.WorldModel = "models/weapons/w_dmg_vally.mdl"
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