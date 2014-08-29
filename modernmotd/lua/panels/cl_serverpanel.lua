local GTBaseURL="http://www.gametracker.com/server_info/%s/b_350_20_4B4ACB_4846E4_FFFFFF_000000.png"
/*---------------------------------------------------------
  START ServerButtonPanel
---------------------------------------------------------*/
local ServerButtonPanel = {}

function ServerButtonPanel:Init()
	self:SetDrawBackground(false)
	self:SetDrawBorder(false)
	self.WSize = ScrW() / 3 + 90
	//self:SetStretchToFit(false)
	self:SetSize(self.WSize, 82)
	self.BackColor = Color( 38, 41, 49, 255 )
	self.TextColor = Color(255, 255, 255, 250 )
	self.HoverColor = Color(23, 55, 94, 250 )
	self.HoverTextColor = Color(142, 180, 227, 250)
	self.Hovering = false
	
	self.HeaderLbl = vgui.Create("DLabel", self)
	self.HeaderLbl:SetFont("Bebas24Font")
	self.HeaderLbl:SetColor(self.TextColor)
	
	self.SubLbl = vgui.Create("DLabel", self)
	self.SubLbl:SetFont("OpenSans14Font")
	self.SubLbl:SetColor(self.TextColor)
	
	self.JoinLbl = vgui.Create("DLabel", self)
	self.JoinLbl:SetFont("Bebas18Font")
	self.JoinLbl:SetColor(self.TextColor)
	self.JoinLbl:SetText("JOIN SERVER")
	self.JoinLbl:SizeToContents()
	
	self.HTMLImage = vgui.Create( "DHTML", self );
	self.HTMLImage:SetSize( 350, 20 )
	self.HTMLImage:SetVisible(false)
	
	//self.BorderColor = Color(190,40,0,255)
end

function ServerButtonPanel:SetNoActionEnbaled()
	self.NoAction = true
	self.HoverColor = Color(0, 0, 0, 155 )
	self.HeaderLbl:SetColor(Color(153, 153, 153, 90 ))
end

function ServerButtonPanel:SetColor(color)
	if not type(color) == "color" then return end
	//self.NoAction = true
	self.HoverColor = color
	self.HoverTextColor = color
end

function ServerButtonPanel:SetText(text)
	self.HeaderLbl:SetText(text)
	self.HeaderLbl:SizeToContents()
end

function ServerButtonPanel:SetSubText(text)
	self.SubLbl:SetText(text)
	self.SubLbl:SizeToContents()
end

function ServerButtonPanel:SetGametracker(serveripport)
	if not serveripport then return end
	self.HTMLImage:SetVisible(true)
	self.HTMLImage:SetScrollbars( false )
	self.HTMLImage:OpenURL(string.format(GTBaseURL, serveripport))
end

function ServerButtonPanel:PerformLayout()
	-- self.m_Image:SetSize(32,32)
	-- self.m_Image:SetPos(4,4)
	
	//self.BtnImage:SetSize(64, 67)
	//self.BtnImage:SizeToContents()
	//self.BtnImage:SetPos(4,10)
	self.HTMLImage:SetPos(45,50)
	
	self.HeaderLbl:SetPos(45, 12)
	self.SubLbl:SetPos(45, 28)
	
	self.JoinLbl:SetPos(self.WSize - 100, 12)
 end

function ServerButtonPanel:Paint()
	surface.SetDrawColor(self.BackColor)
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall())
	
	
	if not self.Hovering then surface.SetDrawColor(self.BackColor)
	else surface.SetDrawColor(self.HoverColor) end
	surface.DrawRect( self.WSize - 105, 10, 150, 25)
end

function ServerButtonPanel:OnCursorEntered()
	self.Hovering = true
	if not self.NoAction and not self.CurrentSelection then
	self.HeaderLbl:SetColor(self.HoverTextColor)
	end
end

function ServerButtonPanel:OnCursorExited()
	self.Hovering = false
	if not self.NoAction and not self.CurrentSelection then
	self.HeaderLbl:SetColor(self.TextColor)
	end
end

derma.DefineControl("ModernServerButton", "Modern MOTD Server Selection Button", ServerButtonPanel, "DImageButton")

/*---------------------------------------------------------
  End ServerButtonPanel
---------------------------------------------------------*/