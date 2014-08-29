------------------------------------
-------------HatsChat 2-------------
------------------------------------
--Copyright (c) 2013 my_hat_stinks--
------------------------------------

HatsChat = HatsChat or {} --Autorefresh goes weird without the "HatsChat or"
HatsChat.GetPlayerRank = function(ply)
	return string.lower((exsto and ply.GetRank and ply:GetRank()) or --Exsto
		(ply.EV_GetRank and ply:EV_GetRank()) or --Evolve
		(ply.GetUserGroup and ply:GetUserGroup()) or --ULX
		"" --Failed
	)
end

--Editable Vars--
-----------------
--Every variable must keep the same format when you edit it--

--Restrictions
--------------
local DonatorRank = {
	--Chances are I've missed some, add your own donators ranks here. Remember it already runs through a ply:IsAdmin() check too
	["vip"] = true, ["dmod"] = true, ["respected"] = true, ["dadmin"] = true, ["owner"] = true,
	["moderator"] = true, ["moderator"] = true, ["admin"] = true, ["coder"] = true, ["management"] = true,
	["user"] = true, ["trial mod"] = true, ["supporter"] = true, ["donor"] = true,
}
local function AdminOnly(ply) return IsValid(ply) and ply:IsAdmin() end --Just an example. Remember, this is client side!
local function DonatorOnly(ply) return IsValid(ply) and (ply:IsAdmin() or DonatorRank[HatsChat.GetPlayerRank(ply)]) end

--Line Icons
------------
HatsChat.LineIcon = {
	--Add your rank icon stuff here
	["vip"] = "materials/icon16/coins.png",
	["respected"] = "materials/icon16/coins_add.png",
		["supporter"] = "materials/icon16/heart.png",
			["dmod"] = "materials/icon16/award_star_silver_3.png",
				["dadmin"] = "materials/icon16/award_star_gold_3.png",
				["moderator"] = "materials/icon16/shield.png",
				["management"] = "materials/icon16/rosette.png",--An example
	
	--Add specific SteamIDs in this format for single-player icons
	["STEAM_0:0:0"] = "materials/icon16/shield.png",
	--Example for multiple icons (Experimental)
	["STEAM_0:0:0"] = {"materials/icon16/heart.png","materials/icon16/shield_add.png"},
	--Example for using steam avatars
	["STEAM_0:0:0"] = "AVATAR", --It's not case sensitive
	
	
	--Defaults
	--These are used if the rank check fails, or if there's no icon for the rank
	["DefaultSuperAdmin"] = "materials/icon16/shield_add.png",
	["DefaultAdmin"] = "materials/icon16/shield.png",
	["DefaultUser"] = "materials/icon16/user.png", --Remove this line if you don't want standard users to have line icons
	
	Global = "materials/icon16/world.png", --This icon is used for global messages, not player lines
}

--Name glows
------------
HatsChat.SuperAdminGlow = false --Runs a ply:IsSuperAdmin() check, not rank sepcific
HatsChat.NameGlow = { --Names glow colours
	["superadmin"] = Color(0, 170, 170), --Standard glow, goes white
	["management"] = Color(100, 0, 100),
["admin"] = Color(200, 0, 0),
["moderator"] = Color(0, 0, 170),	--Glows black
}


