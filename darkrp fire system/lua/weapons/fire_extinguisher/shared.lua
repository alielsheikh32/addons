if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Fire Extinguisher"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Frozen Odyssey"
SWEP.Instructions = "Left Click: Extinguish Fires"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.UseHands = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = "models/weapons/v_fire_extinguisher.mdl"
SWEP.WorldModel = "models/weapons/w_fire_extinguisher.mdl"

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:PrimaryAttack()	
	self.Weapon:EmitSound( Sound("ambient/wind/wind_hit2.wav") )
	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Weapon:SetNextPrimaryFire( CurTime() + .1 )
		
	local ExtinguishEffect = EffectData()
	ExtinguishEffect:SetEntity(self.Owner)
	util.Effect( "extinguish", ExtinguishEffect )
	
	if SERVER then
		local trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 150
		trace.filter = self.Owner

		local tr = util.TraceLine( trace )
		
		for k, v in pairs( ents.FindInSphere( tr.HitPos, 50 ) ) do
			if v:GetClass() == "fire" then
				v:ExtinguishAttack( self.Owner )
			end
			
			if v:IsOnFire() then 
				v:Extinguish()
				v:SetColor( Color(255,255,255,255) )
			end
		end
	end
end

function SWEP:SecondaryAttack()
end