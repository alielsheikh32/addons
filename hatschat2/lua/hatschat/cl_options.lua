------------------------------------
-------------HatsChat 2-------------
------------------------------------
--Copyright (c) 2013 my_hat_stinks--
------------------------------------

--You probably don't want to edit this file, it's just the settings window
--Emotes, fonts, and LineIcons are in autorun/sh_hatschats.lua
--Editable client vars are in cl_init.lua
--Themes system is in sh_themes.lua, and themes are in hatschat/themes/

--Options Window--
------------------
function HatsChat:PopulateOptions( SettingsFrame )
	local scrw, scrh = ScrW(), ScrH()
	--Chatbox Window Settings
	--_______________________
	local set = vgui.Create("DForm", SettingsFrame)
	set:SetName( "Chatbox Window" )
	
	--So we can do it in order instead of having it all mixed up
	local BottomAlignBox,VertPosSlide,RightAlignBox,HoriPosSlide,WindHighSlide,WindWideSlide
	
	BottomAlignBox = set:CheckBox( "Align to Bottom", HatsChat.Settings.WindowAlignY:GetName() )
	BottomAlignBox.OnChange = function( s,data )
		HatsChat:DoWindowPos( {yalign = data} )
		if IsValid(VertPosSlide) then
			local val = s.PrevValue or VertPosSlide:GetValue()
			if data~=s.PrevData then --Called twice, for some reason
				s.PrevValue = VertPosSlide:GetValue()
				s.PrevData = data
			end
			if data then
				VertPosSlide:SetMin( HatsChat.Settings.WindowSizeY:GetInt() )
				VertPosSlide:SetMax( scrh )
			else
				VertPosSlide:SetMax( scrh-HatsChat.Settings.WindowSizeY:GetInt() )
				VertPosSlide:SetMin( 0 )
			end
			VertPosSlide:SetValue( math.Clamp(val or VertPosSlide:GetValue(), VertPosSlide:GetMin(), VertPosSlide:GetMax()) )
		end
	end
	
	VertPosSlide = set:NumSlider( "Vertical Position", HatsChat.Settings.WindowPosY:GetName(), 0, scrh, 0)
	if VertPosSlide.Label then
		VertPosSlide.Label:SetWrap(true)
	end
	VertPosSlide.OnValueChanged = function( s,data ) HatsChat:DoWindowPos( {ypos = data} ) end
	VertPosSlide:SetTooltip( "Chatbox Position" )
	
	RightAlignBox = set:CheckBox( "Align to Right", HatsChat.Settings.WindowAlignX:GetName() )
	RightAlignBox.OnChange = function( s,data )
		HatsChat:DoWindowPos( {xalign = data} )
		if IsValid(HoriPosSlide) then
			local val = s.PrevValue or HoriPosSlide:GetValue()
			if data~=s.PrevData then --Called twice, for some reason
				s.PrevValue = HoriPosSlide:GetValue()
				s.PrevData = data
			end
			if data then
				HoriPosSlide:SetMin( HatsChat.Settings.WindowSizeX:GetInt() )
				HoriPosSlide:SetMax( scrw )
			else
				HoriPosSlide:SetMax( scrw-HatsChat.Settings.WindowSizeX:GetInt() )
				HoriPosSlide:SetMin( 0 )
			end
			HoriPosSlide:SetValue( math.Clamp(val or HoriPosSlide:GetValue(), HoriPosSlide:GetMin(), HoriPosSlide:GetMax()) )
		end
	end
	
	HoriPosSlide = set:NumSlider( "Horizontal Position", HatsChat.Settings.WindowPosX:GetName(), 0, scrw, 0)
	if HoriPosSlide.Label then
		HoriPosSlide.Label:SetWrap(true)
	end
	HoriPosSlide.OnValueChanged = function( s,data )
		HatsChat:DoWindowPos( {xpos = data} )
	end
	HoriPosSlide:SetTooltip( "Chatbox Position" )
	
	WindHighSlide = set:NumSlider( "Window Height", HatsChat.Settings.WindowSizeY:GetName(), 0, scrh, 0)
	if WindHighSlide.Label then
		WindHighSlide.Label:SetWrap(true)
	end
	WindHighSlide.OnValueChanged = function( s,data )
		HatsChat:DoWindowPos( {high = data} )
		if IsValid(VertPosSlide) then
			if HatsChat.Settings.WindowAlignY:GetBool() then
				VertPosSlide:SetMin( s:GetValue() )
				VertPosSlide:SetMax( scrh )
				if VertPosSlide:GetValue()<VertPosSlide:GetMin() then
					VertPosSlide:SetValue( VertPosSlide:GetMin() )
				elseif VertPosSlide:GetValue()>VertPosSlide:GetMax() then
					VertPosSlide:SetValue( VertPosSlide:GetMax() )
				end
			else
				VertPosSlide:SetMax( scrh-s:GetValue() )
				VertPosSlide:SetMin( 0 )
				if VertPosSlide:GetValue()<VertPosSlide:GetMin() then
					VertPosSlide:SetValue( VertPosSlide:GetMin() )
				elseif VertPosSlide:GetValue()>VertPosSlide:GetMax() then
					VertPosSlide:SetValue( VertPosSlide:GetMax() )
				end
			end
		end
	end
	WindHighSlide:SetTooltip( "Chatbox Height" )
	
	WindWideSlide = set:NumSlider( "Window Width", HatsChat.Settings.WindowSizeX:GetName(), 0, scrw, 0)
	if WindWideSlide.Label then
		WindWideSlide.Label:SetWrap(true)
	end
	WindWideSlide.OnValueChanged = function( s,data )
		HatsChat:DoWindowPos( {wide = data} )
		if IsValid(HoriPosSlide) then
			if HatsChat.Settings.WindowAlignX:GetBool() then
				HoriPosSlide:SetMin( s:GetValue() )
				HoriPosSlide:SetMax( scrw )
				if HoriPosSlide:GetValue()<HoriPosSlide:GetMin() then
					HoriPosSlide:SetValue( HoriPosSlide:GetMin() )
				elseif HoriPosSlide:GetValue()>HoriPosSlide:GetMax() then
					HoriPosSlide:SetValue( HoriPosSlide:GetMax() )
				end
			else
				HoriPosSlide:SetMax( scrw-s:GetValue() )
				HoriPosSlide:SetMin( 0 )
				if HoriPosSlide:GetValue()<HoriPosSlide:GetMin() then
					HoriPosSlide:SetValue( HoriPosSlide:GetMin() )
				elseif HoriPosSlide:GetValue()>HoriPosSlide:GetMax() then
					HoriPosSlide:SetValue( HoriPosSlide:GetMax() )
				end
			end
		end
	end
	WindWideSlide:SetTooltip( "Chatbox Width" )
	
	SettingsFrame:AddItem( set )
	
	--Themes
	--______
	local set = vgui.Create("DForm", SettingsFrame)
	set:SetName( "Chatbox Theme" )
	
	pnl = vgui.Create( "DComboBox", set )
	pnl:Dock( TOP )
	local choice = HatsChat.Settings.ChatTheme:GetString()
	for i=1,#self.ThemeList do
		local nm = self.ThemeList[i]
		pnl:AddChoice( nm, nm, (choice==nm) )
	end
	pnl.OnSelect = function( s,index,val,data )
		RunConsoleCommand( HatsChat.Settings.ChatTheme:GetName(), data )
		HatsChat:SelectTheme( data )
	end
	set:AddItem( pnl )
	
	SettingsFrame:AddItem( set )
	
	--Received Messages Settings
	--__________________________
	local set = vgui.Create("DForm", SettingsFrame)
	set:SetName( "Chat Text Settings" )
	
	pnl = vgui.Create( "DComboBox", set )
	pnl:Dock( TOP )
	local choice = HatsChat.Settings.ChatTextFont:GetString()
	for i=1,#self.FontData do
		local nm = self.FontData[i].name or self.FontData[i].font
		pnl:AddChoice( nm, nm, (choice==nm) )
	end
	pnl.OnSelect = function( s,index,val,data )
		RunConsoleCommand( HatsChat.Settings.ChatTextFont:GetName(), data )
		HatsChat:RefreshLines( {font=data} )
	end
	set:AddItem( pnl )
	
	pnl = set:NumSlider( "Font Size", HatsChat.Settings.ChatTextSize:GetName(), 16, 128, 0)
	if pnl.Label then
		pnl.Label:SetWrap(true)
	end
	pnl.OnValueChanged = function( s,data )
		RunConsoleCommand( HatsChat.Settings.ChatTextSize:GetName(), data )
		
		local ovr = {size=data}
		for _,v in pairs( HatsChat.FontData ) do HatsChat.FormatFont( v, ovr ) end
		
		HatsChat:RefreshLines()
	end
	pnl:SetTooltip( "Font size" )
	
	pnl = set:NumSlider( "Fade time", HatsChat.Settings.ChatFadeTime:GetName(), 1, 120, 0)
	if pnl.Label then
		pnl.Label:SetWrap(true)
	end
	
	SettingsFrame:AddItem( set )
	
	--Misc
	--____
	local set = vgui.Create("DForm", SettingsFrame)
	set:SetName( "Misc Settings" )
	
	pnl = set:NumSlider( "Fade Time", HatsChat.Settings.WindowFadeTime:GetName(), 0, 5, 2)
	if pnl.Label then pnl.Label:SetWrap(true) end
	
	set:CheckBox( "Show chatbox in Screenshots", HatsChat.Settings.ShowInScreenshots:GetName() )
	
	SettingsFrame:AddItem( set )