--Chat Colors
-------------
HatsChat.ChatCol = {
--	["[red]"] = Color(255,0,0,255),
--	["[green]"] = Color(0,255,0,255),
--	["[blue]"] = Color(0,0,255,255),
--	["[black]"] = Color(0,0,0,255),
--	["[white]"] = Color(255,255,255,255),
	
--	["[pink]"] = Color(255,0,255,255),
--	["[teal]"] = Color(0,255,255,255),
---	["[yellow]"] = Color(255,255,0),
	
	--Minecraft colours
--	["%0"] = Color(0,0,0), 		["§0"] = Color(0,0,0), --Random escape character, the string is actually �0
--	["%1"] = Color(0,0,170), 	["§1"] = Color(0,0,170),
--	["%2"] = Color(0,170,0),	["§2"] = Color(0,170,0),
--	["%3"] = Color(0,170,170),	["§3"] = Color(0,170,170),
--	["%4"] = Color(170,0,0),	["§4"] = Color(170,0,0),
--	["%5"] = Color(170,0,170),	["§5"] = Color(170,0,170),
--	["%6"] = Color(255,170,0),	["§6"] = Color(255,170,0),
--	["%7"] = Color(170,170,170),["§7"] = Color(170,170,170),
--	["%8"] = Color(85,85,85),	["§8"] = Color(85,85,85),
--	["%9"] = Color(85,85,255),	["§9"] = Color(85,85,255),
--	["%a"] = Color(85,255,85),	["§a"] = Color(85,255,85),
--	["%b"] = Color(85,255,255),	["§b"] = Color(85,255,255),
--	["%c"] = Color(255,85,85),	["§c"] = Color(255,85,85),
---	["%d"] = Color(255,85,255),	["§d"] = Color(255,85,255),
--	["%e"] = Color(255,255,85),	["§e"] = Color(255,255,85),
--	["%f"] = Color(255,255,255),["§f"] = Color(255,255,255),
	
	["[gray]"] = {r=150,g=150,b=150,a=255, restriction=AdminOnly}, --Restrictions are written out completely differently from normal
	
	["[gold]"] = {r=255,g=210,b=50,a=255, restriction=AdminOnly, Glow=true}, --Example for glows
	["[rainbow]"] = {r=255,g=0,b=0,a=255, restriction=AdminOnly}, --Just for fun
	["[rainbow2]"] = {r=255,g=0,b=0,a=255, restriction=AdminOnly}, --Using WTE's method
}

--Emotes
--------
HatsChat.Emote = {
	{text=":tux:", icon="materials/icon16/tux.png"},
	{text=":usr:", icon="materials/icon16/user.png"},
	{text=":bomb:", icon="materials/icon16/bomb.png"},
	{text=":box:", icon="materials/icon16/box.png"},
	{text=":cake:", icon="materials/icon16/cake.png"},
	{text=":clock:", icon="materials/icon16/clock.png"},
	
	{text=":money:", icon="materials/icon16/money.png"},
	{text=":$:", icon="materials/icon16/money_dollar.png"}, --Other currency symbols don't seem to work
	{text=":S:", icon="materials/icon16/money_dollar.png"},
	{text=":E:", icon="materials/icon16/money_euro.png"},
	{text=":Y:", icon="materials/icon16/money_yen.png"},
	
	{text="<--", icon="materials/icon16/arrow_left.png"},
	{text="-->", icon="materials/icon16/arrow_right.png"},
	{text=":up:", icon="materials/icon16/arrow_up.png"},
	{text=":dn:", icon="materials/icon16/arrow_down.png"},
	
	{text=":coins:", icon="materials/icon16/user_suit.png", restricted=DonatorOnly},
	{text=":suit:", icon="materials/icon16/house.png", restricted=DonatorOnly},
	{text=":!:", icon="materials/icon16/error.png", restricted=DonatorOnly},
	{text=":date:", icon="materials/icon16/date.png", restricted=DonatorOnly},
	{text=":door:", icon="materials/icon16/door.png", restricted=DonatorOnly},
	{text=":home:", icon="materials/icon16/house.png", restricted=DonatorOnly},
	{text=":cup:", icon="materials/icon16/cup.png", restricted=DonatorOnly},
	
	{text="<3", icon="materials/icon16/heart.png", restricted=DonatorOnly},
	{text=":?:", icon="materials/icon16/help.png", restricted=DonatorOnly},
	
	{text=":)", icon="materials/icon16/emoticon_smile.png"},
	{text=">:D", icon="materials/icon16/emoticon_evilgrin.png"},
	{text=":D", icon="materials/icon16/emoticon_grin.png"},
	{text=":(", icon="materials/icon16/emoticon_unhappy.png"},
	{text=";)", icon="materials/icon16/emoticon_wink.png"},
	{text=":3", icon="materials/icon16/emoticon_waii.png"},
	{text=":o", icon="materials/icon16/emoticon_surprised.png"},
	{text=":P", icon="materials/icon16/emoticon_tongue.png"},
	
	{text=":shield:", icon="materials/icon16/shield.png", restricted=AdminOnly},
}

