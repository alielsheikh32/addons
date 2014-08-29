local PANEL = {}

function PANEL:Init()
	
	self:SetSize(70, 70);
	self:SetText("");
	
	self.Color = Color(50,50,50);
	
	self.item = nil;
	
	self.icon = vgui.Create("EZ_SpawnIcon", self);
	self.icon:SetPos( 3, 3)
	self.icon:SetSize(64, 64)
	self.icon:SetTooltip("")
	self.icon:SetDragParent(self)
	self.icon.PaintOver = function() return end
	
end

function PANEL:SetModel(mdl)
	self.icon:SetModel(mdl)
end

function PANEL:SetItem(itm)
	self.item = itm;
	self.icon:SetModel(self.item.model);
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
	self.Color["a"] = DoAlpha(pInventory)
	draw.RoundedBox( 0, 0, 0, self:GetWide() , self:GetTall(), self.Color )
end

function PANEL:PaintOver()
	if !self.item then return end
	local w, h = self:GetSize()
	local item = self.item
	local alpha = EZI.DoAlpha(pInventory)
	
	draw.SimpleTextOutlined(item.name, "ItemLabel", w * 0.5, 5, Color(255,255,255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color(0,0,0,alpha))
			
	if item.class and item.class == "spawned_shipment" then
		draw.SimpleTextOutlined("x" .. item.count, "ItemLabel", w - 5, h - 5, Color(255,255,255, alpha), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 0, Color(0,0,0,alpha))
		draw.SimpleTextOutlined("Shipment", "ItemLabel", w * 0.5, 24, Color(240,240,240,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color(0,0,0, alpha))
	elseif (item.count) and (item.count > 1) then
		draw.SimpleTextOutlined("x" .. item.count, "ItemLabel", w - 5, h - 5, Color(255,255,255, alpha), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 0, Color(0,0,0,alpha))
	end
end

function PANEL:Remove()
	print("Item Panel Removed")
end

vgui.Register("EZ_ItemSlot",PANEL,"DButton")