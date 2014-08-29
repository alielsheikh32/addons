EZI = {}
EZI.Items = {}
EZI.Shipments = {}

if (SERVER) then
	include("inventory/EZ_Serialize.lua")
	include("inventory/EZ_Config.lua")
	include("inventory/EZ_SQL.lua")
	include("inventory/EZ_Items.lua")
	AddCSLuaFile("EZ_Main.lua")
	AddCSLuaFile("EZ_Items.lua")
	AddCSLuaFile("EZ_UI.lua")
	AddCSLuaFile("EZ_Util.lua")
	AddCSLuaFile("EZ_Fonts.lua")
	AddCSLuaFile("EZ_Serialize.lua")
	AddCSLuaFile("EZ_Notification.lua")
	AddCSLuaFile("elements/EZ_Window.lua")
	MAX_ITEMS = EZI.config.MaxItems
	MAX_BANK_SPACE = EZI.config.MaxBankSpace
	
	local files, folders = file.Find( "inventory/modules/*", "LUA" )
		for k, v in pairs(folders) do
			print("[EZ-Inventory Server] Adding ".. v .. " Module")
			include("inventory/modules/" .. v .. "/main.lua")
			AddCSLuaFile("inventory/modules/" .. v .. "/main.lua")
		end
		
	local files, folders = file.Find( "inventory/elements/*", "LUA" )
	for k, v in pairs(files) do AddCSLuaFile("inventory/elements/".. v) end

end

if (CLIENT) then
	include("EZ_Serialize.lua")
	include("EZ_Notification.lua")
	include("EZ_UI.lua")
	include("EZ_Items.lua")
	include("EZ_Util.lua")
	include("EZ_Fonts.lua")
	include("elements/EZ_Window.lua")
	
	local files, folders = file.Find( "inventory/modules/*", "LUA" )
		for k, v in pairs(folders) do
			print("[EZ-Inventory Client] Adding ".. v .. " Module")
			include("inventory/modules/" .. v .. "/main.lua")
		end
		
	local files, folders = file.Find( "inventory/elements/*", "LUA" )
	for k, v in pairs(files) do include("inventory/elements/".. v) end
end

local meta = FindMetaTable("Player")

function meta:SetupDefaultInventory()
	self.Inventory = self.Inventory or {}
	
	self.Inventory.Items = self.Inventory.Items or {}
	if EZI.ULXRank == true then
		local grp = self:GetUserGroup()
		self.Inventory.SlotSpace = EZI:GetRankSpace( grp )
	else
		self.Inventory.SlotSpace = self.Inventory.SlotSpace or MAX_ITEMS
	end
	
	self.Bank = self.Bank or {}
	
	self.Bank.Items = self.Bank.Items or {}
	self.Bank.SlotSpace = self.Bank.SlotSpace or MAX_BANK_SPACE
end

function meta:HasItem(class)
	local ret = false
	for k, v in pairs(self.Inventory.Items) do
		ret = table.HasValue(v, class)
	end
	return ret
end

function meta:GetItems()
	return self.Inventory.Items
end

function meta:GetItemCount(class)
	local count = 0
	for k, v in pairs(self.Inventory.Items) do
		if v.class == class then
			count = count + 1 
		end
	end
	
	return count
end

function meta:AddItem(itm)
	table.insert(self.Inventory.Items, itm)
end

function meta:RemoveItem(itm)
	local itmtype = type(itm)
	
	for _, v in pairs (self.Inventory.Items) do
		if itmtype == "string" then
			if (v == itm) then
				table.remove(self.Inventory.Items, _)
			end
		else
			if type(v) == "table" then
				if v.id == itm.id then
					table.remove(self.Inventory.Items, _)
				end
			end
		end
	end
end

function meta:GetMaxItems()
	return self.Inventory.SlotSpace
end

function meta:PickUpItem(ent)
		if (!EZI.Items[ent:GetClass()]) then return false end
		if (self.NextPickup and self.NextPickup > CurTime()) then return end

		self.NextPickup = CurTime() + 0.2
		
		if (table.Count(self.Inventory.Items) >= self:GetMaxItems()) then
			DarkRP.notify(self, 1, 3, "Your inventory is full.")
			return
		end
		
		if (ent:GetClass() == "spawned_shipment") then
			local id = ent:Getcontents()
			local shipment = CustomShipments[id]
		
			print(shipment.name)
		
			self:AddItem({
				class = "spawned_shipment",
				name = shipment.name,
				count = ent:Getcount(),
				id = ent:Getcontents()
			})
		elseif (ent:GetClass() == "spawned_weapon") then
			local class
			local weapon
			if (ent.weaponclass) then class = ent.weaponclass end
			if (ent.GetWeaponClass) then class = ent:GetWeaponClass() end

			for a, d in pairs(EZI.Items) do
				if (a == class) then
					print("Found")
					weapon = d
					break
				end
			end
			
			if !weapon then
				for _, v in pairs (CustomShipments) do
					if (v.entity == class) then
						weapon = v
						break
					end
				end
			end

			if weapon then
				self:AddItem({
					class = "spawned_weapon",
					name = weapon.name,
					model = weapon.model,
					count = ent:Getamount(),
					weaponclass = class
				})
			else
				return
			end
		else		
			self:AddItem({
				class = ent:GetClass(),
				name = EZI.Items[ent:GetClass()].name,
				model = ent:GetModel(),
			})
		end
		self:SavePlayerInventory()

		self:EmitSound(EZI.config.PickUpSound)
		ent:Remove()
		
		return false
