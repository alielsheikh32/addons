	pAddItems = pAddItems or NULL

local function DrawPNG(pngtex, x, y, w, h, color)
	surface.SetMaterial( pngtex )
	surface.SetDrawColor(color)
	surface.DrawTexturedRect( x, y, w, h )
end

function EZI.AddShopItems()
	local main = vgui.Create("DPanel")
		pAddItems = main
		main:SetSize( 646, 480 )
		main:Center()
		main:MakePopup()
		main.Time = CurTime()
		main.AnimTime = 0.2
		main.Anim = "Open"
		main.Paint = function(self)
			local alpha = EZI.DoAlpha(self)
			draw.RoundedBox(0, 1, 1, self:GetWide() - 2, self:GetTall() - 2, Color(50, 50, 50, math.Clamp(alpha, 0, 250)))
			draw.RoundedBox(0, 0, 1, 1, self:GetTall() - 2, Color(30,30,30, alpha) )
			draw.RoundedBox(0, 1, 0, self:GetWide() - 2, 1, Color(30,30,30, alpha) )
			draw.RoundedBox(0, 1, self:GetTall() - 1, self:GetWide() - 2, 1, Color(30,30,30, alpha) )
			draw.RoundedBox(0, self:GetWide() - 1, 1, 1, self:GetTall() - 2, Color(30,30,30, alpha) )
			draw.RoundedBox(8, 10, 50, 303, 387, Color(240, 240, 240, alpha))
			draw.RoundedBox(8, 328, 50, 303, 387, Color(240, 240, 240, alpha))
			draw.SimpleText( "Add Items", "Exo700_32", 10, 5, Color( 240,240,240,alpha ), 0, 0)
		end
		
		function main:Close()
			self.Time = CurTime()
			self.Anim = "Close"
			timer.Simple( self.AnimTime , function()
				self:Remove()
			end)
		end
		
		local CloseButton = EZI.DrawXButton()
			main:Add(CloseButton)
			CloseButton:SetPos(main:GetWide() - 38, 6)
			
		local SpawnMenu = {}
		local DefinedItems = {}
			
			DefinedItems.itemscroll = vgui.Create("DScrollPanel", main)
			DefinedItems.itemscroll:SetSize( 296, 383 )
			DefinedItems.itemscroll:SetPos( 12, 53 )
			DefinedItems.itemscroll.Paint = function() end
			DefinedItems.itemscroll:SetSkin("EZI_Skin")
			DefinedItems.ScrollVBar = DefinedItems.itemscroll:GetVBar()
			DefinedItems.ScrollVBar:SetVisible(false)
			DefinedItems.ScrollVBar.btnDown:SetVisible(false)
			DefinedItems.ScrollVBar.btnUp:SetVisible(false)
			DefinedItems.ScrollVBar.Paint = function(self)
				surface.SetDrawColor( 50, 50, 50, 0 )
				draw.RoundedBox( 4, 0, 15, self:GetWide(), self:GetTall() - 30, Color(50,50,50,240) )
			end
			DefinedItems.ilist = vgui.Create("DIconLayout", DefinedItems.itemscroll)
			DefinedItems.ilist:SetSize( 296, 383 )
			DefinedItems.ilist:SetSpaceY(4)

			SpawnMenu.itemscroll = vgui.Create("DScrollPanel", main)
			SpawnMenu.itemscroll:SetSize( 296, 383 )
			SpawnMenu.itemscroll:SetPos( 330, 53 )
			SpawnMenu.itemscroll.Paint = function() end
			SpawnMenu.itemscroll:SetSkin("EZI_Skin")
			SpawnMenu.ScrollVBar = SpawnMenu.itemscroll:GetVBar()
			SpawnMenu.ScrollVBar:SetVisible(false)
			SpawnMenu.ScrollVBar.btnDown:SetVisible(false)
			SpawnMenu.ScrollVBar.btnUp:SetVisible(false)
			SpawnMenu.ScrollVBar.Paint = function(self)
				surface.SetDrawColor( 50, 50, 50, 0 )
				draw.RoundedBox( 4, 0, 15, self:GetWide(), self:GetTall() - 30, Color(50,50,50,240) )
			end
			SpawnMenu.ilist = vgui.Create("DIconLayout", SpawnMenu.itemscroll)
			SpawnMenu.ilist:SetSize( 296, 383 )
			SpawnMenu.ilist:SetSpaceY(4)			
			

						
		for k, v in pairs(EZI.Items) do
			local entry = EZI.MakeItemEntry(k, v.name, v.model, true)
				DefinedItems.ilist:Add(entry)
				entry.DoClick = function() EZI.AddItem(k, v.name, v.model, false) end
		end
		
		for k, v in pairs(EZI.EntityInfo) do
			local entry = EZI.MakeItemEntry(k, v.name, v.model, false)
				SpawnMenu.ilist:Add(entry)
				entry.DoClick = function() EZI.AddItem(k, v.name, v.model, true) end
		end
		
		local AddItem = EZI.DrawOptionButton("fatcow32/add_package.png", function() EZI.AddItem("Entity Class", "Entity Name", "Entity Model", true) end)
			main:Add(AddItem)
			AddItem:SetPos( 12, 450 )
end

