local PANEL = {}

function PANEL:Init()
	self.Color 	= Color(31, 31, 46, 240)
	
	self.Space 	= Color(240, 240, 240)
	self.Grad	= Color(30, 30, 30)
	
	self.ItemScroll = vgui.Create("EZ_ItemScroll", self)
		self.ItemScroll:SetSize( 250, 220 )
		self.ItemScroll:SetPos( 13, 53 )
		
	self.ButtonPanel = vgui.Create("DIconLayout", self)
		self.ButtonPanel:SetSize(280, 26)
		self.ButtonPanel:SetPos(12, 280)
		self.ButtonPanel:SetSpaceX(4)
			
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

function PANEL:AddItem(pnl)
	self.ItemScroll.ItemList:Add(pnl)
end

function PANEL:AddButton(pnl)
	self.ButtonPanel:Add(pnl)
end

function PANEL:GetItemList()
	return self.ItemScroll.ItemList
end

function PANEL:OnMousePressed()

	if ( self:GetDraggable() && gui.MouseY() < (self.y + self:GetTall()) ) then
		self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
		self:MouseCapture( true )
		return
	end
	
end

PANEL.ThinkFunc = function(self, x, y)
	if IsValid(pNotif) then
		pNotif:SetPos( x, y - 38 )
	end
	
	if ( self.Dragging ) then
		pInventoryPos = { xpos = x, ypos = y }
		if !InvDropSpots then return end
		for k, v in pairs(InvDropSpots) do
			v:SetVisible(false)
		end
	end
end

PANEL.PaintFunc = function(self)
	self.Space["a"] = DoAlpha(self)
	self.Grad["a"] = math.Clamp(DoAlpha(self), 0, 10)
	draw.RoundedBox(0, 10, 50, self:GetWide() - 20, self:GetTall() - 85, self.Space)
	DrawPNG( Material("ezi/gradient.png"), 1, 1, 243, 308, self.Grad )
end

PANEL.CloseFunc = function(self)
	if pNotif and pNotif:IsValid() then
		pNotif:Remove()
		pNotif = NULL
	end
	for k,v in pairs(self:GetChildren()) do
		if !v:GetClassName() == "EZ_CloseButton" then
			v:Remove()
		end
	end
end

vgui.Register("EZ_Inventory",PANEL,"EZ_Window")