local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 6

CRAFTING.Name = "AUG [ Total Cost : $14,000 ] "
CRAFTING.Results = "m9k_auga3"
CRAFTING.WorldModel = "models/weapons/w_auga3.mdl"
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