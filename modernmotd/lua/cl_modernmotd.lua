--Modern MOTD Main Client Dist
if MODERN then MODERN = MODERN
else MODERN = {} end

MODERN.CurrentHeight = ScrH() / 2
include('cl_fonts.lua')
include('sh_config.lua')
include('cl_tabs.lua')
include('cl_addtabs.lua')
include('cl_addservers.lua')
--Include panels
include('panels/cl_menubutton.lua')
include('panels/cl_serverpanel.lua')

function MODERN.OpenMOTD( settings )
	if not LocalPlayer() then return end
	MODERN.MainWindowOpen = true
	if !ModernMainWindow then
		ModernMainWindow = vgui.Create( "DFrame" )
		ModernMainWindow:SetSize( ScrW(), ScrH() )
		ModernMainWindow:Center()
		ModernMainWindow:SetDraggable( false )
		ModernMainWindow:ShowCloseButton( false )
		ModernMainWindow:SetTitle( "" )
		ModernMainWindow:SetBackgroundBlur( true )
		ModernMainWindow.Paint = MODERN.PaintMainWindow
		MODERN.TabManager = {}
		
		if MODERN.Settings.ShowAvatar then
		local avatarImg = vgui.Create("AvatarImage", ModernMainWindow)
		avatarImg:SetSize(28,28)
		avatarImg:SetPos(10 , 130)
		avatarImg:SetPlayer(LocalPlayer(), 64)
		end
		
		if MODERN.Settings.ShowPlayerName then
		local avatarText = vgui.Create("DLabel", ModernMainWindow)
		avatarText:SetPos(ScrW() - 50 , 135)
		avatarText:SetText("Welcome back, " .. LocalPlayer():Name())
		avatarText:SetFont("Bebas18Font")
		avatarText:SetColor(Color(255,255,255,150))
		avatarText:SizeToContents()
		avatarText:SetPos(ScrW() - (avatarText:GetWide() + 5) , 133)
		end
		
		//MOTD Menu/Tab List
		local MenuButtonList = vgui.Create( "DPanelList", ModernMainWindow )
		MenuButtonList:SetSize( 450, ScrH() - (ScrH() / 3.5))
		MenuButtonList:SetPos( 10, 165 )
		MenuButtonList:SetPadding( 0 )
		MenuButtonList:SetSpacing( 3 )
		MenuButtonList:SetAutoSize( false )
		MenuButtonList:SetNoSizing( false )
		MenuButtonList:EnableVerticalScrollbar( true )
		MenuButtonList.Paint = function() end
		
		//MOTD Tabs
		for k,v in pairs(MODERN.Tabs) do
			local Button = vgui.Create( "ModernButton" )
			Button:SetText(v.title)
			Button:SetColor(v.settings.color)
			if v.settings.subtitle then Button:SetSubText(v.settings.subtitle) end
			if v.settings.icon then Button:SetImage(v.settings.icon, 32, 32 ) end
			
			if v.settings.url then
				local html = vgui.Create( "HTML", ModernMainWindow )
				html:SetSize( ScrW() - 475, ScrH() - (ScrH() / 3.5))
				html:SetPos( 470, 165 )
				//html:OpenURL( v.settings.url )
				html:SetVisible(false)
				
				--Add to tab manager, setup click function
				Button.DoClick = function() MODERN.ShowTabPanel(html, Button, v.settings.url) end
				table.insert(MODERN.TabManager, {btn = Button, panel = html, url = v.settings.url})
			elseif v.settings.serverlist then
				//MOTD ServerList
				local ServerList = vgui.Create( "DPanelList", ModernMainWindow )
				ServerList:SetSize( ScrW() / 3 + 90, ScrH() - (ScrH() / 3.5))
				ServerList:SetPos( 470, 165 )
				ServerList:SetPadding( 0 )
				ServerList:SetSpacing( 3 )
				ServerList:SetAutoSize( false )
				ServerList:SetNoSizing( false )
				ServerList:EnableVerticalScrollbar( true )
				ServerList.Paint = function() end
				ServerList:SetVisible(false)
				
				for l,m in pairs(MODERN.Servers) do
					local Server = vgui.Create( "ModernServerButton" )
					Server:SetText(m.title)
					Server:SetColor(m.settings.color)
					Server.DoClick = function()
						Derma_Query('Are you sure you want to connect to ' .. m.title .. '?', 'Leaving this server',
						'Yes', function() LocalPlayer():ConCommand("connect " .. m.settings.serveripport) end,
						'No', function() end)
			end
					if m.settings.subtitle then Server:SetSubText(m.settings.subtitle) end
					if m.settings.showgametracker then Server:SetGametracker(m.settings.serveripport) end
					ServerList:AddItem(Server)
				end
				Button.DoClick = function() MODERN.ShowTabPanel(ServerList, Button) end
				table.insert(MODERN.TabManager, {btn = Button, panel = ServerList})
			elseif v.settings.text then
				//MOTD Menu/Tab List
				local TextLabelsList = vgui.Create( "DPanelList", ModernMainWindow )
				TextLabelsList:SetSize( ScrW() - 475, ScrH() - (ScrH() / 3.5))
				TextLabelsList:SetPos( 470, 165 )
				TextLabelsList:SetPadding( 0 )
				TextLabelsList:SetSpacing( 3 )
				TextLabelsList:SetAutoSize( false )
				TextLabelsList:SetNoSizing( false )
				TextLabelsList:EnableVerticalScrollbar( true )
				TextLabelsList.Paint = function() end
				TextLabelsList:SetVisible(false)
				
				local txttable = string.Explode("\n",v.settings.text)
				if istable(txttable) then
					for l,m in pairs(txttable) do
						local text = vgui.Create("DLabel")
						text:SetText(m)
						text:SetFont(MODERN.Settings.TextTabFont)
						text:SizeToContents()
						if text:IsValid() then
							TextLabelsList:AddItem(text)
						end
					end
				end
				Button.DoClick = function() MODERN.ShowTabPanel(TextLabelsList, Button) end
				table.insert(MODERN.TabManager, {btn = Button, panel = TextLabelsList})
			elseif v.settings.steamurl then
				Button.DoClick = function() gui.OpenURL(v.settings.steamurl) end
				table.insert(MODERN.TabManager, {btn = Button})
			elseif v.settings.close then
				if settings.waitbeforeclose then
					MODERN.CanCloseTime = CurTime() + settings.waitbeforeclose
					function Button:Think()
						local time = math.Clamp(MODERN.CanCloseTime - CurTime(), 0, settings.waitbeforeclose)
						local timetext = string.FormattedTime(time, "%02i:%02i")
						Button:SetText(v.title .. " (Wait " .. timetext  .." )")
					end					
				end
				Button.DoClick = function() 
					if MODERN.CanCloseTime and (CurTime() >= MODERN.CanCloseTime) then
						MODERN.CloseMOTD()
					elseif not settings.waitbeforeclose then
						MODERN.CloseMOTD()
					end
				end
				table.insert(MODERN.TabManager, {btn = Button})
			end
			MenuButtonList:AddItem(Button)
		end
		
		ModernMainWindow:MakePopup()
		
		//Open first menu tab
		if MODERN.TabManager[MODERN.Settings.OpenTab] then 
		MODERN.ShowTabPanel(MODERN.TabManager[MODERN.Settings.OpenTab].panel,
		MODERN.TabManager[MODERN.Settings.OpenTab].btn,MODERN.TabManager[MODERN.Settings.OpenTab].url)
		if MODERN.Settings.MenuSounds then surface.PlaySound(MODERN.Settings.MenuOpenSound) end
		end
	else
		MODERN.CloseMOTD()
	end
