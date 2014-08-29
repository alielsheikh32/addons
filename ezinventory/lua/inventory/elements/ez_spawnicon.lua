local PANEL = {}

function PANEL:Init()
	
end

function PANEL:OnMouseReleased( mousecode )

return DLabel.OnMouseReleased( self, mousecode )

end

function PANEL:OnMousePressed( mousecode )

	self:GetParent():OnMousePressed( mousecode )
	return DLabel.OnMousePressed( self, mousecode )

end

vgui.Register("EZ_SpawnIcon",PANEL,"SpawnIcon")