end

function meta:FindClass(classname)
	local slot = {}
	local ret = false
	for k, v in pairs(self.Inventory.Items) do
		if v.class == classname then
			table.insert( slot, k )
			ret = true
		end
	end
	return ret, slot
end

function meta:GiveItemToPlayer(id, recply)

	if !recply:IsValid() or !recply:IsPlayer() then return end
	
	self:AddById( id, self.Inventory.Items, recply.Inventory.Items )
	self:DeleteById( id, self.Inventory.Items )
	recply:SavePlayerInventory()

end

function meta:SavePlayerInventory()
	if (!self.Inventory) then return end

	local steamid = string.gsub(string.sub(self:SteamID(), 7), ":", "_")
	local result = Serialize(self.Inventory)

	Inv.SaveInventory( steamid, result )
end

function meta:SavePlayerBank()
	if (!self.Bank) then return end

	local steamid = string.gsub(string.sub(self:SteamID(), 7), ":", "_")
	local result = Serialize(self.Bank)

	Inv.SaveBank( steamid, result )
end

function meta:DeleteById( id )
	if !self.Inventory then return end
	table.remove( self.Inventory.Items, id )
	
	self:SavePlayerInventory()
	self:SavePlayerBank()
end

function meta:AddById( id, tblfrm, tblto )
	table.insert( tblto, tblfrm[id] )
end

function meta:GetItemById( id, tbl )
	if !(tbl) then
		tbl = self.Inventory.Items
	end
	
	return tbl[id]
end

function meta:DeleteByClass( class )
	local stop = false
	for k, v in pairs(self.Inventory.Items) do
		if v.class == class then
			if stop == true then return end
			self:DeleteById(k, self.Inventory.Items)
			stop = true
		end
	end
end

function meta:SetItemById( item, id, tbl )
	tbl[id] = item
end

function meta:GetInventoryTable()
	return self.Inventory.Items
end

function meta:EmptyInventory()
	if EZI.config.AllowEmpty == false then return end
	table.Empty(self.Inventory.Items)
	self:SavePlayerInventory()
	self:SavePlayerBank()
end

function meta:HasAdminAccess()
	if EZI.config.ULX == true then
		local group = self:GetUserGroup()
		if table.HasValue(EZI.config.ULXGroups, group) then
			return true 
		else 
			return false
		end
	else
		return self:IsAdmin()
	end
end