end
//concommand.Add("motd", MODERN.OpenMOTD)
usermessage.Hook("MODERN_Open", MODERN.OpenMOTD)

function MODERN.ShowTabPanel(panel, btn, url)
	if not ModernMainWindow or not panel or not btn then return end
	for k,v in pairs(MODERN.TabManager) do
		if IsValid(v.panel) and IsValid(v.btn) then 
			v.panel:SetVisible(false)
			v.btn:ToggleSelect(false)
		end
		
	end
	btn:ToggleSelect(true)
	if url then panel:OpenURL(url) end
	panel:SetVisible(true)
	if MODERN.Settings.MenuSounds then surface.PlaySound(MODERN.Settings.ButtonClickSound) end
end

local FKeyReleased = false
function MODERN.PaintMainWindow()
	
	//Paint window itself
	Derma_DrawBackgroundBlur(ModernMainWindow)
	surface.SetDrawColor(MODERN.Theme.WindowColor)
	
	//local curTall = math.max( ScrH() - 50, ScrH() - 50 )
	//local curTall = math.Clamp( ScrH() - 100, 512, ScrH() * .8 )
	MODERN.CurrentHeight = math.Approach( MODERN.CurrentHeight, ScrH() - 100, FrameTime() * 400 )
	surface.DrawRect(0, 50, ScrW(), MODERN.CurrentHeight)
	
	//Banner heading
	surface.SetMaterial( MODERN.Theme.BannerMaterial );
	surface.SetDrawColor( MODERN.Theme.BannerColor );
	surface.DrawTexturedRect( 0, 50, ScrW(), 75 );	
	draw.DrawText(MODERN.Settings.MOTDTitle, "Bebas70Font", 10, 57, color_white, 0)
	
	//Bottom information scroller
	local x = math.fmod(SysTime() * MODERN.ScrollerSpeed,MODERN.ScrollerWidth)
	surface.SetFont(MODERN.ScrollerFont)
	local w,h = surface.GetTextSize(MODERN.ScrollerText)
	draw.DrawText(MODERN.ScrollerText,MODERN.ScrollerFont,math.fmod(SysTime() * MODERN.ScrollerSpeed,MODERN.ScrollerWidth),MODERN.ScrollerYPos,MODERN.Theme.ScrollerTextColor,0)
	
	if MODERN.Settings.FKeyBind and not MODERN.Settings.FKeyBind == "" 
	and MODERN.Settings.CloseOnFKeyBind and MODERN.MainWindowOpen then
		local enum = MODERN.BindsToEnum[MODERN.Settings.FKeyBind]
		if (input.IsKeyDown(enum)) then
			if FKeyReleased and MODERN.CanCloseTime and (CurTime() >= MODERN.CanCloseTime) then
				MODERN.CloseMOTD()
			elseif FKeyReleased and not MODERN.CanCloseTime then MODERN.CloseMOTD() end
		else
			FKeyReleased = true
		end
	end
