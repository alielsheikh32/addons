function EZI:AddItem(entclass, name, model)
	EZI.Items[entclass] = {
		name = name,
		model = model
	}
end

EZI:AddItem("weapon_pistol", "9mm Pistol", Model("models/weapons/w_pistol.mdl"))
EZI:AddItem("food", "Chinese Food", Model("models/props_junk/garbage_takeoutcarton001a.mdl"))
EZI:AddItem("drug", "Drug", Model("models/props_lab/jar01a.mdl"))

EZI:AddItem("craft_metal", "Metal", Model("models/gibs/metal_gib4.mdl"))
EZI:AddItem("craft_bottle", "Bottle", Model("models/props_junk/garbage_glassbottle003a.mdl"))
EZI:AddItem("craft_gas", "Gasoline", Model("models/props_junk/gascan001a.mdl"))
EZI:AddItem("craft_pole", "Pole", Model("models/props_c17/signpole001.mdl"))
EZI:AddItem("craft_wood", "Wood", Model("models/props_debris/wood_board04a.mdl"))
EZI:AddItem("craft_wrench", "Wrench", Model("models/props_c17/tools_wrench01a.model"))
EZI:AddItem("m9k_ak47", "M9K AK47", Model("models/weapons/w_ak47_m9k.mdl"))

EZI:AddItem("spawned_shipment", "Shipment", Model("models/items/item_item_crate.mdl"))
EZI:AddItem("spawned_weapon", "Weapon", Model("models/weapons/w_rif_ak47.mdl"))
EZI:AddItem("spawned_food", "Food",  Model("models/props_junk/garbage_takeoutcarton001a.mdl"))

if (SERVER) then
	if DarkRPEntities then
		for k,v in pairs(DarkRPEntities) do
			if v.pocketable == true then
				EZI:AddItem(v.ent, v.name, v.model)
			end
		end
	end
	
	if CustomShipments then
		for k, v in pairs(CustomShipments) do
			EZI:AddItem(v.entity, v.name, v.model)
		end
	end
end
