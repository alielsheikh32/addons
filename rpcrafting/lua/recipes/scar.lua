local CRAFTING = {}

------------------------------------------------

CRAFTING.ID = 13

CRAFTING.Name = "Scar [ Total Cost : $15,000 ] "
CRAFTING.Results = "m9k_scar"
CRAFTING.WorldModel = "models/weapons/w_fn_scar_h.mdl"
CRAFTING.Ingredients = { 'craft_wood', 'craft_wood', 'craft_wrench', 'craft_wrench', 'craft_metal', 'craft_metal' }

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