include("shared.lua")

function ENT:Initialize()
	self.Vars = {}
	self.Vars.StoredMoney = 0
	self.Vars.Heat = 0
	self.Vars.Speed = 0.25
	self.Vars.Multiplier = 1
	self.Vars.Armor = 0
	self.Vars.Level = 1
	self.Vars.Exp = 0
	self.Vars.isBurning = false
	self.Vars.isEnabled = true
	self.Vars.Upgrades = {}
	self.Vars.Upgrades.Speed = 0
	self.Vars.Upgrades.Exp = 0
	self.Vars.Upgrades.PrintMul = 0
end

local origin = {}
origin.x = -151
origin.y = -163

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Dist = Pos:Distance(LocalPlayer():GetPos())
	local Ang = self:GetAngles()

	if Dist > 200 then return end

	Ang:RotateAroundAxis( Ang:Up(), 90)
	
	cam.Start3D2D(Pos + Ang:Up() * 10.6, Ang, 0.1)
		--Background
		surface.SetDrawColor( 35, 35, 35, 255 )
		surface.DrawRect( origin.x, origin.y, 306, 308 )
		surface.SetDrawColor( CFG.LvlTbl[self.Vars.Level].Clr )
		surface.DrawOutlinedRect( origin.x + 10, origin.y + 10, 286, 288 )
		--Basic info
		surface.SetDrawColor( CFG.LvlTbl[self.Vars.Level].Clr)
		surface.DrawRect( origin.x + 10, origin.y + 10, 286, 20 )
		draw.SimpleTextOutlined( "Basic Info", "DermaDefaultBold", origin.x + 153, origin.y + 20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		--Level
		draw.SimpleTextOutlined( "Level: " .. self.Vars.Level .. " (" .. CFG.LvlTbl[self.Vars.Level].PrinterName .. " Printer)" , "DermaDefaultBold", origin.x + 15, origin.y + 40, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		--Mul
		if self.Vars.Upgrades.PrintMul > 0 then
			draw.SimpleTextOutlined( "Print Multiplier: " .. self.Vars.Multiplier + CFG.Upgrades.PrintMul[self.Vars.Upgrades.PrintMul].Mod, "DermaDefaultBold", origin.x + 15, origin.y + 55, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		else
			draw.SimpleTextOutlined( "Print Multiplier: " .. self.Vars.Multiplier, "DermaDefaultBold", origin.x + 15, origin.y + 55, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		end
		--Speed
		if self.Vars.Upgrades.Speed > 0 then
			draw.SimpleTextOutlined( "Print Delay: " .. self.Vars.Speed - CFG.Upgrades.Speed[self.Vars.Upgrades.Speed].Mod , "DermaDefaultBold", origin.x + 15, origin.y + 70, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		else
			draw.SimpleTextOutlined( "Print Delay: " .. self.Vars.Speed, "DermaDefaultBold", origin.x + 15, origin.y + 70, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		end
		--Printer stats
		surface.SetDrawColor( CFG.LvlTbl[self.Vars.Level].Clr)
		surface.DrawRect( origin.x + 10, origin.y + 80, 286, 20 )
		draw.SimpleTextOutlined( "Printer stats", "DermaDefaultBold", origin.x + 153, origin.y + 90, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		--Exp with bar
		surface.SetDrawColor( CFG.LvlTbl[self.Vars.Level].Clr )
		surface.DrawOutlinedRect( origin.x + 20, origin.y + 120, 266, 10 )
		if CFG.LvlTbl[self.Vars.Level + 1] then
			draw.SimpleTextOutlined( "Experience: " .. self.Vars.Exp .. "/" .. CFG.LvlTbl[self.Vars.Level + 1].ExpReq, "DermaDefaultBold", origin.x + 15, origin.y + 110, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
			surface.DrawRect( origin.x + 20, origin.y + 120, (self.Vars.Exp / CFG.LvlTbl[self.Vars.Level + 1].ExpReq) * 266 , 10 )
		else
			draw.SimpleTextOutlined( "Experience: MAX", "DermaDefaultBold", origin.x + 15, origin.y + 110, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		end
		--Heat with bar
		draw.SimpleTextOutlined( "Heat: " .. self.Vars.Heat .. "/" .. CFG.MaxHeat, "DermaDefaultBold", origin.x + 15, origin.y + 140, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		surface.SetDrawColor( CFG.LvlTbl[self.Vars.Level].Clr )
		surface.DrawOutlinedRect( origin.x + 20, origin.y + 150, 266, 10 )
		surface.DrawRect( origin.x + 20, origin.y + 150, (self.Vars.Heat / CFG.MaxHeat) * 266 , 10 )
		--Stored cash with bar
		draw.SimpleTextOutlined( "Stored Money: " .. self.Vars.StoredMoney .. "/" .. CFG.MaxStorage, "DermaDefaultBold", origin.x + 15, origin.y + 170, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		surface.SetDrawColor( CFG.LvlTbl[self.Vars.Level].Clr )
		surface.DrawOutlinedRect( origin.x + 20, origin.y + 180, 266, 10 )
		surface.DrawRect( origin.x + 20, origin.y + 180, (self.Vars.StoredMoney / CFG.MaxStorage) * 266 , 10 )
		--Printer Info
		surface.SetDrawColor( CFG.LvlTbl[self.Vars.Level].Clr)
		surface.DrawRect( origin.x + 10, origin.y + 200, 286, 20 )
		draw.SimpleTextOutlined( "Printer Info", "DermaDefaultBold", origin.x + 153, origin.y + 210, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		--Other
		draw.SimpleTextOutlined( "Owned By " .. self.dt.owning_ent:Nick() .. " (" .. team.GetName( self.dt.owning_ent:Team() ) .. ")", "DermaDefaultBold", origin.x + 15, origin.y + 230, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		if CFG.LvlTbl[self.Vars.Level].RankRestriction then
			draw.SimpleTextOutlined( "Restriction: " .. string.Implode( ", ", CFG.LvlTbl[self.Vars.Level].RankRestriction ), "DermaDefaultBold", origin.x + 15, origin.y + 245, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		else
			draw.SimpleTextOutlined( "Restriction: None", "DermaDefaultBold", origin.x + 15, origin.y + 245, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
		end
		draw.SimpleTextOutlined( "Enabled: " .. tostring( self.Vars.isEnabled ), "DermaDefaultBold", origin.x + 15, origin.y + 260, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
	cam.End3D2D()
end

net.Receive( 'NGX_PrinterUpdate', function()
	local Printer = net.ReadEntity()
	Printer.Vars = net.ReadTable()
end )

local Menu = nil
net.Receive( 'NGX_OpenMenu', function()
	local Printer = net.ReadEntity()
	Printer.Vars = net.ReadTable()

	Menu = vgui.Create( 'DFrame' )
	Menu:SetSize( 150, 150 )
	Menu:Center()
	Menu:MakePopup()
	Menu.btnMaxim:Hide()
	Menu.btnMinim:Hide()
	Menu:SetTitle( 'Printer Menu' )
	Menu.Paint = function( self )
		draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), CFG.LvlTbl[Printer.Vars.Level].Clr )
		draw.RoundedBox( 4, 1, 1, self:GetWide()-2, self:GetTall()-2, Color( 30, 30, 30, 255 ) )
	end
	Menu.lblTitle:SetFont("DermaDefaultBold")

	local LeftPanel = vgui.Create( 'DPanel', Menu )
	LeftPanel:SetSize( 142.5, 120 )
	LeftPanel:SetPos( 5, 25 )
	LeftPanel:SetBackgroundColor( Color( 50, 50, 50, 255 ) )

	local TakeCash = vgui.Create('DButton', LeftPanel)
	TakeCash:SetSize( 65, 20 )
	TakeCash:SetPos( 5, 100 )
	TakeCash:SetText( "Take Cash")
	TakeCash.DoClick = function( self )
		net.Start('NGX_TakeCash')
			net.WriteEntity( Printer )
			net.WriteEntity( LocalPlayer() )
		net.SendToServer()

		Menu:Remove()
	end

	local PowerButton = vgui.Create('DButton', LeftPanel)
	PowerButton:SetSize( 65, 20 )
	PowerButton:SetPos( 70, 100 )
	PowerButton:SetText( "ON/OFF" )
	PowerButton.DoClick = function( self )
		net.Start('NGX_TurnOnOff')
			net.WriteEntity( Printer )
			net.WriteEntity( LocalPlayer() )
		net.SendToServer()

		Menu:Remove()
	end

	local i = 0
	for upgrade, upgradeTbl in pairs ( CFG.Upgrades ) do
		local UpgradeLbl = vgui.Create( 'DLabel', LeftPanel )
		UpgradeLbl:SetText( upgrade .. " (" .. Printer.Vars.Upgrades[upgrade] .. "/" .. #upgradeTbl .. ")" )
		UpgradeLbl:SetPos( 5, ( i * 35 ) )
		UpgradeLbl:SizeToContentsX()

		local UpgradeProg = vgui.Create( "DProgress", LeftPanel )
		UpgradeProg:SetPos( 5, (i * 35) + 20 )
		UpgradeProg:SetSize( 130, 10 )
		UpgradeProg:SetFraction( 0.25 * Printer.Vars.Upgrades[upgrade] )

		local UpgradeBuy = 	vgui.Create('DButton', LeftPanel)
		UpgradeBuy:SetImage('icon16/money.png')
		UpgradeBuy:SetSize( 20, 20 )
		UpgradeBuy:SetPos( 116, (i * 35 ) )
		UpgradeBuy:SetText('')
		UpgradeBuy.DoClick = function( self )
		net.Start('NGX_Upgrade')
			net.WriteEntity( Printer )
			net.WriteEntity( LocalPlayer() )
			net.WriteString( upgrade )
		net.SendToServer()

		Menu:Remove()
	end
		i = i + 1
	end
end )