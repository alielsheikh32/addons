local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 12

CRAFTING.Name = "Molotov"
CRAFTING.Results = "fire_molotov"
CRAFTING.WorldModel = "models/weapons/w_beerbot.mdl"
CRAFTING.Ingredients = { 'craft_gas', 'craft_gas', 'craft_bottle' }

--CRAFTING.RestrictToGroup = { 'vip' }

CRAFTING.HeatSource = false
CRAFTING.WaterSource = false

function CRAFTING.OnCraft( ply )
	return true
end

function CRAFTING.AfterCraft( ply )

end

------------------------------------------------

RegisterCrafting( CRAFTING )