EZI.ScrollPos = 0

local PANEL = {}

function PANEL:Init()
	self.VBar:SetVisible(false)
	self.VBar.btnDown:SetVisible(false)
	self.VBar.btnUp:SetVisible(false)
	
	self.ItemList = vgui.Create("DIconLayout", self)
		self.ItemList:SetSize( 224, 225 )
		self.ItemList:SetSpaceX(4)
		self.ItemList:SetSpaceY(4)
				
end

function PANEL:Rebuild()

	self:GetCanvas():SizeToChildren( false, true )
		
	if ( self.m_bNoSizing && self:GetCanvas():GetTall() < self:GetTall() ) then
		self:GetCanvas():SetPos( 0, (self:GetTall()-self:GetCanvas():GetTall()) * 0.5 )
	end
	
	self.pnlCanvas:SetPos( 0, EZI.ScrollPos )

end

function PANEL:Paint()

end

function PANEL:OnVScroll(iOffset)
	EZI.ScrollPos = iOffset;
	self.pnlCanvas:SetPos( 0, iOffset )
	if IsValid(pNotif) and pNotif:IsValid() then
		local posx, posy = pNotif:GetPos()
		pNotif:MoveTo(posx, posy + 80, 0.8, 0, 1, function()
		pNotif:SetVisible(false)
		end)
	end
end


vgui.Register("EZ_ItemScroll",PANEL,"DScrollPanel")