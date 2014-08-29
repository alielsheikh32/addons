ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName		= "Fire Entity"
ENT.Author			= "Orange Cosmos RP Team (Jake, Noob, Crap-Head)"
ENT.Contact			= "N/A"

PMETA = FindMetaTable( "Player" )

function PMETA:CanSee( Entity, Strict )
	if Strict then
		if !self:HasLOS(Entity) then return false; end
	end

	local fov = self:GetFOV()
	local Disp = Entity:GetPos() - self:GetPos()
	local Dist = Disp:Length()
	local EntWidth = Entity:BoundingRadius() * 0.5;
	
	local MaxCos = math.abs( math.cos( math.acos( Dist / math.sqrt( Dist * Dist + EntWidth * EntWidth ) ) + fov * ( math.pi / 180 ) ) )
	Disp:Normalize()

	if Disp:Dot( self:EyeAngles():Forward() ) > MaxCos and Entity:GetPos():Distance(self:GetPos()) < 5000 then
		return true
	end
	
	return false
end