function EZI.MakeItemEntry( entclass, name, model, del )

	local main = vgui.Create("DButton")
		main:SetSize(276, 60)
		main:SetText("")
		function main:DoDraw(bgcol)
			self.Paint = function(self)
			draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), bgcol )
			draw.SimpleText( name, "Exo700_24", 60, 5, Color( 240,240,240,255 ), 0, 0)
			draw.SimpleText( "'" .. entclass .. "'", "Exo700_18", 60, 35, Color( 240,240,240,255 ), 0, 0)
			end
		end
		main:DoDraw(Color( 50, 50, 50 ))
		main.OnCursorEntered = function(self) self:DoDraw(Color( 80, 80, 80 )) end
		main.OnCursorExited = function(self) self:DoDraw(Color( 50, 50, 50 )) end
		
		
	local icon = vgui.Create("SpawnIcon", main)
		icon:SetPos(5,5)
		icon:SetSize(50,50)
		icon:SetModel( model )
		icon.PaintOver = function() return end
		
	if del == true then
		local delete = EZI.DrawOptionButton("ezi/cross.png", function()
			EZI.DialogBox("Are you sure you want to delete this item?", function()
				net.Start("EZI_DelItemInfo")
					net.WriteString(entclass)
				net.SendToServer()
				EZI.OpenAddMenu()
			end)
		end)
		main:Add(delete)
		delete:SetPos(main:GetWide() - delete:GetWide() - 5, main:GetTall()/2 - delete:GetTall()/2)
	end
	
	return main
end

function EZI.AddItem(cls, nme, mdl, add)
	local main = vgui.Create("DFrame")
		main:ShowCloseButton( false )
		main:SetSize(250, 265)
		main:Center()
		main:MakePopup()
		main.lblTitle:SetVisible(false)
		main:SetDraggable(false)
		main.Time = CurTime()
		main.AnimTime = 0.2
		main.Anim = "Open"
		local ttltxt = "Add Item" 
		if add == false then ttltxt = "Edit Item" end
		main.Paint = function(self)
			local alpha = EZI.DoAlpha(self)
			draw.RoundedBox(0, 1, 1, self:GetWide() - 2, self:GetTall() - 2, Color(50, 50, 50, math.Clamp(alpha, 0, 250)))
			draw.RoundedBox(0, 0, 1, 1, self:GetTall() - 2, Color(30,30,30, alpha) )
			draw.RoundedBox(0, 1, 0, self:GetWide() - 2, 1, Color(30,30,30, alpha) )
			draw.RoundedBox(0, 1, self:GetTall() - 1, self:GetWide() - 2, 1, Color(30,30,30, alpha) )
			draw.RoundedBox(0, self:GetWide() - 1, 1, 1, self:GetTall() - 2, Color(30,30,30, alpha) )
			draw.SimpleText( ttltxt, "Exo700_32", 10, 5, Color( 240,240,240,alpha ), 0, 0)
			draw.RoundedBox(8, (self:GetWide()/2)-70/2, 57, 70, 70, Color(240, 240, 240) )
		end
		function main:Close()
			self.Time = CurTime()
			self.Anim = "Close"
			timer.Simple( self.AnimTime , function()
				self:Remove()
			end)
		end
		
		local icon = vgui.Create("SpawnIcon", main)
			icon:SetSize(64,64)
			icon:SetPos((main:GetWide()/2)-(icon:GetWide()/2), 60)
			icon:SetModel(mdl)
			icon.PaintOver = function() return end
			icon.OnMousePressed = function(mousecode) return end
			
		local titleentry = vgui.Create("DTextEntry", main)
			titleentry:SetSize( 150, 20 )
			titleentry:SetPos( (main:GetWide()/2) - (titleentry:GetWide()/2), 140 )
			titleentry:SetText(nme)
			
		local classentry = vgui.Create("DTextEntry", main)
			classentry:SetSize(150, 20)
			classentry:SetPos( (main:GetWide()/2) - (classentry:GetWide()/2), 165 )
			classentry:SetText(cls)
			
		local modelentry = vgui.Create("DTextEntry", main)
			modelentry:SetSize(170,20)
			modelentry:SetPos( (main:GetWide()/2) - (modelentry:GetWide()/2), 190 )
			modelentry:SetText(mdl)
			modelentry.OnLoseFocus = function()
				icon:SetModel(modelentry:GetValue())
			end
			
		local done = EZI.DrawButton(ttltxt, function()
			local tbl = { 
				class = classentry:GetValue(),
				name = titleentry:GetValue(),
				model = modelentry:GetValue()
			}
			net.Start("EZI_SetItemInfo")
				net.WriteTable(tbl)
			net.SendToServer()
			main:Close()
			EZI.OpenAddMenu()
		end)
		main:Add(done)
		done:SetPos( main:GetWide()/2 - done:GetWide() / 2,220 )
		
		local CloseButton = EZI.DrawXButton()
			main:Add(CloseButton)
			CloseButton:SetPos(main:GetWide() - 38, 6)
end

function EZI.OpenAddMenu()
	print("Sent GetItemInfo")
	net.Start("EZI_GetItemInfo")
	net.SendToServer()
end

net.Receive( "EZI_GetItemInfo", function()
	EZI.EntityInfo = net.ReadTable()
	EZI.Items = net.ReadTable()
	
	if IsValid(pAddItems) then
		pAddItems:Remove()
	end
	
	EZI.AddShopItems()
end)

EZI.OpenAddMenu()
