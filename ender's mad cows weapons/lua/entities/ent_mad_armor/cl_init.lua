include("shared.lua")

language.Add("ent_mad_armor", "Armor Kit")

/*---------------------------------------------------------
   Name: ENT:Draw()
---------------------------------------------------------*/
function ENT:Draw()

	self.Entity:DrawModel() 
end