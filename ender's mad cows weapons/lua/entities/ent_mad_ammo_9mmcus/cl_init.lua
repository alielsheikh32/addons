include('shared.lua')

language.Add("ent_mad_ammo_9mmcus", "Box of Ammo")
language.Add( "ammo_9mmcusammo#", "9mmcustomtest" )
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
	
	self.Entity:DrawModel()
end