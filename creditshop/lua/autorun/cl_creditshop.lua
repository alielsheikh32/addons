

if SERVER then return end

if game.SinglePlayer() then FindMetaTable( "Player" ).IsAdmin = function() return true end end

surface.CreateFont("medium",
	{
		font = "Bebas Neue",
		size = 24,
		weight = 200
	}
)

local frame
net.Receive( "cs_menu", function()
	local cur = net.ReadInt( 16 )
	local tot = net.ReadInt( 16 )
	
	-- local adminlist = {}
	-- if LocalPlayer():IsAdmin() then
		-- adminlist = net.ReadTable()
	-- end
	
	local exp, prev
	if net.ReadBit() then
		exp, prev = net.ReadInt( 32 ), net.ReadString()
	end
	
	if IsValid( frame ) then frame:Remove() end
	
	frame = vgui.Create( "DFrame" )
	frame:SetSize( ScrW() * 0.8, ScrH() * 0.8 )
	frame:Center()
	frame:SetTitle( "" )
	frame:ShowCloseButton( false )
	frame:MakePopup()
	
	frame.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, 200 )
		surface.DrawRect( 0, 30, w, h - 30 )
	end
	
	local close = vgui.Create( "DButton", frame )
	close:SetSize( 25, 25 )
	close:SetPos( frame:GetWide() - 25, 0 )
	close:SetText( "" )
	close.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, self.Hovered and 255 or 200 )
		surface.DrawRect( 0, 0, w, h )
		draw.SimpleText( "X", "medium", w / 2, h / 2, Color( 220, 220, 220 ), 1, 1 )
	end
	close.DoClick = function() frame:Close() end
	
	local tabbuts = {}
	local tabpans = {}
	local function addTab( txt )
		local but = vgui.Create( "DButton", frame )
		but:SetPos( 105 * #tabbuts, 0 )
		but:SetSize( 100, 30 )
		but:SetText( "" )
		but.sel = #tabbuts == 0
		but.id = #tabbuts + 1
		
		but.Paint = function( self, w, h )
			surface.SetDrawColor( 0, 0, 0, self.Hovered and 255 or 200 )
			surface.DrawRect( 0, 0, w, self.sel and h or h - 5 )
			draw.SimpleText( txt, "medium", w / 2, h / 2 - 2, Color( 220, 220, 220 ), 1, 1 )
		end
		
		but.DoClick = function( self )
			for k, v in pairs( tabbuts ) do v.sel = false end
			self.sel = true
			for k, v in pairs( tabpans ) do v:SetVisible( false ) end
			if tabpans[ self.id ] then tabpans[ self.id ]:SetVisible( true ) end
		end
		
		tabbuts[ #tabbuts + 1 ] = but
		return but
	end
	
	addTab( "Store" )
	addTab( "Buy" ).DoClick = function() gui.OpenURL( "http://www.frozenodyssey.com/donate/" ) end
	addTab( "Account" )
	if LocalPlayer():IsAdmin() then addTab( "Admin" ) end
	
	--{ Claim
	
	local pan = vgui.Create( "DPanelList", frame ) tabpans[ #tabpans + 1 ] = pan
	pan:SetPos( 5, 35 )
	pan:SetSize( frame:GetWide() - 10, frame:GetTall() - 40 )
	pan:SetSpacing( 5 )
	pan:EnableHorizontal( true )
	pan:EnableVerticalScrollbar( true )
	
	local currank = ""
	for k, v in pairs( cs_items ) do
		
		if v[1] == "RPG" then local skip = false for k, v in pairs( LocalPlayer():GetWeapons() ) do if v:GetClass() == "weapon_mad_rpg" then skip = true break end end if skip then continue end end
		if v[1] == "C4" then local skip = false for k, v in pairs( LocalPlayer():GetWeapons() ) do if v:GetClass() == "weapon_mad_c4" then skip = true break end end if skip then continue end end
		if v[1] == "Silent Sniper" then local skip = false for k, v in pairs( LocalPlayer():GetWeapons() ) do if v:GetClass() == "ls_sniper" then skip = true break end end if skip then continue end end
	--	if v[1] == "Shock Rifle" then local skip = false for k, v in pairs( LocalPlayer():GetWeapons() ) do if v:GetClass() == "weapon_asmd" then skip = true break end end if skip then continue end end
		-- if v[1] == "RPG" then local skip = false for k, v in pairs( LocalPlayer():GetWeapons() ) do if v:GetClass() == "weapon_rpg" then skip = true break end end if skip then continue end end
		
		if k ~= 1 and currank ~= v[2] then
			local sp = vgui.Create( "DPanel", pan ) pan:AddItem( sp )
			sp:SetWide( ScrW() * 0.8 )
			sp.Paint = function( self, w, h )
				-- if k ~= 1 then
					-- surface.SetDrawColor( 150, 150, 150 )
					-- surface.DrawRect( 0, 0, w, 2 )
				-- end
				-- draw.SimpleText( v[2], "Trebuchet24", 5, 5, Color( 150, 150, 150 ) )
			end
		end
		
		currank = v[2]
		
		local but = vgui.Create( "DButton", pan ) pan:AddItem( but )
		but:SetSize( 150, 150 )
		but:SetText( "" )
		but.Paint = function( self, w, h )
			
			surface.SetDrawColor( 0, 204, 204, 30 )
			surface.DrawRect( 0, 0, w, h )
			surface.DrawRect( 0, 0, w, 25 )
			surface.DrawRect( 0, h - 25, w, 25 )
			
			draw.SimpleText( v[1], "medium", w / 2, 13, Color( 220, 220, 220 ), 1, 1 )
			draw.SimpleText( v[4] .. " credit" .. ( v[4] == 1 and "" or "s" ), "medium", w / 2, h - 12, Color( 220, 220, 220 ), 1, 1 )
			surface.SetDrawColor( 0, 0, 0 )
			surface.DrawOutlinedRect( 0, 0, w, h )
			
		end
		but.DoClick = function() RunConsoleCommand( "creditsbuy", k ) end
		
		local lab = vgui.Create( "DLabel", but )
		lab:SetPos( 5, 30 )
		lab:SetSize( 140, 90 )
		lab:SetText( v[3] )
		lab:SetWrap( true )
		
	end
	
	--}
	
	--{ Account
	
	local pan = vgui.Create( "DPanelList", frame ) tabpans[ 3 ] = pan
	pan:SetPos( 5, 35 )
	pan:SetSize( frame:GetWide() - 10, frame:GetTall() - 40 )
	pan:SetSpacing( 5 )
	pan:SetPadding( 20 )
	pan:EnableVerticalScrollbar( true )
	pan:SetVisible( false )
	
	local function addText( txt )
		local lab = vgui.Create( "DLabel", pan ) pan:AddItem( lab )
		lab:SetText( txt )
		lab:SetFont( "medium" )
		lab:SizeToContents()
	end
	
	addText( "Name: " .. LocalPlayer():Nick() )
	addText( "SteamID: " .. LocalPlayer():SteamID() )
	addText( "CommunityID: " .. LocalPlayer():SteamID64() )
	local s = vgui.Create( "DPanel", pan ) s:SetWide( ScrW() ) s.Paint = function() end pan:AddItem( s )
	addText( "Credits: " .. cur )
	addText( "Total Bought Credits: " .. tot )
	local s = vgui.Create( "DPanel", pan ) s:SetWide( ScrW() ) s.Paint = function() end pan:AddItem( s )
	if exp ~= 0 then
		addText( "Current rank expires on: " .. os.date( nil, exp ) )
		addText( "Previous Rank: " .. prev )
		local s = vgui.Create( "DPanel", pan ) s:SetWide( ScrW() ) s.Paint = function() end pan:AddItem( s )
	end
	
	local but = vgui.Create( "DButton", pan ) pan:AddItem( but )
	but:SetText( "" )
	but:SetSize( 100, 26 )
	but.DoClick = function()
		local mn = DermaMenu()
		for k, v in pairs( player.GetAll() ) do
			-- if v == LocalPlayer() then continue end
			mn:AddOption( v:Nick(), function()
				Derma_StringRequest( "How many credits do you want to give?", "", "0", function( a )
					RunConsoleCommand( "creditstrade", v:UniqueID(), a )
				end )
			end )
		end
		mn:Open()
	end
	but.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, self.Hovered and 255 or 200 )
		surface.DrawRect( 0, 0, 200, h )
		draw.SimpleText( "Give Credits to player", "medium", 100, h / 2, Color( 220, 220, 220 ), 1, 1 )
	end
	
	--}
	
	--{ Admin
	
	RunConsoleCommand( "creditsadminpoll" )
	
	local pan = vgui.Create( "DListView", frame ) tabpans[ 4 ] = pan
	pan:SetPos( 5, 35 )
	pan:SetSize( frame:GetWide() - 10, frame:GetTall() - 40 )
	pan:SetVisible( false )
	pan:AddColumn( "Player" )
	pan:AddColumn( "Credits" )
	pan:AddColumn( "Total Credits" )
	
	net.Receive( "cs_poll", function()
		if not IsValid( pan ) then return end -- Welp
		
		pan.raw = net.ReadTable()
		
		for _, tab in pairs( pan.raw ) do
			local ply = player.GetByUniqueID( tab.player )
			local a = pan:AddLine( ply:Nick(), tab.current, tab.total )
			a.OnRightClick = function()
				
				local menu = DermaMenu()
				
				menu:AddOption( "Set Credits..", function() Derma_StringRequest( "What do you want to set their credits to?", "", "0", function( d ) RunConsoleCommand( "creditsadminset", ply:EntIndex(), d, 1 ) end ) end )
				
				menu:AddSpacer()
				
				menu:AddOption( "Cancel", function() end )
				
				menu:Open()
				
			end
			a.OnSelect = a.OnRightClick
		end
	end )
	
	--}
	
end )

net.Receive( "cs_thanks", function()
	
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 400, 150 )
	frame:Center()
	frame:SetTitle( "" )
	frame.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, 200 )
		surface.DrawRect( 0, 0, w, h )
	end
	frame:ShowCloseButton( false )
	frame:MakePopup()
	frame:DoModal()
	
	local but = vgui.Create( "DButton", frame )
	but:SetTall( 20 )
	but:Dock( BOTTOM )
	but:SetText( "" )
	but.Paint = function( self, w, h )
		surface.SetDrawColor( 220, 220, 220 )
		surface.DrawRect( w / 2 - 50, 0, 100, h )
		surface.SetDrawColor( 255, 255, 255, 200 )
		if self.Hovered then surface.DrawRect( w / 2 - 50, 0, 100, h ) end
		
		draw.SimpleText( "OK", "medium", w / 2, h / 2, Color( 0, 0, 0 ), 1, 1 )
	end
	but.DoClick = function() frame:Close() end
	
	local pan = vgui.Create( "DPanel", frame )
	pan:Dock( FILL )
	pan.Paint = function( self, w, h )
		draw.SimpleText( "Thanks for donating to Frozen Odyssey!", "medium", w / 2, h / 2 - 24, Color( 220, 220, 220 ), 1, 0 )
		draw.SimpleText( "Enjoy your credits!", "medium", w / 2, h / 2 - 6, Color( 220, 220, 220 ), 1, 0 )
	end
	
