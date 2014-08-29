local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 8

CRAFTING.Name = "G36 [ Total Cost : $14,000 ] "
CRAFTING.Results = "m9k_g36"
CRAFTING.WorldModel = "models/weapons/w_hk_g36c.mdl"
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