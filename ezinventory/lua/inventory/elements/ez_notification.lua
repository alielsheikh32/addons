local PANEL = {}

function PANEL:Init()
	self:SetSize(245, 32)
	
	self.Color 		= Color(50, 50, 50)
	self.TextColor 	= Color(240, 240, 240)
	self.iColor		= Color(50, 50, 50)
	
	self.Text = "Notification";
	
	self.Parent = nil;
	
end

function PANEL:NotifParent(pnl)
	self.Parent = pnl;
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

function PANEL:SetText(txt)
	self.Text = txt;
end

function PANEL:Paint()
	self.Color["a"] = math.Clamp(DoAlpha(pInventory), 0, 240)
	self.TextColor["a"] = DoAlpha(pInventory)
	self.iColor["a"] = DoAlpha(pInventory)
	
	draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), self.Color)
	draw.RoundedBoxEx( 8, 2, 2, 28, 28, self.TextColor, true, false, true, false )
	draw.SimpleText( "i", "Exo700_20", 14, 6, self.iColor, 0, 0 )
	draw.SimpleText( self.Text, "Exo500_20", 40, 6, self.TextColor, 0, 0 )
end

hook.Add("Tick", "OpenInventory", function()
	local ply = LocalPlayer()
	
	if (!IsValid(ply)) then return end
	//if !IsValid(PANEL)
	
end)
				
vgui.Register("EZ_Notification",PANEL,"DPanel")