--Fonts
-------
--*NOTE* Autmatic fastdl scripts might not add fonts!
HatsChat.FontData = { --Fonts for chatbox output
	--ManualShadow draws via lua, looks a lot sharper. Without it, most fonts are unusable
	--You can use standard shadows if you wish
	{name = "HatsChatText", font = "Arial", size = 18, weight = 800, ManualShadow = true, outline = false, antialias = false},
	{name = "HatsChatPrompt", font = "Arial", size = 15, ManualShadow = true}, --Used in the chatbox prompt
	{name = "Coolvetica", font = "Coolvetica", weight = 500, ManualShadow = true},
	
	{name = "Roboto", font = "Roboto Bk", weight = 500, ManualShadow = true},
	
	{name = "Reactor Sans", filename = "resource/fonts/Reactor-Sans.ttf", font = "Reactor Sans", ManualShadow = true}, --filename arg is for custom fonts
	{name = "Pricedown", filename = "resource/fonts/pricedown bl.ttf", font = "pricedown bl", ManualShadow = true},
	{name = "Steelfish", filename = "resource/fonts/steelfish rg.ttf", font = "steelfish rg", ManualShadow = true},
	{name = "Liberation Sans", filename = "resource/fonts/LiberationSans-Regular.ttf", font = "Liberation Sans", ManualShadow = true},
	{name = "Monofur", filename = "resource/fonts/monof55.ttf", font = "monofur", ManualShadow = true},
	{name = "Philosopher", filename = "resource/fonts/Philosopher-Regular.ttf", font = "Philosopher", ManualShadow = true},
}

-----------------------------------------
-------DO NOT EDIT below this line-------
-----------------------------------------
--Editting anything below here may cause instability in the addon

if CLIENT then --For Rainbows!
	local status, inv = 0
	hook.Add( "Think", "HatsChat ChatCol ModifyColours", function()
		local rbow = HatsChat.ChatCol["[rainbow]"]
		local mod = inv and 255-((math.sin( CurTime()*2 )+1) * 127.5) or ((math.sin( CurTime()*2 )+1) * 127.5)
		if status==0 then
			if mod>240 then status = 1 end
			rbow.r = mod --[[High]] rbow.g = 255-mod --[[Low]] rbow.b = 0  --[[Next]]
		elseif status==1 then
			if mod<20 then status = 2 end
			rbow.r = mod  --[[Low]] rbow.g = 0 --[[Next]] rbow.b = 255-mod --[[High]]
		elseif status==2 then
			if mod>240 then status = 3 end
			rbow.r = 0 --[[Next]] rbow.g = mod --[[High]] rbow.b = 255-mod --[[Low]]
		elseif status==3 then
			if mod<20 then status = 1 inv=not inv end
			rbow.r = 255-mod --[[High]] rbow.g = mod --[[Low]] rbow.b = 0 --[[Next]]
		end
		
		local rbow2 = HatsChat.ChatCol["[rainbow2]"]
		rbow2.r = 255*math.abs(math.sin(CurTime()))
		rbow2.g = 255*math.abs(math.sin(CurTime()+1.8))
		rbow2.b = 255*math.abs(math.sin(CurTime()+2.6))
	end)
end

for i=1,#HatsChat.ChatCol do
	local tbl = HatsChat.ChatCol[i]
	if type(tbl)=="table" and not (tbl.r and tbl.g and tbl.b) then
		local str, col
		for k,v in pairs(tbl) do
			if type(v)=="string" then
				str = v
			elseif type(v)=="table" and (v.r and v.g and v.b) then
				col = v
			end
		end
		if str and col then
			HatsChat.ChatCol[ str ] = col
			print( "HatsChat.ChatCol badly formatted! Line reformatted to:\t\t[\""..str.."\"] = Color( "..tostring(col.r)..", "..tostring(col.g)..", "..tostring(col.b).."),")
		end
	end
	HatsChat.ChatCol[i] = nil
