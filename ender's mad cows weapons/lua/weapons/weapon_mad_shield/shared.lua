// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFOV			= 47
SWEP.ViewModelFlip		= false
SWEP.WorldModel = "" 
SWEP.ViewModel =  "models/weapons/v_pistol.mdl"
SWEP.HoldType				= "duel"
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.Category			= "Mad Cows Weapons"
SWEP.UseHands			= false

SWEP.Primary.Sound		= Sound("")
SWEP.Primary.Recoil		= 0
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay 		= 0

SWEP.Primary.ClipSize		= -1				// Size of a clip
SWEP.Primary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.Delay 		= 0.40

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.ComboActivated		= false 
SWEP.QuickHittingTime		= 0

SWEP.IronSightsPos 		= Vector (0.001, -6.7271, 5.4635)
SWEP.IronSightsAng 		= Vector (-55.5761, -2.6453, 0)
SWEP.RunArmOffset 		= Vector (-0.3561, 0, 5.9544)
SWEP.RunArmAngle 			= Vector (-28.873, -1.6004, 0)

SWEP.ComboHit = {
	Sound("physics/body/body_medium_break2.wav"),
	Sound("physics/body/body_medium_break3.wav")
}



/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/



/*---------------------------------------------------------
   Name: SWEP:Initialize()
   Desc: Called when the weapon is first loaded.
---------------------------------------------------------*/
function SWEP:Initialize()

	if (SERVER) then
		self:SetWeaponHoldType(self.HoldType)

		self:SetNPCMinBurst(30)
		self:SetNPCMaxBurst(30)
		self:SetNPCFireRate(self.Primary.Delay)
	end

	self:SetHolsted(true)
end


function SWEP:Deploy()
	if SERVER then
		if IsValid(self.ent) then return end //Makes it not able to spawn multiple entities.
		self:SetNoDraw(true)
		self.ent = ents.Create("prop_physics")
			self.ent:SetModel("models/arleitiss/riotshield/shield.mdl")
			self.ent:SetPos(self.Owner:GetPos() + Vector(0,0,7) + (self.Owner:GetForward()*19))
			self.ent:SetAngles(Angle(0,self.Owner:EyeAngles().y,self.Owner:EyeAngles().r))
			self.ent:SetParent(self.Owner)
			self.ent:Fire("SetParentAttachmentMaintainOffset", "chest", 0) // Garry fucked up the parenting on players in latest patch..
			self.ent:SetCollisionGroup( COLLISION_GROUP_WORLD ) // Lets it not collide to anything but world. Taken from Nocollide Rightclick Code
			self.ent:Spawn()
			self.ent:Activate()
	end
	return true
end


function SWEP:Holster()
	if SERVER then
		if not IsValid(self.ent) then return end
		self.ent:Remove()
	end
	return true
end


function SWEP:OnDrop()
	if SERVER then
		self:SetColor(Color(255,255,255,255))
		if not IsValid(self.ent) then return end
		self.ent:Remove()
	end
end

function SWEP:OnRemove()
	if SERVER then
		self:SetColor(Color(255,255,255,255))
		if not IsValid(self.ent) then return end
		self.ent:Remove()
	end
end