------------------------------------
-------------HatsChat 2-------------
------------------------------------
--Copyright (c) 2013 my_hat_stinks--
------------------------------------

HatsChat.ChatTags = {}
local CT = HatsChat.ChatTags

CT.Enabled = true
CT.Tags = {
	["superadmin"] = {Color(0, 170, 170), "[Owner]"},
	--["coowner"] = {Color(90,50,150), "[Co-Owner]"},
	
	--["headadmin"] = {Color(180,50,50), "[Head Admin]"},
	
	--["sadmin"] = {Color(180,50,100), "[S-Admin]"},
	--["superadmin"] = {Color(180,50,100), "[S-Admin]"},
--	["superadmin"] = { {r=180,g=50,b=100,a=255, Glow=true, GlowTarget=Color(255,255,0)}, "[S-Admin]"},
	
	["admin"] = {Color(200, 0, 0), "[Admin]"},
	["moderator"] = {Color(0, 0, 170), "[Moderator]"},
	["respected"] = {Color(50,200,180), "[Respected]"},
	["user"] = {Color(0, 255, 0), "[User]"},
	["trialmod"] = {Color(0, 0, 170), "[Trial Mod]"},
	["dmod"] = {Color(0, 0, 170), "[Donor Mod]"},
	["dadmin"] = {Color(200, 0, 0), "[Donor Admin]"},
	["management"] = {Color(100, 0, 100), "[Management]"},
	["supporter"] = {Color(170, 170, 0), "[Supporter]"},
	["vip"] = {Color(170, 170, 0), "[VIP]"},
}

function CT.GetTag( ply )
	if not CT.Enabled then return end
	if not IsValid(ply) then return end
	
	if wyozite then --Wyozi Tag Editor support
		local str = ply:GetNWString("wte_sbtstr")
		local col = ply:GetNWVector("wte_sbtclr", Vector(-1,-1,-1))
		if (not col) or col[1]<0 or col[2]<0 or col[3]<0 then
			col = ply:GetNWVector("wte_sbclr", Vector(-1,-1,-1))
			if col[1]<0 or col[2]<0 or col[3]<0 then col = nil end
		end
		if col and str and #str>0 then
			local glow = ply:GetNWVector("wte_sbtclr2")
			if col==Vector(255,255,255) and glow==Vector(255,255,255) then
				return {
					HatsChat.ChatCol["[rainbow2]"] or HatsChat.ChatCol["[rainbow]"],
					"["..str.."]"
				}
			else
				return {
					{r=col[1], g=col[2], b=col[3], a=255, Glow = glow~=Vector(0,0,0), GlowTarget = glow},
					"["..str.."]"
				}
			end
		end
	end
	
	local rank = HatsChat.GetPlayerRank(ply)
	return CT.Tags[ string.lower(rank) ]
end