end
if CLIENT then
	HatsChat.Fonts = {}
	function HatsChat.FormatFont( v, ovr )
		ovr = ovr or {}
		
		local size = HatsChat.Settings and HatsChat.Settings.ChatTextSize or GetConVar("hatschat_text_size")
		size = ovr.size or (size and size:GetInt()) or 16
		local font = surface.CreateFont( v.name or v.font, {
			font = v.font,
			size = math.Clamp(v.size or size,10,200), --Font size overrides settings size
			weight = v.weight or 600,
			blursize = v.blursize or 0,
			scanlines = v.scanlines or 0,
			antialias = v.antialias or true,
			underline = v.underline or false,
			italic = v.italic or false,
			strikeout = v.strikeout or false,
			symbol = v.symbol or false,
			rotary = v.rotary or false,
			shadow = v.shadow or false,
			additive = v.additive or false,
			outline = v.outline or false
		})
		HatsChat.Fonts[ v.name or v.font ] = {ManualShadow = v.ManualShadow}
	end
	
	for _,v in pairs( HatsChat.FontData ) do HatsChat.FormatFont( v ) end --Format fonts
	for _,v in pairs( HatsChat.Emote ) do v.text = string.lower( v.text ) end --Format emotes
	for k,v in pairs( HatsChat.ChatCol ) do --Format colours
		local str = string.lower( k )
		if str~=k then
			HatsChat.ChatCol[k] = nil
			HatsChat.ChatCol[str] = v
		end
		v.ColorPersists = true
	end
	hook.Add( "InitPostEntity", "HatsChat2 TextSize Init", function() --Re-size and refresh fonts
		for _,v in pairs( HatsChat.FontData ) do HatsChat.FormatFont( v ) HatsChat:RefreshLines() end
	end)
else
	for _,v in pairs( HatsChat.FontData ) do if v.filename then resource.AddFile( v.filename ) end end --Add font files
	for _,v in pairs( HatsChat.Emote ) do if v.icon then resource.AddFile( v.icon ) end end --Add emote materials
	for _,v in pairs( HatsChat.LineIcon ) do if v then
		if type(v)=="table" then
			for i=1,#v do resource.AddFile(v[i]) end
		else resource.AddFile( v ) end
	end end --Add icon materials
end

if SERVER then
	util.AddNetworkString( "HatsChatIsTyping" )
	net.Receive( "HatsChatIsTyping", function( len, ply )
		if not IsValid(ply) then return end
		local Typing = tobool(net.ReadBit())
		ply:SetNWBool("HatsChat_IsTyping", Typing)
	end)
end
local PLAYER = FindMetaTable( "Player" )
if PLAYER then
	function PLAYER:IsTyping()
		if LocalPlayer and self==LocalPlayer() then
			return HatsChat.Visible --More reliable
		end
		if not IsValid(self) then return false end
		return self:GetNWBool( "HatsChat_IsTyping", false )
	end
end

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile( "hatschat/cl_init.lua" )
	AddCSLuaFile( "hatschat/cl_options.lua" )
	AddCSLuaFile( "hatschat/cl_serverbar.lua" )
	AddCSLuaFile( "hatschat/cl_filter.lua" )
	
	AddCSLuaFile( "hatschat/sh_themes.lua" )
	AddCSLuaFile( "hatschat/cl_chattags.lua" )
	
	include( "hatschat/sh_themes.lua" )
elseif CLIENT then
	include( "hatschat/cl_init.lua" )
	include( "hatschat/cl_options.lua" )
	include( "hatschat/cl_serverbar.lua" )
	
	include( "hatschat/cl_chattags.lua" )
	include( "hatschat/cl_filter.lua" )
	--Client-side sh_themes.lua is included at the bottom of cl_init.lua (autorefresh fix)
end

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