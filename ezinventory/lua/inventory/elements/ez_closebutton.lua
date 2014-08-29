local PANEL = {}

function PANEL:Init()
	self:SetSize(32,32);
	self:SetText("");
	self.Color 		= Color(220,220,220);
	self.EnterCol 	= Color(240,240,240);
	self.ExitCol	= Color(220,220,220);
	
	self.Time = CurTime()
	self.AnimTime = 0.2
	self.Anim = "Open"
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

function PANEL:Close()
	self.Time = CurTime()
	self.AnimTime = 0.2
	self.Anim = "Close"
end

function PANEL:Paint()
	local xcol = Color( 20, 20, 20, 255 )
	xcol["r"] = xcol["r"] + (math.sin( CurTime() * 1.4 ) + 1) * 90
	self.Color["a"] = DoAlpha(self)
	xcol["a"] = DoAlpha(self)
	draw.RoundedBox( 0, 0, 0, self:GetWide() , self:GetTall(), self.Color )
	draw.SimpleText( "X", "Exo700_32", 8, 0, xcol, 0, 0 )
end

function PANEL:OnCursorEntered()
	self.Color = self.EnterCol
end

function PANEL:OnCursorExited()
	self.Color = self.ExitCol
end

function PANEL:DoClick()
	self:GetParent():Close();
end

vgui.Register("EZ_CloseButton",PANEL,"DButton")