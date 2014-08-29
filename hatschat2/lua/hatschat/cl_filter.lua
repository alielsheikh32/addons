------------------------------------
-------------HatsChat 2-------------
------------------------------------
--Copyright (c) 2013 my_hat_stinks--
------------------------------------

HatsChat.ChatFilter = {}
local CF = HatsChat.ChatFilter

local function IgnoreFilter(ply)
	return false--(not IsValid(ply)) or ply:IsSuperAdmin()
end

CF.Enabled = false
CF.Filters = {
	["fuck"] = "fudge", ["fucker"] = "fudger", ["fucking"] = "fudging",
	["shit"] = "poop",
	["arse"] = "bottom",
	["bollocks"] = "********",
	["bollox"] = "******",
	["damn"] = "darn",
	
	["fag"] = "doo-doo head", ["faggot"] = "doo-doo head", ["fags"] = "doo-doo heads", ["faggots"] = "doo-doo heads", 
	["dyke"] = "puppet-ears", ["dykes"] = "puppet-ears",
	["nigger"] = "******", ["niggers"] = "*******",
	["nigga"] = "butthead", ["niggas"] = "buttheads",
	["niglet"] = "dummy", ["niglets"] = "dummies",
	["bastard"] = "fart-face", ["bastards"] = "fart-faces",
	["douche"] = "dumbhead", ["douches"] = "dumbheads",
	["skank"] = "fecal-features", ["skanks"] = "fecal-features",
	["slut"] = "silly", ["sluts"] = "sillies",
	["whore"] = "poo-brain", ["whore"] = "poo-brains",
	
	["cunt"] = "girly parts", ["cunts"] = "girly parts",
	["clit"] = "girly parts",
	["dick"] = "weiner", ["dicks"] = "weiner",
	["cum"] = "***",
	["jizz"] = "****", ["jizzed"] = "******",
	["dildo"] = "toy", ["dildos"] = "toys",
	["wank"] = "****", ["wanker"] = "******",
	
	["tit"] = "birdie", ["tits"] = "birdies",
	["ass"] = "donkey", ["asses"] = "donkies",
	["bitch"] = "puppy", ["bitches"] = "puppies",
	["pussy"] = "kitty", ["pussies"] = "kitties", ["pussys"] = "kitties",
	["cock"] = "rooster", ["cocks"] = "roosters",
}

function CF.RunFilter( ply, str )
	if not CF.Enabled then return str end
	if IgnoreFilter(ply) then return str end
	
	local exp = string.Explode( " ", str )
	for i=1,#exp do
		local gsub = string.gsub( exp[i], "%p", "" ):lower()
		if CF.Filters[ gsub ] then
			local StartPos,EndPos = string.find( exp[i]:lower(), gsub, 0, true )
			if StartPos and EndPos then
				exp[i] = exp[i]:sub(0,StartPos-1) ..CF.Filters[ gsub ].. exp[i]:sub(EndPos+1,-1)
			else
				--There's something like sh.it here, find it
				local pattern = table.concat( string.ToTable( gsub ), "[%p]*" )
				local StartPos,EndPos = string.find( exp[i]:lower(), pattern )
				if StartPos and EndPos then exp[i] = exp[i]:sub(0,StartPos-1) ..CF.Filters[ gsub ].. exp[i]:sub(EndPos+1,-1) end
			end
		end
	end
	
	return table.concat( exp, " " )
end

local PirateDay = (os.date( "%m%d" )=="0919") --International Talk like a pirate day!
if PirateDay then
	if not CF.Enabled then table.Empty( CF.Filters ) end
	CF.Enabled = true
	IgnoreFilter = function() return false end
	
	table.Merge( CF.Filters, {
		["hi"] = "Ahoy", ["hello"] = "Ahoy",
		["yes"] = "yarr", ["no"] = "narr", ["yeah"] = "aye", ["of course"] = "aye aye",
		
		["fag"] = "bilge rat", ["dyke"] = "bilge rat", ["nigger"] = "bilge rat", ["nigga"] = "bilge rat", ["niglet"] = "bilge rat", ["bastard"] = "bilge rat", ["douche"] = "bilge rat", ["skank"] = "bilge rat", ["slut"] = "bilge rat", ["whore"] = "bilge rat",
		
		["wow"] = "shiver me timbers", ["wtf"] = "blimey",
		["treasure"] = "booty", ["money"] = "booty", ["friend"] = "matey", ["friends"] = "mateys", ["ally"] = "bucko", ["allies"] = "buckos",
		["lookout"] = "crow's nest", ["knife"] = "cutlass",
		
		["good luck"] = "fair winds", ["whip"] = "flog", ["beer"] = "grog", ["alcohol"] = "grog", ["food"] = "grub",
		["hideout"] = "haven", ["home"] = "haven",
		["cheat"] = "hornswaggle", ["cheater"] = "hornswaggler", ["cheating"] = "hornswaggling", ["hack"] = "hornswaggle", ["hacker"] = "hornswaggler", ["hacking"] = "hornswaggling",
		["girl"] = "lass", ["boy"] = "lad", ["abandon"] = "maroon",
		["rebel"] = "mutiny", ["rebels"] = "mutineers", ["steal"] = "plunder",
		["left"] = "port", ["right"] = "starboard", ["back"] = "aft", ["front"] = "prow",
		["song"] = "shanty", ["drunk"] = "three sheets in the wind",
		["you"] = "ye", ["your"] = "yer", ["you're"] = "yer", ["youre"] = "yer"
	})
end