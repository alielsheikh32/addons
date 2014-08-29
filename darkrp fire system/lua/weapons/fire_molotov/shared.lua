if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Molotov Cocktail"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Frozen Odyssey"
SWEP.Instructions = "Left Click: Throw Molotov"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.UseHands	= true

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

SWEP.ViewModel = "models/weapons/v_beerbo2.mdl"
SWEP.WorldModel = "models/weapons/w_beerbot.mdl"

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:PrimaryAttack()	
	local ent = self.Owner:GetEyeTrace().Entity

	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	
	if SERVER then
		local MolotovObject = ents.Create("fire_molotov_object")
		MolotovObject:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector() * 20 )
		MolotovObject:Spawn()
		MolotovObject:GetPhysicsObject():ApplyForceCenter( self.Owner:GetAimVector() * 1400 )
		
		self.Owner:StripWeapon("fire_molotov")
	end
end