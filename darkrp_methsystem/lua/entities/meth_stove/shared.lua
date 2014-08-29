ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Stove"
ENT.Author = "Fat Jesus / Fat Blaze"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Entity",1,"owning_ent")
end