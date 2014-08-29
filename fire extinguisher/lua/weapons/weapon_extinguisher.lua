
AddCSLuaFile()
AddCSLuaFile( "effects/rb655_extinguisher_effect.lua" )

if ( SERVER ) then resource.AddWorkshop( "104607228" ) end

SWEP.PrintName = "Extinguisher"
SWEP.Author = "Robotboy655"
SWEP.Contact = "robotboy655@gmail.com"
SWEP.Purpose = "To extinguish fire!"
SWEP.Category = "Robotboy655's Weapons"
SWEP.Instructions = "Shoot into a fire, to extinguish it."

SWEP.Slot = 5
//SWEP.SlotPos = 3 -- If we do not specify, it will add to the bottom, yay!
SWEP.Weight = 1

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.DrawWeaponInfoBox = false
SWEP.Spawnable = false
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_fire_extinguisher.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_fire_extinguisher.mdl"
SWEP.HoldType = "slam"

game.AddAmmoType( { name = "rb655_extinguisher" } )
if ( CLIENT ) then language.Add( "rb655_extinguisher_ammo", "Extinguisher Ammo" ) end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 500
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "rb655_extinguisher"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	
	self:Idle()

	return true
end

function SWEP:DoEffect( effectscale )
	effectscale = effectscale or 1

	local effectdata = EffectData()
	effectdata:SetAttachment( 1 )
	effectdata:SetEntity( self.Owner )
	effectdata:SetOrigin( self.Owner:GetShootPos() )
	effectdata:SetNormal( self.Owner:GetAimVector() )
	if ( effectscale > 1 ) then
		for i = 1, effectscale do util.Effect( "rb655_extinguisher_effect", effectdata ) end
	else
		util.Effect( "rb655_extinguisher_effect", effectdata )
	end
end

function SWEP:DoExtinguish( pushforce, effectscale )
	if ( self:Ammo1() < 1 ) then return end

	if ( CLIENT ) then 
		if ( self.Owner == LocalPlayer() ) then self:DoEffect( effectscale ) end -- FIXME
		return
	end

	self:TakePrimaryAmmo( 1 )
	
	effectscale = effectscale or 1
	pushforce = pushforce or 0

	local tr
	if ( self.Owner:IsNPC() ) then
		tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 16384,
			filter = self.Owner
		} )
	else
		tr = self.Owner:GetEyeTrace()
	end
	
	local pos = tr.HitPos

	for id, prop in pairs( ents.FindInSphere( pos, 80 ) ) do
		if ( prop:GetPos():Distance( self:GetPos() ) < 256 ) then
			if ( prop:IsValid() and math.random( 0, 1000 ) > 500 ) then
				if ( prop:IsOnFire() ) then prop:Extinguish() end

				local class = prop:GetClass()
				if ( string.find( class, "ent_minecraft_torch" ) and prop:GetWorking() ) then
					prop:SetWorking( false )
				elseif ( string.find( class, "env_fire" ) ) then -- Gas Can support. Should work in ravenholm too.
					prop:Fire( "Extinguish" )
				end
			end
			
			if ( pushforce > 0 ) then
				local physobj = prop:GetPhysicsObject()
				if ( IsValid( physobj ) ) then
					physobj:ApplyForceOffset( self.Owner:GetAimVector() * pushforce, pos )
				end
			end
		end
	end

	self:DoEffect( effectscale )
end

function SWEP:PrimaryAttack()
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end

	if ( IsFirstTimePredicted() ) then

		self:DoExtinguish( 196, 1 )

		if ( SERVER ) then

			if ( self.Owner:KeyPressed( IN_ATTACK ) || !self.Sound  ) then 
				self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

				self.Sound = CreateSound( self.Owner, Sound( "weapons/extinguisher/fire1.wav" ) )
				
				self:Idle()
			end

			if ( self:Ammo1() > 0 ) then if ( self.Sound ) then self.Sound:Play() end end

		end
	end
	
	self:SetNextPrimaryFire( CurTime() + 0.05 )
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:PlaySound()
	self:EmitSound( "weapons/extinguisher/release1.wav", 100, math.random( 95, 110 ) )
end

function SWEP:Think()
	if ( self:GetNextSecondaryFire() > CurTime() || CLIENT ) then return end
	
	if ( ( self.NextAmmoReplenish or 0 ) < CurTime() ) then
		local ammoAdd = 0
		if ( self.Owner:WaterLevel() > 1 ) then ammoAdd = 25 end
	
		self.Owner:SetAmmo( math.min( self:Ammo1() + ammoAdd, self.Primary.DefaultClip * 2 ), self:GetPrimaryAmmoType() )
		self.NextAmmoReplenish = CurTime() + 0.1
	end

	if ( self.Sound && self.Sound:IsPlaying() && self:Ammo1() < 1 ) then
		self.Sound:Stop()
		self:PlaySound()
		self:DoIdle()
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) || ( !self.Owner:KeyDown( IN_ATTACK ) && self.Sound ) ) then
	
		self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

		if ( self.Sound ) then
			self.Sound:Stop()
			self.Sound = nil
			if ( self:Ammo1() > 0 ) then
				self:PlaySound()
				if ( !game.SinglePlayer() ) then self:CallOnClient( "PlaySound", "" ) end
			end
		end

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() )
		
		self:Idle()

	end
end

function SWEP:Holster( weapon )
	if ( CLIENT ) then return end

	if ( self.Sound ) then
		self.Sound:Stop()
		self.Sound = nil
	end
	
	self:StopIdle()
	
	return true
end

function SWEP:DoIdleAnimation()
	if ( self.Owner:KeyDown( IN_ATTACK ) and self:Ammo1() > 0 ) then self:SendWeaponAnim( ACT_VM_IDLE_1 ) return end
	if ( self.Owner:KeyDown( IN_ATTACK ) and self:Ammo1() < 1 ) then self:SendWeaponAnim( ACT_VM_IDLE_EMPTY ) return end
	self:SendWeaponAnim( ACT_VM_IDLE )
end

function SWEP:DoIdle()
	self:DoIdleAnimation()

	timer.Adjust( "rb655_idle" .. self:EntIndex(), self:SequenceDuration(), 0, function()
		if ( !IsValid( self ) ) then timer.Destroy( "rb655_idle" .. self:EntIndex() ) return end

		self:DoIdleAnimation()
	end )
end

function SWEP:StopIdle()
	timer.Destroy( "rb655_idle" .. self:EntIndex() )
end

function SWEP:Idle()
	if ( CLIENT || !IsValid( self.Owner ) ) then return end
	timer.Create( "rb655_idle" .. self:EntIndex(), self:SequenceDuration() - 0.2, 1, function()
		if ( !IsValid( self ) ) then return end
		self:DoIdle()
	end )
end

if ( SERVER ) then return end

SWEP.WepSelectIcon = Material( "rb655_extinguisher_icon.png" )

function SWEP:DrawWeaponSelection( x, y, w, h, a )
	surface.SetDrawColor( 255, 255, 255, a )
	surface.SetMaterial( self.WepSelectIcon )
	
	local size = math.min( w, h ) - 32
	surface.DrawTexturedRect( x + w / 2 - size / 2, y + h * 0.05, size, size )
end
