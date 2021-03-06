if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Pocket"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Base = "weapon_cs_base2"

SWEP.Author = "FPtje and everyone who gave FPtje the idea"
SWEP.Instructions = "Left click to pick up, right click to drop, reload for menu"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IconLetter = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"
SWEP.WorldModel	= ""

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

if CLIENT then
	SWEP.FrameVisible = false
end

function SWEP:Initialize()
	//self:SetWeaponHoldType("normal")
end

function SWEP:Deploy()
	if not SERVER then return end

	self.Owner:DrawViewModel(false)
	self.Owner:DrawWorldModel(false)
end

function SWEP:Equip(newOwner)
	if not SERVER then return end

	local t = self.Owner:Team()
	self.MaxPocketItems = RPExtraTeams[t] and RPExtraTeams[t].maxpocket or GAMEMODE.Config.pocketitems

	local i = self.Owner.Pocket and #self.Owner.Pocket or 0
	while i > self.MaxPocketItems do
		self.Owner:DropPocketItem(self.Owner.Pocket[i])
		self.Owner.Pocket[i] = nil
		i = i - 1
	end
end

local blacklist = {"fadmin_jail", "drug_lab", "money_printer", "meteor", "microwave", "door", "func_", "player", "beam", "worldspawn", "env_", "path_", "spawned_shipment", "prop_physics"}
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)

	if not SERVER then return end

	local ent = self.Owner:GetEyeTrace().Entity
	/*local canPickup, message = hook.Call("canPocket", nil, self.Owner, ent)
	
	print(tostring(canPickup))

	if not canPickup then
		if message then DarkRP.notify(self.Owner, 1, 4, message) end
		return
	end*/

	self.Owner:PickUpItem(ent)
end

function SWEP:SecondaryAttack()
	if not SERVER then return end

	self.Owner:OpenInventory()
end

SWEP.OnceReload = false
function SWEP:Reload()
	if not SERVER then return end

	self.Owner:OpenInventory()
end