end )

net.Receive( "cs_msg", function()
	
	local msg = net.ReadString()
	
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 600, 150 )
	frame:Center()
	frame:SetTitle( "" )
	frame.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, 200 )
		surface.DrawRect( 0, 0, w, h )
	end
	frame:ShowCloseButton( false )
	frame:MakePopup()
	frame:DoModal()
	
	local but = vgui.Create( "DButton", frame )
	but:SetTall( 20 )
	but:Dock( BOTTOM )
	but:SetText( "" )
	but.Paint = function( self, w, h )
		surface.SetDrawColor( 220, 220, 220 )
		surface.DrawRect( w / 2 - 50, 0, 100, h )
		surface.SetDrawColor( 255, 255, 255, 200 )
		if self.Hovered then surface.DrawRect( w / 2 - 50, 0, 100, h ) end
		
		draw.SimpleText( "OK", "medium", w / 2, h / 2, Color( 0, 0, 0 ), 1, 1 )
	end
	but.DoClick = function() frame:Close() end
	
	local pan = vgui.Create( "DPanel", frame )
	pan:Dock( FILL )
	pan.Paint = function( self, w, h )
		draw.SimpleText( msg, "medium", w / 2, h / 2 - 15, Color( 220, 220, 220 ), 1, 0 )
	end
	
end )