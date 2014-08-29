local PANEL = {}

function PANEL:Init()
	self.btnClose:SetVisible( false );
	self.btnMaxim:SetVisible( false );
	self.btnMinim:SetVisible( false );
	self.lblTitle:SetVisible( false );
	
	self.Color = Color(240,240,240,240);
	self.BorderCol = Color(30,30,30);

	self.Title = "Window";
	self.TitleCol = Color(240,240,240);
	
	self.CloseFunc = nil;
	self.PaintFunc = nil;
	self.ThinkFunc = nil;
	
	self.Time = CurTime()
	self.AnimTime = 0.2
	self.Anim = "Open"
		
	self.CloseButton = vgui.Create("EZ_CloseButton", self)
end

function PANEL:PerformLayout()
	self.CloseButton:SetPos(self:GetWide() - 38, 6)
end

function PANEL:Think()

	local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
		
	if ( self.Dragging ) then
		
		local x = mousex - self.Dragging[1]
		local y = mousey - self.Dragging[2]

		if ( self:GetScreenLock() ) then
		
			x = math.Clamp( x, 0, ScrW() - self:GetWide() )
			y = math.Clamp( y, 0, ScrH() - self:GetTall() )
		
		end
		
		self:SetPos( x, y )
		if self.ThinkFunc then
			self.ThinkFunc(self, x, y)
		end
	
	end
		
	if ( self.y < 0 ) then
		self:SetPos( self.x, 0 )
	end
	
end

function PANEL:OnMousePressed()

	if ( self.m_bSizable ) then
	
		if ( gui.MouseX() > (self.x + self:GetWide() - 20) &&
			gui.MouseY() > (self.y + self:GetTall() - 20) ) then			
	
			self.Sizing = { gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall() }
			self:MouseCapture( true )
			return
		end
		
	end
	
	if ( self:GetDraggable() && gui.MouseY() < (self.y + self:GetTall()) ) then
		self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
		self:MouseCapture( true )
		return
	end
	
end

function PANEL:SetColor(col)
	self.Color = col;
end

function PANEL:SetBorderCol(col)
	self.BorderCol = col;
end

function PANEL:SetTitle(ttl)
	self.Title = ttl;
end

local function DoAlpha(self)
	local alpha
	if not self.Time then return 255 end
	local Step = CurTime() - self.Time
	if self.Anim == "Open" or self.Anim == "Close" then
		local D = math.min(Step,self.AnimTime)*4
		local frac = 255 / (self.AnimTime*4)
		alpha = frac * D
		if self.Anim == "Close" then
			alpha = 255 - alpha
		end
	end
	return alpha
end

function PANEL:Paint()
	self.Color["a"] = math.Clamp(DoAlpha(self), 0, 240)
	self.BorderCol["a"] = DoAlpha(self)
	self.TitleCol["a"] = DoAlpha(self)
	draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), self.Color)
	draw.SimpleText( self.Title, "Exo700_32", 10, 5, self.TitleCol, 0, 0)
	draw.RoundedBox(0, 0, 1, 1, self:GetTall() - 2, self.BorderCol )
	draw.RoundedBox(0, 1, 0, self:GetWide() - 2, 1, self.BorderCol )
	draw.RoundedBox(0, 1, self:GetTall() - 1, self:GetWide() - 2, 1, self.BorderCol )
	draw.RoundedBox(0, self:GetWide() - 1, 1, 1, self:GetTall() - 2, self.BorderCol )
	if self.PaintFunc then
		self.PaintFunc(self)
	end
end

function PANEL:Close()
	if self.CloseFunc then
		self.CloseFunc(self)
	end
	gui.EnableScreenClicker(false)
	self.Time = CurTime()
	self.Anim = "Close"
	self.AnimTime = 0.2
	self.CloseButton:Close()
	timer.Simple( self.AnimTime, function()
		self:Remove()
	end)
end

vgui.Register("EZ_Window",PANEL,"DFrame")