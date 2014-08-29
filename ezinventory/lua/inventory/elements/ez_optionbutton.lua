local PANEL = {}

function PANEL:Init()
	self:SetText("");
	self:SetSize(24, 24)

	self.Color 			= Color( 240, 240, 240 );
	self.HoverCol 		= Color( 210, 210, 210 );
	self.Col 			= self.Color;
	self.Image 			= nil;
	self.ImageCol 		= Color(255,255,255);
	
end

local function DrawPNG(pngtex, x, y, w, h, color)
	surface.SetMaterial( pngtex )
	surface.SetDrawColor(color)
	surface.DrawTexturedRect( x, y, w, h )
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

function PANEL:SetColor(col, hvr)
	self.Color 		= col;
	self.HoverCol 	= hvr;
end

function PANEL:SetImage(png)
	self.Image = Material(png);
end

function PANEL:Paint()
	self.Color["a"] = DoAlpha(pInventory)
	self.ImageCol["a"] = DoAlpha(pInventory)
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), self.Col )
	if self.Image then
		DrawPNG( self.Image, 4, 4, 16, 16, self.ImageCol )
	end
end

function PANEL:OnCursorEntered()
	self.Col = self.HoverCol;
end

function PANEL:OnCursorExited()
	self.Col = self.Color;
end

vgui.Register("EZ_OptionButton",PANEL,"DButton")