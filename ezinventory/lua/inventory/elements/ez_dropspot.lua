local PANEL = {}

function PANEL:Init()
	self:SetSize(71, 68);
	
	self.Color 		= Color( 50, 50, 50, 250 );
	self.Outline 	= Color( 37, 37, 37 );
	self.TextCol	= Color(240, 240, 240);
	
	self.Text 		= "Drop Spot";
	self.Image 		= nil;
end

local function DrawPNG(pngtex, x, y, w, h)
	surface.SetMaterial( pngtex )
	surface.SetDrawColor(Color(255,255,255))
	surface.DrawTexturedRect( x, y, w, h )
end

function PANEL:SetImage(png)
	self.Image = png;
end

function PANEL:SetText(text, col)
	self.Text = text;
	if col then self.TextCol = col; end
end

function PANEL:Paint()
	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), self.Outline, false, false, true, true )
	draw.RoundedBoxEx( 8, 1, 1, self:GetWide() - 2, self:GetTall() - 2, self.Color, false, false, true, true )
	if self.Image then
		DrawPNG(Material( self.Image ), self:GetWide() / 2 - 16, 10, 32, 32)
	end
	surface.SetFont("Exo500_18")
	local txtsze = surface.GetTextSize(self.Text)
	draw.DrawText( self.Text, "Exo700_18", (self:GetWide() / 2) - (txtsze / 2), 46, self.TextCol, 0 )
end

vgui.Register("EZ_DropSpot",PANEL,"DPanel")