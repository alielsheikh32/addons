	pInventory = pInventory or NULL
	pNotif = pNotif or NULL
	pBank = pBank or NULL
	pAdmin = pAdmin or NULL
	AdminSelect = AdminSelect or NULL
	
	local function DrawPNG(pngtex, x, y, w, h, color)
		surface.SetMaterial( pngtex )
		surface.SetDrawColor(color)
		surface.DrawTexturedRect( x, y, w, h )
	end
				
	function EZI.DrawDropSpots(drop, give, use)
		InvDropSpots = {}
		InvDropPos = {}
		
		local invw, invh = pInventory:GetWide(), pInventory:GetTall()
		
		local function CreatePanel( png, text )
			local DropPanel = vgui.Create("EZ_DropSpot")
			DropPanel:SetText(text)
			DropPanel:SetImage(png)
			return DropPanel
		end
		
		if drop == true then
		local DropPanel = CreatePanel( "fatcow32/box_down.png", "Drop" )
			table.insert(InvDropSpots, DropPanel)
			function DropPanel:UpdatePos(invposx, invposy)
				DropPanel.PosX1, DropPanel.PosY1 = invposx + 10, (invposy + invh) + 5
				DropPanel.PosX2, DropPanel.PosY2 = DropPanel.PosX1, DropPanel.PosY1 - 90
				DropPanel:SetPos( DropPanel.PosX2, DropPanel.PosY2 )
			end
			
			DropPanel:Receiver("Inventory", function(panel, tbl, dropped)
				if dropped == true then 
					for k, v in pairs(tbl) do
							net.Start("EZI_DropItem")
								net.WriteString(tostring(v.item.id))
							net.SendToServer()
							
					end
					if !(pNotif == NULL) and IsValid(pNotif) then pNotif:Close() end
				end
			end)
		end
		
		if give == true then
		local GivePanel = CreatePanel( "fatcow32/user.png", "Give" )
			table.insert(InvDropSpots, GivePanel)
			function GivePanel:UpdatePos(invposx, invposy)
				GivePanel.PosX1, GivePanel.PosY1 = invposx + 10 + 76, (invposy + invh) + 5
				GivePanel.PosX2, GivePanel.PosY2 = GivePanel.PosX1, GivePanel.PosY1 - 90
				GivePanel:SetPos( GivePanel.PosX2, GivePanel.PosY2 )
			end
			
			GivePanel:Receiver("Inventory", function(panel, tbl, dropped)
				if dropped == true then
					local ent = LocalPlayer():GetEyeTrace().Entity
					if !ent:IsPlayer() then return end
					for k, v in pairs(tbl) do
						net.Start("EZI_GiveItem")
							net.WriteString(v.item.id)
							net.WriteEntity(LocalPlayer():GetEyeTrace().Entity)
						net.SendToServer()
					end
					if !(pNotif == NULL) then pNotif:Close() end
				end
			end)
		end
			
		if use == true then
		local UsePanel = CreatePanel( "fatcow32/hand.png", "Use" )
			table.insert(InvDropSpots, UsePanel)
			function UsePanel:UpdatePos(invposx, invposy)
				UsePanel.PosX1, UsePanel.PosY1 = (invposx + 10) + (76 * 2), (invposy + invh) + 5
				UsePanel.PosX2, UsePanel.PosY2 = UsePanel.PosX1, UsePanel.PosY1 - 90
				UsePanel:SetPos( UsePanel.PosX2, UsePanel.PosY2 )
			end
			
			UsePanel:Receiver("Inventory", function(panel, tbl, dropped)
				if dropped == true then 
					for k, v in pairs(tbl) do
						net.Start("EZI_UseItem")
							net.WriteString(v.item.id)
						net.SendToServer()
					end
					if !(pNotif == NULL) and IsValid(pNotif) then pNotif:Close() end
					pInventory:Close()
				end
			end)
		end
	end
	
	function EZI.AddItemsToLayout(ItemTable, Layout, ClickFunc, DropTitle, DropSpot)
		local items = {}
		local count = 0
		
		for k, v in pairs (ItemTable) do
			local item = v
			item.id = k
				
			local MainFrame = EZI.CreateItemSlot(ClickFunc, item, DropTitle )
			Layout:Add(MainFrame)
			
			if DropSpot == true then
				function MainFrame:OnStartDragging()
				
					if !(InvDropSpots) then
						EZI.DrawDropSpots(true, true, true)	
					end
						
					for k, v in pairs(InvDropSpots) do
						local invposx, invposy = pInventory:GetPos()
						v:UpdatePos(invposx, invposy)
					end
					
					for k, v in pairs(InvDropSpots) do
						v:SetVisible(true)
						v:MoveTo( v.PosX1, v.PosY1 + 15, 0.2, 0, 1, function()
							local x, y = v:GetPos()
							if y == v.PosY1 + 15 then
								v:MoveTo(v.PosX1, v.PosY1, 0.1, 0, 1)
							end
						end)
					end
				end
				
				function MainFrame:OnStopDragging()
					for k, v in pairs(InvDropSpots) do
						v:MoveTo( v.PosX2, v.PosY2, 0.2, 0, 1, function() 
							v:SetVisible(false)
						end)
					end
				end
			end
		end
	end
	
	function EZI.DrawPageButtons(x,y)
	
		surface.CreateFont( "PageButtonFont", {
			font = "Exo",
			size = 22,
			weight = 500,
			antialias = true
		})
		
		local function CreateButtonFrame(text)
			local Button = vgui.Create( "DButton" )
				Button:SetSize(25, 18)
				Button:SetText("")
				Button.Paint = function(self)
					surface.SetDrawColor( 255,255,255,0 )
					draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color(40,40,40) )
					draw.RoundedBox( 0, 1, 1, self:GetWide()-2, self:GetTall()-2, Color(240,240,240) )
					draw.SimpleTextOutlined( text, "PageButtonFont", 8, -2, Color( 240,240,240 ), 0, 0, 1, Color( 40,40,40 ) )
				end
			return Button
		end
		
		local Back = CreateButtonFrame("<")
		Back:SetPos( x,y )
		
		local Forward = CreateButtonFrame(">")
			Forward:SetPos( x + 28,y )
		
		return Back, Forward
		
	end
	
	function EZI.CreateItemSlot( clickfunc, item, DropTitle )
	
		if (item.class == "spawned_shipment") then
			item.model = "models/Items/item_item_crate_dynamic.mdl"
		end
	
		local ItemSlot = vgui.Create("EZ_ItemSlot")
			ItemSlot:SetItem(item)
			if DropTitle then
				ItemSlot:Droppable(DropTitle)
			end
							
			ItemSlot.icon.DoClick = function() clickfunc(ItemSlot.item) end
			ItemSlot.DoClick = function() clickfunc(ItemSlot.item) end
		
		return ItemSlot
		
	end

	/*=========================================================
						Click Functions
	=========================================================*/
	
	function EZI.InventoryClick(item)
		local menu = DermaMenu()
		menu:AddOption("Drop Item", function()
			net.Start("EZI_DropItem")
				net.WriteString(tostring(item.id))
			net.SendToServer()
		end)
		menu:AddOption("Give Item", function()
			tr = LocalPlayer():GetEyeTrace()
			net.Start("EZI_GiveItem")
				net.WriteString(tostring(item.id))
				net.WriteEntity(tr.Entity)
			net.SendToServer()
		end)
		local use = "Use Item"
		if (item.class == "spawned_weapon") or (item.class == "spawned_shipment") then use = "Equip Item" end
		menu:AddOption(use, function()
			net.Start("EZI_UseItem")
				net.WriteString(item.id)
			net.SendToServer()
			pInventory:Close()
		end)
		menu:Open()
	end
	
	function EZI.AdminClick(item)
		local menu = DermaMenu()
		menu:AddOption("Delete Item", function()
			net.Start("EZI_DeleteItem")
				net.WriteString(tostring(item.id))
				net.WriteEntity( AdminSelect )
			net.SendToServer()
		end)
		
		menu:AddOption("Transfer Item", function()
			EZI.TransferItem( item, AdminSelect )
		end)
		menu:Open()
	end

	/*=========================================================
						Dialog Functions
	=========================================================*/
	
	function EZI.DialogBox( text, func )
			local dialog = vgui.Create("DPanel")
				dialog:SetSize(220, 75)
				dialog:MakePopup()
				dialog:Center()
				dialog.Paint = function(self)
					draw.RoundedBox(0, 1 ,1, self:GetWide() - 2, self:GetTall() - 2, Color(50, 50, 50, 250))
					draw.RoundedBox(0, 0, 1, 1, self:GetTall() - 2, Color(30,30,30) )
					draw.RoundedBox(0, 1, 0, self:GetWide() - 2, 1, Color(30,30,30) )
					draw.RoundedBox(0, 1, self:GetTall() - 1, self:GetWide() - 2, 1, Color(30,30,30) )
					draw.RoundedBox(0, self:GetWide() - 1, 1, 1, self:GetTall() - 2, Color(30,30,30) )
					surface.SetFont("Exo500_15")
					local txtsze = surface.GetTextSize(text)
					draw.SimpleText( text, "Exo500_15", dialog:GetWide() /2, 20, Color(240,240,240), 1, 1 )
				end
				
			local function DrawButton( self, buttontxt )
				draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(240,240,240))
				surface.SetFont("Exo500_20")
				local txtsze = surface.GetTextSize(buttontxt)
				draw.SimpleText( buttontxt, "Exo500_20", (self:GetWide() / 2), self:GetTall() / 2, Color(50,50,50), 1, 1 )
			end
				
			local close = vgui.Create("DButton", dialog)
				close:SetSize(100, 30)
				close:SetPos( 8, 42 )
				close:SetText(" ")
				close.Paint = function(self)
					DrawButton( self, "Close" )
				end
				close.DoClick = function()
					dialog:Remove()
				end
				
			local cont = vgui.Create("DButton", dialog)
				cont:SetSize(100, 30)
				cont:SetPos( 108 + 4, 42 )
				cont:SetText("")
				cont.Paint = function(self)
					DrawButton( self, "Ok" )
				end
				cont.DoClick = function()
					func()
					dialog:Remove()
				end
	end
	
	function EZI.DrawButton(buttontext, click)				
		local button = vgui.Create("DButton", dialog)
			button:SetSize(100, 30)
			button:SetPos( 8, 42 )
			button:SetText(" ")
			button.Paint = function(self)
				draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(240,240,240))
				surface.SetFont("Exo500_20")
				local txtsze = surface.GetTextSize(buttontext)
				draw.SimpleText( buttontext, "Exo500_20", (self:GetWide() / 2), self:GetTall() / 2, Color(50,50,50), 1, 1 )
			end
			button.DoClick = click
		return button
	end
	
	function EZI.DoAlpha(self)
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
	
	function EZI.DrawXButton()
		local function DrawButton(self, col)
			self.Paint = function()
				local avglow = (math.sin( CurTime() * 1.4 ) + 1) * 90
					draw.RoundedBox( 0, 0, 0, self:GetWide() , self:GetTall(), col )
					draw.SimpleText( "X", "Exo700_32", 8, 0, Color( 20 + avglow,20,20,255 ), 0, 0 )
				end
			end
 
		local CloseDButton = vgui.Create( "DButton" )
			CloseDButton:SetSize( 32, 32 )
			CloseDButton:SetText( "" )
			DrawButton(CloseDButton, Color(220,220,220,240))
			CloseDButton.OnCursorEntered = function(self) DrawButton(self, Color(240,240,240,240)) end
			CloseDButton.OnCursorExited = function(self) DrawButton(self, Color(220,220,220,240)) end
			CloseDButton.DoClick = function(self)
				local parent = self:GetParent()
				parent:Close()
			end
			
		return CloseDButton
	end
	
	function EZI.DrawOptionButton(png, click)
		local btn = vgui.Create("EZ_OptionButton")
		btn:SetImage(png)
		btn.DoClick = click
		return btn
	end	
	
	function EZI.DrawInventoryMenu()
		menu = vgui.Create("EZ_Inventory")
		menu:SetSize(245, 310)
		if pInventoryPos then
			menu:SetPos( pInventoryPos.xpos, pInventoryPos.ypos )
		else
			menu:Center()
		end
		menu:SetTitle("Inventory")
		menu:MakePopup()
									
	--	if EZI.Notifications.dnd == false then
	--		pNotif = EZI.DrawNotification( "Drag item for quick actions", menu )
	--		local x, y = menu:GetPos()
	--		pNotif:SetPos( x, y - 38 )
	--	end					

		local function RemoveButton()
			local emptyinv = EZI.DrawOptionButton("ezi/delete_package.png", function()
				EZI.DialogBox("Are you sure you want to empty your inventory?", function()
				net.Start("EZI_EmptyInv")
				net.SendToServer()
				end)
			end)
			menu:AddButton(emptyinv)
		end
			
		local function AdminButton()
		local adminstart = EZI.DrawOptionButton("ezi/account_functions.png", function(self)
			local parent = self:GetParent()
			parent:GetParent():Close()
			EZI.DrawAdminMenu()
		end)
			menu:AddButton(adminstart)
		end
		
		local function AddItems()
			local additem = EZI.DrawOptionButton("ezi/plus.png", function(self)
				local parent = self:GetParent()
				parent:GetParent():Close()
				EZI.OpenAddMenu()
			end)
				menu:AddButton(additem)
		end
		
		if EZI.config.AllowEmpty == true then
			RemoveButton()
		end
		
		if EZI.config.ULX == true then
			local group = LocalPlayer():GetUserGroup()
			if table.HasValue(EZI.config.ULXGroups, group) then
				AdminButton()
				AddItems()
			end
		else
			if LocalPlayer():IsAdmin() then
				AdminButton()
				AddItems()
			end
		end
	
		return menu
	end

	function EZI.TransferItem( item, ply )
		local playerto
		local main = vgui.Create("DPanel")
			main:SetSize( 230, 200 )
			main:Center()
			main:SetVisible(true)
			main:MakePopup()
			function main:Close()
				self:Remove()
			end
				
		local Title = vgui.Create("DLabel", main)
			Title:SetText("Transfer Item")
			Title:SetFont("Exo700_32")
			Title:SetColor( Color( 240,240,240,255 ) )
			Title:SetPos(10,5)
			Title:SizeToContents()
			
			local CloseButton = EZI.DrawXButton()
			main:Add(CloseButton)
			CloseButton:SetPos(main:GetWide() - 38, 6)
			
		local itmpnl = EZI.CreateItemSlot( function() end, item )
			main:Add(itmpnl)
			itmpnl:SetPos( (main:GetWide() / 2) - (itmpnl:GetWide() / 2), 50 )
			
		local PlayerSelect = vgui.Create("DComboBox", main)
			PlayerSelect:SetSize( 150, 20 )
			PlayerSelect:SetPos((main:GetWide() / 2) - (PlayerSelect:GetWide() / 2), 130)
			PlayerSelect:SetValue("Transfer to...")
			local players = player.GetAll()
			for k, v in pairs(players) do
				PlayerSelect:AddChoice(v:Nick())
			end
			PlayerSelect.OnSelect = function( panel, index, value, data )
				playerto = players[index]
			end
			
		local transfer = EZI.DrawButton("Transfer", function()
			if !playerto then return end
			net.Start("EZI_AdminTransfer")
				net.WriteString(tostring(item.id))
				net.WriteEntity(AdminSelect)
				net.WriteEntity(playerto)
			net.SendToServer()
			main:Close()
		end)
			main:Add(transfer)
			transfer:SetPos( (main:GetWide() / 2) - (transfer:GetWide() / 2), 160 )
			
			main.Paint = function(self)
				draw.RoundedBox(0, 1, 1, self:GetWide() - 2, self:GetTall() - 2, Color(50, 50, 50, 250))
				draw.RoundedBox(0, 0, 1, 1, self:GetTall() - 2, Color(30,30,30) )
				draw.RoundedBox(0, 1, 0, self:GetWide() - 2, 1, Color(30,30,30) )
				draw.RoundedBox(0, 1, self:GetTall() - 1, self:GetWide() - 2, 1, Color(30,30,30) )
				draw.RoundedBox(0, self:GetWide() - 1, 1, 1, self:GetTall() - 2, Color(30,30,30) )
				local itmpnlx, itmpnly = itmpnl:GetPos()
				draw.RoundedBox(0, itmpnlx - 3, itmpnly - 3, 76, 76, Color(240,240,240))
			end
	end
	
	function EZI.DrawAdminMenu(tbl)
	
		if EZI.config.ULX == true then
			local group = LocalPlayer():GetUserGroup()
			if !table.HasValue(EZI.config.ULXGroups, group) then
				return
			end
		else
			if !LocalPlayer():IsAdmin() then
				return
			end
		end
					
		local main = vgui.Create("EZ_Window")
			pAdmin = main
			main:SetSize(245, 360)
			main:Center()
			main:SetColor( Color(50, 50, 50) )
			main:SetTitle("Admin Control")
			main:MakePopup()
			
			main.PaintFunc = function(self)
				draw.RoundedBox(0, 10, 50, self:GetWide() - 20, 225, Color(240, 240, 240, 255))
			end
			
		local btnlist = vgui.Create("DIconLayout", main)
			btnlist:SetSize(280, 50)
			btnlist:SetPos( 18, 280 )
			btnlist:SetSpaceX(4)
		
		local PlayerSelect = vgui.Create("DComboBox", btnlist)
			PlayerSelect:SetPos(10, 333)
			PlayerSelect:SetSize( 150, 20 )
			PlayerSelect:SetValue("Select a Player...")
			local players = player.GetAll()
			for k, v in pairs(players) do
				PlayerSelect:AddChoice(v:Nick())
			end
			PlayerSelect.OnSelect = function( panel, index, value, data )
				AdminSelect = players[index]
			end
			
						
		local function DrawInventory( tbl )
			local itemscroll = vgui.Create("DScrollPanel")
				itemscroll:SetSize( 250, 220 )
				itemscroll:SetPos( 13, 53 )
				itemscroll.Paint = function() 
					surface.SetDrawColor( 50, 50, 50, 0 )
				end
				itemscroll:SetSkin("EZI_Skin")
				ScrollVBar = itemscroll:GetVBar()
				ScrollVBar:SetVisible(false)
				ScrollVBar.btnDown:SetVisible(false)
				ScrollVBar.btnUp:SetVisible(false)
					
			local ilist = vgui.Create("DIconLayout", itemscroll)
				ilist:SetSize( 224, 225 )
				ilist:SetSpaceX(4)
				ilist:SetSpaceY(4)		
				
			EZI.AddItemsToLayout(tbl, ilist, EZI.AdminClick, "Inventory", false)
				
			return itemscroll
		end
					
		local getinv = EZI.DrawOptionButton("ezi/folder_vertical_open.png", function(self)
			if AdminSelect == NULL then return end
			net.Start("EZI_GetInv")
				net.WriteEntity(AdminSelect)
			net.SendToServer()
		end)
			btnlist:Add(getinv)
			getinv:SetPos(164, 330)
		
		if tbl then
		local invitems = DrawInventory( tbl )
			main:Add(invitems)
				
			local deleteinv = EZI.DrawOptionButton("ezi/delete_package.png", function(self)
				if AdminSelect == NULL then return end
				EZI.DialogBox("Are you sure you want to empty this inventory?", function()
					net.Start("EZI_AdminEmptyInv")
						net.WriteEntity(AdminSelect)
					net.SendToServer()
				end)
			end)
			btnlist:Add(deleteinv)
			deleteinv:SetPos(192, 330)
		end
			
		function main:Close()
			self:Remove()
		end
			
		local CloseButton = EZI.DrawXButton()
			main:Add(CloseButton)
			CloseButton:SetPos(main:GetWide() - 38, 6)
			
		local grptxt = "Set Group Space"
		if !EZI.ULXRank then
			grptxt = "ULX Group Module required"
		end
			
		local groupslot = EZI.DrawButton(grptxt, function()
			if !EZI.ULXRank then return end
			EZI.DrawSpaceChanger()	
		end)
		main:Add(groupslot)
		groupslot:SetSize( 200, 30 )
		groupslot:SetPos( (main:GetWide()/2) - (groupslot:GetWide()/2), 310 )
			
	end
	
	net.Receive("EZI_OpenInventory", function()
		local inventory = net.ReadTable()
		local maxspace = net.ReadInt(32)
				
		local x, y
		if (pInventory and pInventory:IsValid()) then
			pInventory:Close()
			pInventory = nil
		end
		
		local menu = EZI.DrawInventoryMenu()
		pInventory = menu
		
				
		EZI.AddItemsToLayout(inventory, menu:GetItemList(), EZI.InventoryClick, "Inventory", true)
				
	end)

	net.Receive("EZI_ConfigSetup", function()
		EZI.config = net.ReadTable()
	end)

	net.Receive("EZI_GetInv", function()
		local inv = net.ReadTable()
		if pAdmin then
			pAdmin:Close()
		end
		EZI.DrawAdminMenu(inv)
	end)
	
	timer.Simple(1,function()
		if EZI.config.ToggleKey == KEY_F1 then
			GAMEMODE.ShowHelp = function() end
		end
	end)
	
	pressedkey = false
	timer.Simple( 1, function()
		hook.Add("Tick", "OpenInventory", function()
			local ply = LocalPlayer()
			
			if (!IsValid(ply)) then return end
			if !ply:IsTyping() and !gui.IsGameUIVisible() and input.IsKeyDown(EZI.config.ToggleKey) then
				if pressedkey == false then
					pressedkey = true
					if pInventory and pInventory:IsValid() then
						pInventory:Close()
						timer.Simple(0.3, function()
							pressedkey = false
						end)
					else
						net.Start("EZI_OpenInv")
						net.SendToServer()
						timer.Simple(0.3, function()
							pressedkey = false
						end)
				end
				end
			end
		end)
	end)