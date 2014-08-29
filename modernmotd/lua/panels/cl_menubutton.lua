/*---------------------------------------------------------
  START MenuButtonPanel
---------------------------------------------------------*/
local MenuButtonPanel = {}

function MenuButtonPanel:Init()
	self:SetDrawBackground(false)
	self:SetDrawBorder(false)
	//self:SetStretchToFit(false)
	self:SetSize(450, 50)
	self.CurrentWidth = 300
	self.ColorBarWidth = 38
	self.ImageW = 32
	self.ImageH = 32
	self.BackColor = Color( 38, 41, 49, 100 )
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
	self.SubLbl:SetVisible(false)
	
	self.BtnImage = vgui.Create("DImage", self)
	self.BtnImage:SetImage("modernmotd/ico-monitor.png")
	self.BtnImage:SetVisible(true)
	
	//self.BorderColor = Color(190,40,0,255)
end

function MenuButtonPanel:SetNoActionEnbaled()
	self.NoAction = true
	self.HoverColor = Color(0, 0, 0, 155 )
	self.HeaderLbl:SetColor(Color(153, 153, 153, 90 ))
end

function MenuButtonPanel:SetColor(color)
	if not type(color) == "color" then return end
	self.NoAction = true
	self.HoverColor = color
	self.HoverTextColor = color
end

function MenuButtonPanel:SetText(text)
	self.HeaderLbl:SetText(text)
	self.HeaderLbl:SizeToContents()
end

function MenuButtonPanel:SetSubText(text)
	self.SubLbl:SetText(text)
	self.SubLbl:SizeToContents()
	self.SubLbl:SetVisible(true)
end

function MenuButtonPanel:PerformLayout()
	-- self.m_Image:SetSize(32,32)
	-- self.m_Image:SetPos(4,4)
	
	self.HeaderLbl:SetPos(45, 12)
	self.SubLbl:SetPos(45, 28)
	
	self.BtnImage:SetSize(self.ImageW, self.ImageH)
	//self.BtnImage:SizeToContents()
	self.BtnImage:SetPos(4,10)
	
	self.CurrentWidth = math.Approach( self.CurrentWidth, 450, FrameTime() * 400 )

	self:SetWide( self.CurrentWidth )
 end
 
function MenuButtonPanel:SetImage(image, w, h)
	self.IsBtnImage = true
	self.BtnImage:SetVisible(true)
	if w and h then
		self.ImageW = w
		self.ImageH = h
	end
	if image then self.BtnImage:SetImage(image) end
end

function MenuButtonPanel:Paint()
	surface.SetDrawColor(self.BackColor)
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall())
	if not self.Hovering and not self.CurrentSelection then surface.SetDrawColor(self.BackColor)
	else surface.SetDrawColor(self.HoverColor) end
	
	self.ColorBarWidth = math.Approach( self.ColorBarWidth, 450, FrameTime() * 800 )
	surface.DrawRect( 0, 0, self.ColorBarWidth, self:GetTall())
end

function MenuButtonPanel:OnCursorEntered()
	self.Hovering = true
	self.ColorBarWidth = 38
	if not self.NoAction and not self.CurrentSelection then
	self.HeaderLbl:SetColor(self.HoverTextColor)
	end
end

function MenuButtonPanel:OnCursorExited()
	self.Hovering = false
	if not self.NoAction and not self.CurrentSelection then
	self.HeaderLbl:SetColor(self.TextColor)
	end
end

function MenuButtonPanel:ToggleSelect(select)
	if select then
		//self.HeaderLbl:SetColor(self.HoverTextColor)
		self.CurrentSelection = true
	else
		self.CurrentSelection = false
		//self.HeaderLbl:SetColor(self.TextColor)
	end
end

derma.DefineControl("ModernButton", "Modern MOTD Tab Button", MenuButtonPanel, "DImageButton")

/*---------------------------------------------------------
  End MenuButtonPanel
---------------------------------------------------------*/