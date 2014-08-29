if CLIENT then
	surface.CreateFont( "DCFontSmall", {
		font = "Bebas Neue",
		size = 23,
		weight = 300
	})

	surface.CreateFont( "DCFontNormal", {
		font = "Bebas Neue",
		size = 33,
		weight = 300
	})

	local function DRPCMenu()
		local Main = vgui.Create( "DFrame" )
		Main:SetSize( ScrW() / 1.1, ScrH() / 1.4 )
		Main:SetTitle( "Crafting" )
		Main.Paint = function()
	surface.SetDrawColor( 0, 0, 0, 180 )
	surface.DrawRect( 0, 0, Main:GetWide(), Main:GetTall() )
	surface.SetDrawColor( 0, 0, 0, 150 )
	surface.DrawOutlinedRect( 0, 0, Main:GetWide(), Main:GetTall() )
end
		Main:SetVisible( true )
		Main:SetDraggable( true )
		Main:ShowCloseButton( true )
		Main:Center()
		Main:MakePopup()

		local w, h = Main:GetWide(), Main:GetTall()
		
		local Scroll = vgui.Create( "DScrollPanel", Main )
		Scroll:SetPos( 10, 34 )
		Scroll:SetSize( w + 5, h - 44 )

		local List = vgui.Create( "DIconLayout", Scroll )
		List:SetSize( w - 10, 60 )
		List:SetPos( 0, 0 )
		List:SetSpaceY( 2 )
		List:SetSpaceX( 1.5 )

		local text, requirements, group
		local tTmp = CRAFTING_DATABASE
		local tblPrintNames = {}
		if #tTmp == 0 then return end

		for i=1, #tTmp do
			local v = tTmp[i]

			local ListItem = List:Add( "DButton" )
			ListItem:SetSize( Scroll:GetWide() - 25, 70 )
			ListItem:SetText( "" )
			ListItem.Paint = function( self )
				draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ) )
				draw.RoundedBox( 0, 0, 60, self:GetWide(), self:GetTall() - 10, Color( 0, 0, 0, 180 ) )

				draw.RoundedBoxEx( 4, 0, 0, 70, 70, Color( 140, 140, 140, 255 ), true, false, true, false )

				draw.SimpleText( v.Name, "DCFontNormal", 75, 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )

				tblPrintNames[i] = {}

				for b=1, #v.Ingredients[1] do
					local class = v.Ingredients[1][b]
					local Name = scripted_ents.Get(class) and scripted_ents.Get(class).PrintName
					table.insert(tblPrintNames[i], Name)
				end

				local orderedtable = {}
				for k, v in pairs(tblPrintNames[i]) do
					orderedtable[v] = (orderedtable[v] or 0) + 1
				end

				local str = ""
				for k, v in pairs(orderedtable) do
					if v > 1 then
						str = str .. v .. "x " .. k .. ", "
					else
						str = str .. k .. ", "
					end
				end
				str = string.sub( str, 1, -3 )

				draw.SimpleText( "Ingredients: " .. str, "DCFontSmall", 75, 40, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )

				if v.HeatSource and v.WaterSource then
					requirements = "Heat- and Water Source"
				elseif v.HeatSource then
					requirements = "Heat Source"
				elseif v.WaterSource then
					requirements = "Water Source"
				else
					requirements = "None"
				end
				draw.SimpleText( "Requirements: " .. requirements, "DCFontSmall", self:GetWide() - 15, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )

				if v.RestrictToGroup then
					local IsRestricted = true
					for _, g in pairs(v.RestrictToGroup) do
						if LocalPlayer():IsUserGroup( g ) then
							IsRestricted = false
							break
						end
					end
					if IsRestricted then
						draw.SimpleText( "Restricted to: " .. string.Implode( ", ", v.RestrictToGroup ), "DCFontSmall", self:GetWide() - 15, 25, Color( 255, 0, 0, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )
					end
				end
			end
			ListItem.DoClick = function( self )
				RunConsoleCommand( "drp_craft", v.ID )
			end

			model = vgui.Create( "ModelImage", ListItem )
			model:SetSize( 70, 70 )
			model:SetPos( 0, 0 )
			model.Paint = function()
	surface.SetDrawColor( 255, 255, 255, 150 )
	surface.DrawRect( 0, 0, model:GetWide(), model:GetTall() )
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( 0, 0, model:GetWide(), model:GetTall() )
end
			model:SetModel( v.WorldModel, 0, "000000000" )
		end
	end
	usermessage.Hook( "umCrafting", DRPCMenu )
else
	local function umHook( ply )
		umsg.Start( "umCrafting", ply )
		umsg.End()
	end
	hook.Add( "ShowTeam", "CraftingMenu", umHook )
end