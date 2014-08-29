CRAFTING_DATABASE = {}

function RegisterCrafting( Crafting )
	if CRAFTING_DATABASE[Crafting.ID] then
		MsgN( "Crafting ID already exists: #" .. Crafting.ID .. " (" .. Crafting.Name .. ")" )
		return
	end

	if not Crafting.Ingredients then
		MsgN( "Couldn't find crafting ingredients for Crafting ID #" .. Crafting.ID .. " (" .. Crafting.Name .. ")" )
		return
	end

	Crafting.OldIngredients = Crafting.Ingredients
	Crafting.Ingredients = {}

	table.insert(Crafting.Ingredients, Crafting.OldIngredients)

	Crafting.Name = Crafting.Name or "<Unknown Name>"
	Crafting.Results = Crafting.Results or "<Unknown Result>"
	

	MsgN( "[#" .. Crafting.ID .. "] Loaded " .. Crafting.Name .. " crafting" )
	CRAFTING_DATABASE[Crafting.ID] = Crafting
end