end

function MODERN.CloseMOTD()
	if ModernMainWindow then
		ModernMainWindow:Remove()
		ModernMainWindow = nil
		MODERN.CanCloseTime = nil
		FKeyReleased = false
		if MODERN.Settings.MenuSounds then surface.PlaySound(MODERN.Settings.MenuCloseSound) end
	end
	MODERN.MainWindowOpen = false
end

--BindKey
local Binds = {
	["gm_showhelp"] = "F1",
	["gm_showteam"] = "F2",
	["gm_showspare1"] = "F3",
	["gm_showspare2"] = "F4"
}

MODERN.BindsToEnum = {
	["F1"] = KEY_F1,
	["F2"] = KEY_F2,
	["F3"] = KEY_F3,
	["F4"] = KEY_F4
}

function MODERN.PlayerBindPress( ply, bind, down )
	local bnd = string.match(string.lower(bind), "gm_[a-z]+[12]?")
	if bnd and Binds[bnd] and Binds[bnd] == MODERN.Settings.FKeyBind then
		local settings = {}
		MODERN.OpenMOTD(settings)
	end
	//return false
end
hook.Add("PlayerBindPress","MODERN_PlayerBindPress",MODERN.PlayerBindPress)

--InitPostEntity
function MODERN.InitPostEntity()
	//LocalPlayer is ready
	if MODERN.Settings.ShowOnPlayerConnect then
		local settings = {}
		if MODERN.Settings.ShowOnPlayerConnectWaitSeconds then
			settings.waitbeforeclose = tonumber(MODERN.Settings.ShowOnPlayerConnectWaitSeconds)
		end
		MODERN.OpenMOTD( settings )
	end
end
hook.Add("InitPostEntity","MODERN_InitPostEntity",MODERN.InitPostEntity)