ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Uncooked Meth"
ENT.Author = "Fat Jesus / Fat Blaze"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "MethTimer" );
end