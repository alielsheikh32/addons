if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName = "Keypad Cracker"
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

-- Variables that are used on both client and server

SWEP.Instructions = "Left click to crack a keypad"
SWEP.Contact = "FrozenOdyssey.TK"
SWEP.Purpose = "Attaches a keypad cracker on a keypad."

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/v_c4.mdl")
SWEP.WorldModel = Model("models/weapons/w_c4.mdl")

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""

/*---------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	if (SERVER) then
		self:SetWeaponHoldType("normal")
	end
end

/*---------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------*/

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .3)
	if CLIENT then return end

	local trace = self.Owner:GetEyeTrace()
	local e = trace.Entity
	if IsValid(e) and trace.HitPos:Distance(self.Owner:GetShootPos()) <= 50 and (e:GetClass() == "sent_keypad") then
		if e:GetNWBool("keypad_broken") then return end
		if e.being_cracked then return end
		self.Weapon:SetNextPrimaryFire(CurTime() + 5)
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		timer.Simple(3, function()
			if IsValid(self) then
				self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
				local trace = self.Owner:GetEyeTrace()
				local e = trace.Entity
				if IsValid(e) and trace.HitPos:Distance(self.Owner:GetShootPos()) <= 50 and (e:GetClass() == "sent_keypad") then
					if e:GetNWBool("keypad_broken") then return end
					if e.being_cracked then return end
					local attached_keypad_cracker = ents.Create("keypad_cracker_attached")
					if IsValid(attached_keypad_cracker) then
						attached_keypad_cracker.ShareGravgun = false
						attached_keypad_cracker.nodupe = true
						attached_keypad_cracker.SID = self.Owner.SID
						attached_keypad_cracker:Spawn()
						attached_keypad_cracker:Attach(trace.Entity)
					end
					self.Weapon:Remove()
				end
			end
		end)
	end 
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end