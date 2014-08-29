-- Variables that are used on both client and server
SWEP.Gun = ("m9k_dbarrel") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "M9K Shotguns"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Double Barrel Shotgun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 69			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"	-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_doublebarrl.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_double_barrel_shotgun.mdl"	-- Weapon world model
SWEP.Base 				= "bobs_shotty_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("Double_Barrel.Single")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 180		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 2			-- Size of a clip
SWEP.Primary.DefaultClip		= 30	-- Default number of bullets in a clip
SWEP.Primary.KickUp				= 10				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 5		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 5	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 0		-- How much you 'zoom' in. Less is more! 

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.ShellTime			= .5

SWEP.Primary.NumShots	= 18		-- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage		= 10	-- Base damage per bullet
SWEP.Primary.Spread		= .03	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .03	-- Ironsight accuracy, should be the same for shotguns
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(0, 0, 0)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(11.475, -7.705, -2.787)
SWEP.RunSightsAng = Vector(0.574, 51.638, 5.737)

SWEP.Secondary.Sound = Sound("dbarrel_dblast")

function SWEP:SecondaryAttack()
	local timerName = "ShotgunReload_" ..  self.Owner:UniqueID()
	if (timer.Exists(timerName)) then return end
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
	if self.Weapon:Clip1() == 2 then
		if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
			self:ShootBulletInformation2()
			self.Weapon:TakePrimaryAmmo(2)
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self.Weapon:EmitSound(self.Secondary.Sound)
	
			local fx 		= EffectData()
			fx:SetEntity(self.Weapon)
			fx:SetOrigin(self.Owner:GetShootPos())
			fx:SetNormal(self.Owner:GetAimVector())
			fx:SetAttachment(self.MuzzleAttachment)
			if GetConVar("M9KGasEffect") != nil then
				if GetConVar("M9KGasEffect"):GetBool() then 
					util.Effect("m9k_rg_muzzle_rifle",fx)
				end
			end
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			self.Weapon:SetNextSecondaryFire(CurTime()+1/((self.Primary.RPM/2)/60))
			self:CheckWeaponsAndAmmo()
			self.RicochetCoin = (math.random(1,8))
		if self.BoltAction then self:BoltBack() end
		end
		self.Owner:ViewPunch(Angle(-15, math.Rand(-20,-25), 0))
	elseif self.Weapon:Clip1() == 1 then
		self.Weapon:PrimaryAttack()
		self.Weapon:SetNextSecondaryFire(CurTime()+1/((self.Primary.RPM/2)/60))
	elseif self.Weapon:Clip1() == 0 then
		self:Reload()
	end	
	end
end


function SWEP:ShootBulletInformation2()

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone
	
	CurrentCone = self.Primary.Spread
	
	local damagedice = math.Rand(.85,1.3)
	
	CurrentDamage = self.Primary.Damage * damagedice
	CurrentRecoil = self.Primary.Recoil
	
		self:ShootBullet(CurrentDamage, CurrentRecoil, 31, .06)
	
end