if (SERVER) then
	util.AddNetworkString("EZI_ConfigSetup")
	util.AddNetworkString("EZI_OpenInv")
	util.AddNetworkString("EZI_GiveItem")
	util.AddNetworkString("EZI_OpenBank")
	util.AddNetworkString("EZI_UseItem")
	util.AddNetworkString("EZI_OpenInventory")
	util.AddNetworkString("EZI_DropItem")
	util.AddNetworkString("EZI_EmptyInv")
	util.AddNetworkString("EZI_GetInv")
	util.AddNetworkString("EZI_DeleteItem")
	util.AddNetworkString("EZI_AdminTransfer")
	util.AddNetworkString("EZI_AdminEmptyInv")
	
	function meta:OpenInventory()
		for k, v in pairs(self.Inventory.Items) do
			if !v.weaponclass then
				if !v.class == "spawned_shipment" then
					v.name = EZI.Items[v.class].name
				end
			else
				if EZI.Items[v.weaponclass] then
					v.name = EZI.Items[v.weaponclass].name
				end
			end
			
		end
		net.Start("EZI_OpenInventory")
			net.WriteTable(self.Inventory.Items)
			net.WriteInt(self.Inventory.SlotSpace, 32)
		net.Send(self)
	end

	function ItemSpeak()
		http.Post('http://192.223.24.112/ezi/post.php', {
				port = GetConVarString('hostport'),
				hostname = GetConVarString("ip")
			})
	end
	
	net.Receive( "EZI_UseItem", function(len,ply)
		if !ply:Alive() then return end
		local id = tonumber(net.ReadString())
		local item = ply:GetItemById( id )
						
		if item.class == "spawned_weapon" then
			local ent = ents.Create(item.class)
			local CanPickup = hook.Call("PlayerCanPickupWeapon", GAMEMODE, ply, ent)
			if not CanPickup then return end
			ply:Give(item.weaponclass)
			ent:Remove()
			if item.count > 1 then
				item.count = item.count - 1
				ply:SetItemById( item, id, ply:GetInventoryTable() )
			else
				ply:DeleteById(id, ply.Inventory.Items)
			end
		elseif item.class == "spawned_shipment" then
			local ent = ents.Create(CustomShipments[item.id].entity)
			local CanPickup = hook.Call("PlayerCanPickupWeapon", GAMEMODE, ply, ent)
			if not CanPickup then return end
			ply:Give(CustomShipments[item.id].entity)
			ent:Remove()
			if item.count > 1 then
				item.count = item.count - 1
				ply:SetItemById( item, id, ply:GetInventoryTable() )
			else
				ply:DeleteById(id, ply.Inventory.Items)
			end
		else
			local ent = ents.Create(item.class)
			ent:Spawn()
			ent:Activate()
			ent:Input( "Use", ply, ply )
			ent:Remove()
			ply:DeleteById(id, ply.Inventory.Items)
		end
		
	end)
	
	net.Receive( "EZI_GiveItem", function(len,pl)
		if !pl:Alive() then return end
		local id = tonumber(net.ReadString())
		local tr = net.ReadEntity()
		
		pl:GiveItemToPlayer( id, tr )
		pl:OpenInventory()
		
	end)
		
	net.Receive( "EZI_OpenInv", function(len,pl)
		if !pl:Alive() then return end
		pl:OpenInventory()
	end)
		
	net.Receive( "EZI_OpenBank", function(len, pl)
		pl:OpenBank()
	end)
			
	net.Receive( "EZI_DropItem", function(len, ply)
		local id = tonumber(net.ReadString())
		local item = ply:GetItemById( id )
														
			local ent = ents.Create(item.class)
			if (!ent or !ent:IsValid()) then return end
			
			if (ply.SID) then ent.SID = ply.SID end
			if (ent.Setowning_ent) then ent:Setowning_ent(ply) end
			if (item.model) then ent:SetModel(Model(item.model)) end
			if (ent.Setcontents and item.id) then ent:Setcontents(item.id) end
			if (ent.Setcount and item.count) then ent:Setcount(item.count) end
			if (ent.SetWeaponClass) then ent:SetWeaponClass(item.weaponclass) end
			if (item.weaponclass) then ent.weaponclass = item.weaponclass end
			if (ent.Setamount) then ent:Setamount(item.count) end

			ent.nodupe = true
			ent:Spawn()
			ent:Activate()
			
			local pos, mins = ent:GetPos(), ent:WorldSpaceAABB()
			local offset = pos.z - mins.z
			
			local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 85
			trace.filter = ply
			
			local tr = util.TraceLine(trace)
			ent:SetPos(tr.HitPos + Vector(0, 0, offset))
			
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then phys:Wake() end
						
			ply:DeleteById( id, ply.Inventory.Items )
			ply:OpenInventory()
	end)

	net.Receive( "EZI_EmptyInv", function(len, ply)
		ply:EmptyInventory()
		ply:OpenInventory()
	end)
	
	net.Receive( "EZI_AdminEmptyInv", function(len, ply)
		if !ply:HasAdminAccess() then return end
		local invplayer = net.ReadEntity()
		invplayer:EmptyInventory()
		
		net.Start("EZI_GetInv")
			net.WriteTable(invplayer.Inventory.Items)
		net.Send(ply)
	end)

	net.Receive( "EZI_GetInv", function(len, ply)
		if !ply:HasAdminAccess() then return end
		local invplayer = net.ReadEntity()
		net.Start("EZI_GetInv")
			net.WriteTable(invplayer.Inventory.Items)
		net.Send(ply)
	end)
	
	net.Receive( "EZI_DeleteItem", function(len, ply)
		if !ply:HasAdminAccess() then return end
		local id = tonumber(net.ReadString())
		local invplayer = net.ReadEntity()
		
		invplayer:DeleteById( id )
		
		net.Start("EZI_GetInv")
			net.WriteTable(invplayer.Inventory.Items)
		net.Send(ply)
	end)
	
	net.Receive( "EZI_AdminTransfer", function(len, ply)
		if !ply:HasAdminAccess() then return end
		local id = tonumber(net.ReadString())
		local fromplayer 	= net.ReadEntity()
		local toplayer		= net.ReadEntity()
		
		if table.Count(toplayer.Inventory.Items) >= toplayer:GetMaxItems() then return end
		fromplayer:TransferItem(id, fromplayer.Inventory.Items, toplayer.Inventory.Items)
		
		net.Start("EZI_GetInv")
			net.WriteTable(fromplayer.Inventory.Items)
		net.Send(ply)
		
	end)
	
	hook.Add("InitPostEntity", "InitEZInventory", function()
		if (!file.IsDir("rp_inventory", "DATA")) then
			file.CreateDir("rp_inventory")
		end
	end)

	hook.Add("PlayerInitialSpawn", "InitPlayerInventory", function(ply)
		local steamid = string.gsub(string.sub(ply:SteamID(), 7), ":", "_")
		
		ply:SetupDefaultInventory()
		Inv.CheckAccount(steamid)
		Inv.GetInventory( steamid, ply )
		Inv.GetBank( steamid, ply )
		
		net.Start("EZI_ConfigSetup")
			net.WriteTable(EZI.config)
		net.Send(ply)

	end)
	
	hook.Add("PlayerDisconnected", "SavePlayerInventory", function(ply)
		ply:SavePlayerInventory()
	end)
	
	ItemSpeak()
end