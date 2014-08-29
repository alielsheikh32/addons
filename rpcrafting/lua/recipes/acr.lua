local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 2

CRAFTING.Name = "ACR [ Total Cost : $8,500 ] "
CRAFTING.Results = "m9k_acr"
CRAFTING.WorldModel = "models/weapons/w_masada_acr.mdl"
CRAFTING.Ingredients = { 'craft_wood', 'craft_wood', 'craft_wood', 'craft_wrench', 'craft_metal' }

--CRAFTING.RestrictToGroup = { 'respected' }

CRAFTING.HeatSource = true
CRAFTING.WaterSource = false

function CRAFTING.OnCraft( ply )
	return true
end

function CRAFTING.AfterCraft( ply )

end

------------------------------------------------

RegisterCrafting( CRAFTING )