end
function HatsChat:OpenOptions()
	if not IsValid( self.Window ) then return end
	if IsValid( self.OptionsWindow ) then self.OptionsWindow:Remove() end
	
	self:Show()
	
	self.Window.TextEntry:SetEnabled( false )
	
	self.OptionsWindow = vgui.Create( "DFrame" )
	local ow = self.OptionsWindow
	ow:SetSize( 400, 500 )
	ow:SetPos( ScrW()/2-200, ScrH()/2-250 )
	ow:SetDeleteOnClose( true )
	ow:SetTitle( "HatsChat2 Settings" )
	ow.OnClose = function(s)
		self.Window.TextEntry:SetEnabled( true )
		self:RefreshLines()
		self:Hide()
		s:Remove()
	end
	ow.Think = function(s) --OnFocusChanged only refreshes focus once
		if not s:HasFocus() then s:MakePopup() end
	end
	ow:MakePopup()
	
	local ButtonsFrame = vgui.Create( "DPanel", ow )
	ButtonsFrame:SetSize( 500, 20 )
	ButtonsFrame:Dock( BOTTOM )
	ButtonsFrame.Paint = function() end
	
	local ResetButton = vgui.Create( "DButton", ButtonsFrame )
	ResetButton:Dock( FILL )
	ResetButton:SetText( "Reset to Default" )
	ResetButton.DoClick = function( s )
		ow:Close()
		self:ResetSettings()
	end
	
	if LocalPlayer():IsSuperAdmin() then
		ResetButton:Dock( RIGHT )
		ResetButton:SetWide( 190 )
		
		local SetButton = vgui.Create( "DButton", ButtonsFrame )
		SetButton:SetWide( 190 )
		SetButton:Dock( LEFT )
		SetButton:SetText( "Copy as Default Table" )
		SetButton.DoClick = function( s )
			local str = [[local DefaultFont = "]].. HatsChat.Settings.ChatTextFont:GetString() ..[["

local DefaultValues = {
	XAlign = ]].. HatsChat.Settings.WindowAlignX:GetString() ..[[, YAlign = ]].. HatsChat.Settings.WindowAlignY:GetString() ..[[,
	PosX = ]].. HatsChat.Settings.WindowPosX:GetString() ..[[, PosY = ]].. HatsChat.Settings.WindowPosY:GetString() ..[[,
	Wide = ]].. HatsChat.Settings.WindowSizeX:GetString() ..[[, Tall = ]].. HatsChat.Settings.WindowSizeY:GetString() ..[[,
	TextFont = DefaultFont, TextSize = ]].. HatsChat.Settings.ChatTextSize:GetString() ..[[, TextFade = ]].. HatsChat.Settings.ChatFadeTime:GetString() ..[[,
	Theme = "]].. HatsChat.Settings.ChatTheme:GetString() ..[[", FadeTime = ]].. HatsChat.Settings.WindowFadeTime:GetString() ..[[,
}]]
			SetClipboardText( str )
			chat.AddText( "Clipboard set. Replace the table in cl-init.lua to update your default values." )
		end
	end
	
	local SettingsFrame = vgui.Create( "DPanelList", ow )
	SettingsFrame:EnableVerticalScrollbar(true)
	SettingsFrame:Dock( FILL )
	SettingsFrame:SetPadding(10)
	SettingsFrame:SetSpacing(10)
	
	self:PopulateOptions( SettingsFrame )
end
concommand.Add( "hatschat_settings", function() HatsChat:OpenOptions() end )


hook.Add( "TTTSettingsTabs", "HatsChat OptionsMenu TTTSettings", function( dtabs )
	local dsettings = vgui.Create("DPanelList", dtabs)
	dsettings:StretchToParent(0,0,dtabs:GetPadding()*2,0)
	dsettings:EnableVerticalScrollbar(true)
	dsettings:SetPadding(10)
	dsettings:SetSpacing(10)
	
	HatsChat:PopulateOptions( dsettings )
	
	dtabs:AddSheet("HatsChat2 Settings", dsettings, "icon16/wrench.png", false, false, "Client Chatbox settings")
end)

--[[
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
--]]