if CLIENT then
	local frame
	local function Reload()
		if not ValidPanel(frame) or not frame:IsVisible() then return end
		local items = LocalPlayer():GetTable().Pocket
		if not items or next(items) == nil then frame:Close() return end
		frame:SetSize(#items * 64, 90)
		frame:Center()
		for k,v in pairs(items) do
			if not IsValid(v) then
				items[k] = nil
				for a,b in pairs(LocalPlayer().Pocket) do
					if b == v or not IsValid(b) then
						LocalPlayer():GetTable().Pocket[a] = nil
					end
				end
				items = table.ClearKeys(items)
				frame:Close()
				PocketMenu()
				break
			end
			local icon = vgui.Create("SpawnIcon", frame)
			icon:SetPos((k-1) * 64, 25)
			icon:SetModel(v:GetModel())
			icon:SetSize(64, 64)
			icon:SetToolTip()
			icon.DoClick = function()
				icon:SetToolTip()
				RunConsoleCommand("_RPSpawnPocketItem", v:EntIndex())
				items[k] = nil
				for a,b in pairs(LocalPlayer().Pocket) do
					if b == v then
						LocalPlayer():GetTable().Pocket[a] = nil
					end
				end
				if #items == 0 then
					frame:Close()
					return
				end
				items = table.ClearKeys(items)
				Reload()
				LocalPlayer():GetActiveWeapon():SetWeaponHoldType("pistol")
				timer.Simple(0.2, function() if LocalPlayer():GetActiveWeapon():IsValid() then LocalPlayer():GetActiveWeapon():SetWeaponHoldType("normal") end end)
			end
		end
	end

	local function StorePocketItem(um)
		LocalPlayer():GetTable().Pocket = LocalPlayer():GetTable().Pocket or {}

		local ent = Entity(um:ReadShort())
		if IsValid(ent) and not table.HasValue(LocalPlayer():GetTable().Pocket, ent) then
			table.insert(LocalPlayer():GetTable().Pocket, ent)
		end

		Reload()
	end
	usermessage.Hook("Pocket_AddItem", StorePocketItem)

	local function RemovePocketItem(um)
		LocalPlayer():GetTable().Pocket = LocalPlayer():GetTable().Pocket or {}

		local ent = Entity(um:ReadShort())
		for k,v in pairs(LocalPlayer():GetTable().Pocket) do
			if v == ent then LocalPlayer():GetTable().Pocket[k] = nil end
		end

		Reload()
	end
	usermessage.Hook("Pocket_RemoveItem", RemovePocketItem)

	local function PocketMenu()
		if frame and frame:IsValid() and frame:IsVisible() then return end
		if LocalPlayer():GetActiveWeapon():GetClass() ~= "pocket" then return end
		if not LocalPlayer():GetTable().Pocket then LocalPlayer():GetTable().Pocket = {} return end
		for k,v in pairs(LocalPlayer():GetTable().Pocket) do if not IsValid(v) then table.remove(LocalPlayer():GetTable().Pocket, k) end end
		if #LocalPlayer():GetTable().Pocket <= 0 then return end
		LocalPlayer():GetTable().Pocket = table.ClearKeys(LocalPlayer():GetTable().Pocket)
		frame = vgui.Create("DFrame")
		frame:SetTitle("Drop item")
		frame:SetVisible(true)
		frame:MakePopup()

		Reload()
		frame:SetSkin(GAMEMODE.Config.DarkRPSkin)
	end
	usermessage.Hook("StartPocketMenu", PocketMenu)
elseif SERVER then
	local function Spawn(ply, cmd, args)
		if not IsValid(ply:GetActiveWeapon()) or ply:GetActiveWeapon():GetClass() ~= "pocket" then
			return
		end
		if ply:GetTable().Pocket and IsValid(Entity(tonumber(args[1]))) then
			local ent = Entity(tonumber(args[1]))
			if not table.HasValue(ply.Pocket, ent) then return end

			for k,v in pairs(ply:GetTable().Pocket) do
				if v == ent then
					ply:GetTable().Pocket[k] = nil
				end
			end
			ply:GetTable().Pocket = table.ClearKeys(ply:GetTable().Pocket)

			ply:GetActiveWeapon():SetWeaponHoldType("pistol")
			timer.Simple(0.2, function() if ply:GetActiveWeapon():IsValid() then ply:GetActiveWeapon():SetWeaponHoldType("normal") end end)

			ply:DropPocketItem(ent)
		end
	end
	concommand.Add("_RPSpawnPocketItem", Spawn)

	local meta = FindMetaTable("Player")
	function meta:DropPocketItem(ent)
		local trace = {}
		trace.start = self:EyePos()
		trace.endpos = trace.start + self:GetAimVector() * 85
		trace.filter = self
		local tr = util.TraceLine(trace)
		ent:SetMoveType(MOVETYPE_VPHYSICS)
		ent:SetNoDraw(false)
		ent:SetCollisionGroup(ent.OldCollisionGroup)
		ent:SetPos(tr.HitPos)
		ent:SetSolid(SOLID_VPHYSICS)
		local phys = ent:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableCollisions(true)
			phys:EnableMotion(true)
			phys:Wake()
		end
		umsg.Start("Pocket_RemoveItem", self)
			umsg.Short(ent:EntIndex())
		umsg.End()
		ent.PhysgunPickup = nil
		ent.PlayerUse = ent.OldPlayerUse
		ent.OldPlayerUse = nil
		ent.IsPocketed = nil
	end

	hook.Add("PlayerDeath", "DropPocketItems", function(ply)
		local pocket = ply.Pocket
		if not GAMEMODE.Config.droppocketdeath or not pocket then return end

		ply.Pocket = nil

		for k, v in pairs(pocket) do
			if IsValid(v) then
				ply:DropPocketItem(v)
			end
		end
	end)
end
