local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 7

CRAFTING.Name = "Famas [ Total Cost : $14,000 ] "
CRAFTING.Results = "m9k_famas"
CRAFTING.WorldModel = "models/weapons/w_tct_famas.mdl"
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