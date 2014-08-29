/*---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

TEAM_BANKER = DarkRP.createJob("Banker", {
	color = Color(75, 75, 75, 170),
	model = "models/player/kleiner.mdl",
	description = [[Store printers legally. Scamming as a banker is not allowed and if the scamming is done, a punishment will be given.]],
	weapons = {},
	command = "banker",
	max = 50,
	salary = 60,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true
})

TEAM_GUARD = DarkRP.createJob("Guard", {
	color = Color(75, 75, 75, 170),
	model = "models/player/odessa.mdl",
	description = [[Guard shops or players for money.]],
	weapons = { "weapon_mad_glock", "stunstick"},
	command = "guard",
	max = 10,
	salary = 150,
	admin = 0,
	vote = true,
	hasLicense = true,
	candemote = true
})

TEAM_ADMIN = DarkRP.createJob("Admin On Duty", {
	color = Color(255, 0, 0, 170),
	model = {
		"models/player/mnu_assault.mdl",
		"models/player/mnu_medic.mdl",
		"models/player/mnu_soldier.mdl"
	},
	description = [[Administrator on duty]],
	weapons = {"arrest_stick", "stunstick", "door_ram", "weaponchecker",  "unarrest_stick", "fire_extinguisher"},
	command = "admin",
	max = 0,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
    customCheck = function(ply) return CLIENT or ply:IsUserGroup("superadmin") or ply:IsUserGroup("admin") end,
	CustomCheckFailMsg = "You need to be a staff member to transform into this class."
})

TEAM_MOD = DarkRP.createJob("Mod On Duty", {
	color = Color(255, 0, 0, 170),
	model = {
		"models/player/mnu_assault.mdl",
		"models/player/mnu_medic.mdl",
		"models/player/mnu_soldier.mdl"
	},
	description = [[Moderator on duty]],
	weapons = {"arrest_stick", "stunstick", "door_ram", "weaponchecker",  "unarrest_stick", "weapon_medkit", "fire_extinguisher"},
	command = "mod",
	max = 0,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
    customCheck = function(ply) return CLIENT or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be a staff member to transform into this class."
})

TEAM_MOD = DarkRP.createJob("Donor-Mod On Duty", {
	color = Color(255, 0, 0, 170),
	model = {
		"models/player/mnu_assault.mdl",
		"models/player/mnu_medic.mdl",
		"models/player/mnu_soldier.mdl"
	},
	description = [[Donor-Moderator on duty]],
	weapons = {"arrest_stick", "stunstick", "door_ram", "weaponchecker",  "unarrest_stick", "weapon_medkit", "weapon_extinguisher"},
	command = "dmod",
	max = 0,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
    customCheck = function(ply) return CLIENT or ply:IsUserGroup("dmod") end,
	CustomCheckFailMsg = "You need to be a donor mod in order to transform into this class."
})

TEAM_HITMAN = DarkRP.createJob("Hitman", {
	color = Color(75, 75, 75, 170),
	model = "models/player/guerilla.mdl",
	description = [[People hire you for their dirty work.]],
	weapons = { "m9k_m24", "weapon_mad_usp", "weapon_mad_tmp"},
	command = "hitman",
	max = 5,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
	customCheck = function(ply) return CLIENT or ply:IsUserGroup("vip") or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be a VIP to transform into this class."
})


TEAM_FPTHIEF = DarkRP.createJob("FREE Pro Thief", {
	color = Color(0, 180, 180, 170),
	model = "models/player/phoenix.mdl",
	description = [[You are a professional thief. You do not make mistakes. You do not fail.]],
	weapons = { "pro_lockpick", "keypad_cracker"},
	command = "fprothief",
	max = 5,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true
})

TEAM_PTHIEF = DarkRP.createJob("Pro Thief", {
	color = Color(180, 180, 180, 170),
	model = "models/player/phoenix.mdl",
	description = [[You are a professional thief. You do not make mistakes. You do not fail.]],
	weapons = { "pro_lockpick", "keypad_cracker"},
	command = "prothief",
	max = 20,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
	customCheck = function(ply) return CLIENT or ply:IsUserGroup("vip") or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be a VIP to transform into this class."
})

TEAM_SECRET = DarkRP.createJob("Secret Service", {
	color = Color(210, 105, 30, 170),
	model = "models/player/combine_soldier.mdl",
	description = [[Your job is to protect the mayor.]],
	weapons = { "weapon_mad_usp", "weapon_mad_mp5", "unarrest_stick"},
	command = "secret",
	max = 10,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("vip") or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be a VIP to transform into this class."
})

TEAM_BLACK = DarkRP.createJob("Black Market", {
	color = Color(75, 75, 75, 170),
	model = "models/player/leet.mdl",
	description = [[You sell better weapons then the average gun dealer.]],
	weapons = { "weapon_mad_usp"},
	command = "black",
	max = 5,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("vip") or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be a VIP to transform into this class."
})

TEAM_HOBOLEADER = DarkRP.createJob("Hobo King", {
	color = Color(80, 45, 0, 170),
	model = "models/player/charple.mdl",
	description = [[Ruler the hobos.]],
	weapons = { "weapon_bugbait"},
	command = "hoboleader",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("vip") or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be a VIP to transform into this class."
})

-----------------
-- Respected Jobs
-----------------

TEAM_SWAT = DarkRP.createJob("Swat", {
	color = Color(75, 75, 75, 170),
	model = "models/player/gasmask.mdl",
	description = [[Protect the city.]],
	weapons = { "m9k_m4a1", "arrest_stick", "stunstick", "door_ram", "weaponchecker", "unarrest_stick"},
	command = "swat",
	max = 50,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be Respected to transform into this class."
})

TEAM_SWATM = DarkRP.createJob("Swat Medic", {
	color = Color(75, 75, 75, 170),
	model = "models/player/gasmask.mdl",
	description = [[Protect the city.]],
	weapons = { "weapon_medkit", "m9k_m4a1", "arrest_stick", "stunstick", "door_ram", "weaponchecker", "unarrest_stick"},
	command = "swatm",
	max = 50,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be Respected to transform into this class."
})

TEAM_SWATS = DarkRP.createJob("Swat Sniper", {
	color = Color(75, 75, 75, 170),
	model = "models/player/gasmask.mdl",
	description = [[Protect the city.]],
	weapons = { "m9k_barret_m82", "arrest_stick", "stunstick", "door_ram", "weaponchecker", "unarrest_stick"},
	command = "swatsniper",
	max = 50,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be Respected to transform into this class."
})

TEAM_SWATC = DarkRP.createJob("Swat Chief", {
	color = Color(75, 75, 75, 170),
	model = "models/player/swat.mdl",
	description = [[Command the SWAT team.]],
	weapons = { "m9k_m4a1", "weapon_mad_xm1014", "weapon_mad_awp", "arrest_stick", "stunstick", "door_ram", "weaponchecker", "unarrest_stick"},
	command = "swatchief",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be Respected to transform into this class."
})

TEAM_RESPECTED = DarkRP.createJob("Respected Citizen", {
	color = Color(0, 0, 150, 170),
	model = {
		"models/player/Group01/Female_01.mdl",
		"models/player/Group01/Female_02.mdl",
		"models/player/Group01/Female_03.mdl",
		"models/player/Group01/Female_04.mdl",
		"models/player/Group01/Female_06.mdl",
		"models/player/group01/male_01.mdl",
		"models/player/Group01/Male_02.mdl",
		"models/player/Group01/male_03.mdl",
		"models/player/Group01/Male_04.mdl",
		"models/player/Group01/Male_05.mdl",
		"models/player/Group01/Male_06.mdl",
		"models/player/Group01/Male_07.mdl",
		"models/player/Group01/Male_08.mdl",
		"models/player/Group01/Male_09.mdl"
	},
	description = [[Upper-Class Citizen]],
	weapons = { "weapon_mad_usp"},
	command = "respected",
	max = 50,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = true,
customCheck = function(ply) return CLIENT or ply:IsUserGroup("respected") or ply:IsUserGroup("supporter") or ply:IsUserGroup("dmod") or ply:IsUserGroup("dadmin") or ply:IsUserGroup("trialmod") or ply:IsUserGroup("moderator") or ply:IsUserGroup("admin") or ply:IsUserGroup("management") or ply:IsUserGroup("superadmin") end,
	CustomCheckFailMsg = "You need to be Respected to transform into this class."
})

-----------------
-- Custom Classes
-----------------

-- Storm's Custom Class
TEAM_STORM = DarkRP.createJob("Storm's Class", {
	color = Color(75, 75, 75, 170),
	model = {
		"models/player/mnu_assault.mdl",
		"models/player/mnu_medic.mdl",
		"models/player/mnu_soldier.mdl"
	},
	description = [[Storm's Custom Class]],
weapons = {"pro_lockpick", "keypad_cracker", "unarrest_stick", "weapon_mad_m249", "weapon_medkit", "weapon_bugbait", "m9k_ex41", "m9k_orbital_strike", "ls_sniper", "m9k_nerve_gas", "m9k_acr", "m9k_ak74", "m9k_scar", "m9k_m4a1", "m9k_val", "fire_molotov", "fire_extinguisher", "weapon_asmd", "m9k_damascus", "m9k_m16a4_acog", "m9k_m416", "m9k_auga3", "m9k_g36", "m9k_winchester73", "m9k_m98b", "m9k_svu", "m9k_remington7615p", "m9k_m24", "ak47_beast", "g36_balrog", "47_ethereal", "m4a1_beast", "tmp_dragon", "scout_xbow", "m4_guitar"},
command = "storm",
	max = 4,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:67130695" or ply:SteamID()=="STEAM_0:1:81635" end,
	CustomCheckFailMsg = "You need to be a fucking god to be this class."
})

-- Steven's Custom Class
TEAM_SOUL = DarkRP.createJob("Intruder", {
	color = Color(83, 232, 227, 170),
	model = "models/player/skeleton.mdl",
	description = [[Steven's Custom Class.]],
	weapons = { "weapon_mad_galil", "weapon_mad_awp", "pro_lockpick", "keypad_cracker", "weapon_medkit", "unarrest_stick", "weapon_mad_ak47", "m9k_ex41", "weapon_mad_knife", "weapon_mad_xm1014", "weapon_mad_ar2", "fire_molotov", "m9k_acr", "m9k_auga3", "stunstick"},
	command = "austin",
	max = 26,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:80416161" or ply:SteamID()=="STEAM_0:1:69530933" or ply:SteamID()=="STEAM_0:1:48667657" or ply:SteamID()=="STEAM_0:1:46483801" or ply:SteamID()=="STEAM_0:1:55828016" or ply:SteamID()=="STEAM_0:0:12478198" or ply:SteamID()=="STEAM_0:0:46369825" or ply:SteamID()=="STEAM_0:1:58944919" or ply:SteamID()=="STEAM_0:1:63455060" or ply:SteamID()=="STEAM_0:0:66671477" or ply:SteamID()=="STEAM_0:0:64132122" or ply:SteamID()=="STEAM_0:1:37797889" or ply:SteamID()=="STEAM_0:0:77929520" or ply:SteamID()=="STEAM_0:1:50747196" or ply:SteamID()=="STEAM_0:1:80904970" or ply:SteamID()=="STEAM_0:1:62389519" or ply:SteamID()=="STEAM_0:0:52719848" or ply:SteamID()=="STEAM_0:0:54442868"  or ply:SteamID()=="STEAM_0:0:79510627" or ply:SteamID()=="STEAM_0:1:84421194" or ply:SteamID()=="STEAM_0:1:85563143" or ply:SteamID()=="STEAM_0:1:85563143" or ply:SteamID()=="STEAM_0:0:20743276" or ply:SteamID()=="STEAM_0:0:56838078" or ply:SteamID()=="STEAM_0:1:66435761" end,
	CustomCheckFailMsg = "You are not the owner of this class"
})

-- Merksession's Custom Class
TEAM_MERK = DarkRP.createJob("Godlike", {
	color = Color(83, 232, 227, 170),
	model = {
		"models/player/mnu_assault.mdl",
		"models/player/mnu_medic.mdl",
		"models/player/Group01/Male_07.mdl",
		"models/player/mnu_soldier.mdl",
		"models/player/Kleiner.mdl",
		"models/player/breen.mdl",
		"models/player/alyx.mdl",
		"models/player/corpse1.mdl"
	},
	description = [[Merksession's Custom Class]],
	weapons = { "weapon_mad_ak47", "pro_lockpick", "keypad_cracker", "weapon_mad_sg552", "weapon_mad_m249", "weapon_mad_knife", "weapon_mad_awp", "unarrest_stick", "weapon_mad_m4", "weapon_mad_p90", "weapon_mad_xm1014"},
	command = "merk",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:54493510" end,
	CustomCheckFailMsg = "You are not the owner of this class"
})

-- [AFA] TouchMyOranges's Custom Class
TEAM_ORANGES = DarkRP.createJob("TouchMyOranges's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/breen.mdl",
	description = [[TouchMyOranges's Custom Class]],
	weapons = { "weapon_mad_m249", "keypad_cracker"},
	command = "oranges",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:49452648" end,
	CustomCheckFailMsg = "You are not the owner of this class"
})

-- Wombat's Custom Class
TEAM_WOMBAT = DarkRP.createJob("Wombat's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/breen.mdl",
	description = [[Wombat's Custom Class]],
	weapons = { "weapon_mad_xm1014", "weapon_mad_knife", "weapon_mad_awp", "weapon_mad_galil", "weapon_mad_m249", "weapon_mad_m4"},
	command = "wombat",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:53350398" end,
	CustomCheckFailMsg = "You are not the owner of this class"
})

-- Pink's Custom Class
TEAM_PINK = DarkRP.createJob("Blind's custom class", {
	color = Color(255, 56, 112, 170),
	model = "models/player/Hostage/hostage_04.mdl",
	description = [[Blind's custom class]],
	weapons = {"ls_sniper", "weapon_mad_rpg", "unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014", "weapon_medkit", "weapon_mad_c4"},
	command = "pink",
	max = 2,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:15399979" or ply:SteamID()=="STEAM_0:0:18157837" end,
	CustomCheckFailMsg = "You are not the owner of this class"
})

-- Tbone's Custom Class
TEAM_TBONE = DarkRP.createJob("Tbone's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/Group03/Male_09.mdl",
	description = [[Tbone's Custom Class]],
	weapons = {"weapon_mad_galil", "weapon_mad_awp", "pro_lockpick", "weapon_mad_knife", "weapon_mad_xm1014",  "weapon_medkit", "weapon_mad_tmp", "weapon_mad_rpg", "m9k_ex41", "m9k_scar", "fire_molotov"},
	command = "tbone",
	max = 4,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:45061007" or ply:SteamID()=="STEAM_0:1:30289498" or ply:SteamID()=="STEAM_0:1:66535282" or ply:SteamID()=="STEAM_0:0:72081079" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Cracker Faps's Custom Class
TEAM_CRACKER = DarkRP.createJob("Cracker Faps's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/ninja/vaas.mdl",
	description = [[Cracker Faps's Custom Class]],
	weapons = {"weapon_mad_ak47", "weapon_mad_xm1014", "weapon_mad_knife",  "weapon_mad_sg550", "weapon_mad_ar2", "unarrest_stick", "pro_lockpick", "m9k_ex41", "weapon_mad_m249", "ls_sniper", "weapon_medkit"},
	command = "cracker",
	max = 2,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:63817571" or ply:SteamID()=="STEAM_0:1:54426047" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Brock's Custom Class
TEAM_BROCK = DarkRP.createJob("The Lost One", {
	color = Color(75, 75, 75, 170),
	model = "models/avengers/iron man/patriot_player.mdl",
	description = [[Brockonix's Custom Class]],
	weapons = {"weapon_mad_deagle", "weapon_mad_tmp", "weapon_mad_famas", "weapon_xm1014", "weapon_mad_awp", "weapon_mad_knife", "pro_lockpick", "pro_keypad_cracker"},
	command = "brock",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:58726613" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Dynamical's Custom Class
TEAM_DYNAMICAL = DarkRP.createJob("Dynamical's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/phoenix.mdl",
	description = [[Dynamical's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014"},
	command = "dynamical",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:50308516" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Grave Kings's Custom Class
TEAM_GRAVEKING = DarkRP.createJob("Grave Kings's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/corvo.mdl",
	description = [[Grave King's Custom Class]],
	weapons = {"weapon_mad_m249", "pro_lockpick", "keypad_cracker", "weapon_mad_knife"},
	command = "graveking",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:49171872" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})
 
-- Neat and Brad's Custom Class
TEAM_SODA = DarkRP.createJob("Mercenary", {
	color = Color(75, 75, 75, 170),
	model = "models/player/kestrel.mdl",
	description = [[Neat & Brad's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014", "weapon_mad_rpg", "weapon_medkit", "m9k_ex41", "ls_sniper", "weapon_mad_c4", "m9k_nerve_gas", "weapon_asmd"},
	command = "soda",
	max = 5,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:54154781" or ply:SteamID()=="STEAM_0:1:61930616" or ply:SteamID()=="STEAM_0:0:56663255" or ply:SteamID()=="STEAM_0:0:54939761" or ply:SteamID()=="STEAM_0:1:30943106" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Juicy J's Custom Class
TEAM_JUICY = DarkRP.createJob("Terrorist", {
	color = Color(205, 0, 255, 170),
	model = {
	"models/code_gs/osama/osamaplayer.mdl",
	"models/player/combine_super_soldier.mdl",
    "models/player/combine_soldier.mdl",
    "models/player/kuma/taliban_rpg.mdl",
    "models/player/kuma/taliban_bomber.mdl",
	"models/player/corvo.mdl"},
	description = [[Juicy J's Custom Class]],
	weapons = {"golden_ak49", "unarrest_stick", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_mp5", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ar2", "weapon_mad_galil", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_rpg", "weapon_medkit", "m9k_ex41", "weapon_mad_c4", "ls_sniper", "m9k_orbital_strike", "m9k_nerve_gas", "fire_molotov", "fire_extinguisher", "stunstick", "m9k_ak47", "weapon_bugbait", "m9k_m16a4_acog", "m9k_famas", "m9k_scar", "m9k_g36", "m9k_damascus", "l96_dragon", "ak47_beast", "m9k_pkm"},
	command = "juicy",
	max = 17,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:71912075" or ply:SteamID()=="STEAM_0:0:83243497" or ply:SteamID()=="STEAM_0:1:27485761" or ply:SteamID()=="STEAM_0:0:73776343" or ply:SteamID()=="STEAM_0:0:60351197" or ply:SteamID()=="STEAM_0:1:69530933" or ply:SteamID()=="STEAM_0:1:46483801" or ply:SteamID()=="STEAM_0:1:78223877" or ply:SteamID()=="STEAM_0:1:80416161" or ply:SteamID()=="STEAM_0:0:64165957" or ply:SteamID()=="STEAM_0:0:42288787" or ply:SteamID()=="STEAM_0:0:62105451" or ply:SteamID()=="STEAM_0:1:33630203" or ply:SteamID()=="STEAM_0:1:70109962" or ply:SteamID()=="STEAM_0:1:57295523" or ply:SteamID()=="STEAM_0:1:73899349" or ply:SteamID()=="STEAM_0:1:19507104" or ply:SteamID()=="STEAM_0:0:66831212" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Coreyys/Cabose700s/Reckless's Custom Class
TEAM_WALRUS = DarkRP.createJob("Spy", {
	color = Color(247, 0, 255, 170),
	model = "models/player/gasmask.mdl",
	description = [[BlackJeebuz's Custom Class]],
	weapons = {"weapon_mad_tmp", "weapon_mad_galil", "weapon_mad_xm1014", "weapon_mad_awp", "unarrest_stick", "pro_lockpick", "keypad_cracker", "weapon_mad_knife", "weapon_medkit"},
	command = "walrus",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:39482987" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Herman's Custom Class
TEAM_HERMAN = DarkRP.createJob("Malevolent Criminal", {
    color = Color(255, 255, 51, 170),
	model = {
	"models/german/ssvolksgrenadier_playermodel.mdl",
	"models/player/corpse1.mdl",
	"models/german/waffen_ss_stormtrooper_playermodel.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/phoenix.mdl"
	},
	description = [[Herman's Custom Class]],
	weapons = {"unarrest_stick", "weapon_mad_usp", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_g3g1", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_medkit", "m9k_ex41", "weapon_mad_c4", "ls_sniper", "weapon_mad_rpg", "m9k_val", "weapon_bugbait", "weapon_asmd", "m9k_orbital_strike", "m9k_damascus", "m9k_pkm", "m9k_barret_m82"},
	command = "herman",
	max = 20,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:26786768" or ply:SteamID()=="STEAM_0:1:1252867" or ply:SteamID()=="STEAM_0:1:42510200" or ply:SteamID()=="STEAM_0:0:22133671" or ply:SteamID()=="STEAM_0:0:39094952" or ply:SteamID()=="STEAM_0:1:52698121" or ply:SteamID()=="STEAM_0:0:62683274" or ply:SteamID()=="STEAM_0:1:50532839" or ply:SteamID()=="STEAM_0:0:36391578" or ply:SteamID()=="STEAM_0:1:62740386" or ply:SteamID()=="STEAM_0:1:23866700" or ply:SteamID()=="STEAM_0:1:71478659" or ply:SteamID()=="STEAM_0:1:52780245" or ply:SteamID()=="STEAM_0:0:50280967" or ply:SteamID()=="STEAM_0:0:53926540" or ply:SteamID()=="STEAM_0:1:57748931" or ply:SteamID()=="STEAM_0:1:73899349"  or ply:SteamID()=="STEAM_0:0:41954123" or ply:SteamID()=="STEAM_0:0:25009758" or ply:SteamID()=="STEAM_0:0:42288787" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- DatOneGuy's Custom Class
TEAM_DAT = DarkRP.createJob("DatOneGuy's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/corpse1.mdl",
	description = [[DatOneGuy's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014"},
	command = "dat",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:71481879" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Scruffy's Custom Class
TEAM_SCRUFFY = DarkRP.createJob("Hobbler", {
	color = Color(75, 75, 75, 170),
	model = "models/player/eli.mdl",
	description = [[Clone Rinx's Custom Class]],
	weapons = {"weapon_medkit", "unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014"},
	command = "icef1ame",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:37797889" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Typuu's Custom Class
TEAM_TYPUU = DarkRP.createJob("Rapist", {
	color = Color(255, 102, 178, 170),
	model = {
		"models/jessev92/player/misc/creepr.mdl",
		"models/player/Hostage/hostage_01.mdl"
	},
	description = [[Typuu's Custom Class]],
	weapons = {"weapon_mad_galil", "pro_lockpick", "keypad_cracker", "weapon_mad_knife", "unarrest_stick", "weapon_medkit", "weapon_mad_xm1014", "weapon_mad_awp", "ls_sniper", "m9k_ex41", "weapon_mad_ak47", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_ar2", "weapon_mad_usp", "weapon_mad_deagle", "weapon_mad_glock", "weapon_mad_m4", "fire_extinguisher", "ak47_beast", "m9k_orbital_strike", "m9k_m416"},
	command = "typuu",
	max = 17,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:30133208" or ply:SteamID()=="STEAM_0:1:70510115" or ply:SteamID()=="STEAM_0:1:73899349" or ply:SteamID()=="STEAM_0:0:36417758" or ply:SteamID()=="STEAM_0:0:68068620" or ply:SteamID()=="STEAM_0:1:28403568" or ply:SteamID()=="STEAM_0:0:54892689" or ply:SteamID()=="STEAM_0:1:38390213" or ply:SteamID()=="STEAM_0:1:63810088" or ply:SteamID()=="STEAM_0:0:35055505" or ply:SteamID()=="STEAM_0:0:22133671" or ply:SteamID()=="STEAM_0:0:46054252" or ply:SteamID()=="STEAM_0:1:40882876" or ply:SteamID()=="STEAM_0:1:55828016" or ply:SteamID()=="STEAM_0:0:69265660" or ply:SteamID()=="STEAM_0:1:65538793" or ply:SteamID()=="STEAM_0:1:40643008" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Mech's Custom Class
TEAM_MECH = DarkRP.createJob("Mechanimus's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = {
	"models/player/archer.mdl",
    "models/player/eli.mdl"},
	description = [[Mechanimus's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014", "ls_sniper", "weapon_mad_rpg", "weapon_mad_c4", "m9k_ex41", "m9k_orbital_strike", "m9k_ak47", "weapon_medkit"},
	command = "mech",
	max = 4,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:40325531" or ply:SteamID()=="STEAM_0:0:67676284" or ply:SteamID()=="STEAM_0:0:25009758" or ply:SteamID()=="STEAM_0:0:49452648" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Mirai's custom classes
TEAM_MIRAI = DarkRP.createJob("Berliano's Iron Class", {
	color = Color(75, 75, 75, 170),
	model = "models/avengers/iron man/patriot_player.mdl",
	description = [[Mirai's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_deagle", "weapon_mad_xm1014", "weapon_mad_m249", "weapon_mad_ak47", "weapon_mad_m4", "weapon_mad_glock", "keypad_cracker", "weapon_mad_knife", "pro_lockpick", "weapon_mad_p90", "weapon_mad_aug", "weapon_mad_awp"},
	command = "mirai",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:56098448" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Kidney's Custom Class
TEAM_KIDNEY = DarkRP.createJob("Kidney #3's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/zombie_classic.mdl",
	description = [[Kidney #3's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump45", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014", "weapon_medkit" },
	command = "kidney",
	max = 14,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:67676284" or ply:SteamID()=="STEAM_0:1:42322252" or ply:SteamID()=="STEAM_0:0:38217396" or ply:SteamID()=="STEAM_0:1:37797889" or ply:SteamID()=="STEAM_0:1:12956620" or ply:SteamID()=="STEAM_0:0:37969722" or ply:SteamID()=="STEAM_0:1:30943106" or ply:SteamID()=="STEAM_0:1:67720356" or ply:SteamID()=="STEAM_0:1:8415530" or ply:SteamID()=="STEAM_0:1:62740386" or ply:SteamID()=="STEAM_0:0:35234073" or ply:SteamID()=="STEAM_0:1:42185782" or ply:SteamID()=="STEAM_0:1:45366972" or ply:SteamID()=="STEAM_0:0:47377553" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Tim's Custom Class
TEAM_TIM = DarkRP.createJob("Tim Pierce's Custom Class", {
	color = Color(0, 75, 0, 170),
	model = "models/player/leet.mdl",
	description = [[Tim Pierce's Custom Class]],
	weapons = {"weapon_mad_ak47", "weapon_mad_galil", "weapon_mad_p90", "pro_lockpick", "weapon_mad_knife", "unarrest_stick", "weapon_medkit", "weapon_mad_awp", "weapon_mad_m3", "keypad_cracker", "weapon_mad_m4", "weapon_mad_ar2", "ls_sniper", "weapon_mad_c4", "m9k_ex41"},
	command = "tim",
	max = 2,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:43132948" or ply:SteamID()=="STEAM_0:0:65448729" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Des's Custom Class
TEAM_DES = DarkRP.createJob("Des's Custom Class", {
	color = Color(75, 75, 75, 170),
	model = "models/player/urban.mdl",
	description = [[Des's Custom Class]],
	weapons = {"weapon_mad_p90", "weapon_mad_galil", "pro_lockpick", "unarrest_stick", "weapon_mad_awp", "weapon_medkit", "keypad_cracker", "weapon_mad_knife", "weapon_mad_usp", "weapon_mad_xm1014", "weapon_mad_deagle"},
	command = "des",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:40983887" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Swag's Custom Class
TEAM_SWAG = DarkRP.createJob("Ninja Demon", {
	color = Color(255, 56, 112, 170),
	model = "models/player/barney.mdl",
	description = [[Wallace Johnson's Custom Class]],
	weapons = {"weapon_mad_ak47", "weapon_mad_p90", "weapon_mad_ar2", "pro_lockpick", "weapon_medkit", "unarrest_stick", "weapon_mad_knife"},
	command = "swag",
	max = 1,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:52698121" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- IceF1ame's Custom Class
TEAM_HAKU = DarkRP.createJob("Assassin", {
	color = Color(75, 75, 75, 170),
	model = "models/player/corvo.mdl",
	description = [[Hato's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_glock", "weapon_mad_deagle", "weapon_mad_usp", "weapon_mad_tmp", "weapon_mad_mp5", "weapon_mad_mac10", "weapon_mad_ump", "weapon_mad_p90", "weapon_mad_m4", "weapon_mad_ak47", "weapon_mad_ar2", "weapon_mad_aug", "weapon_mad_galil", "weapon_mad_famas", "weapon_mad_sg552", "weapon_mad_m3", "weapon_mad_awp", "weapon_mad_scout", "weapon_mad_g3g1", "weapon_mad_sg550", "weapon_mad_m249", "weapon_mad_knife", "pro_lockpick", "keypad_cracker", "weapon_mad_xm1014", "weapon_mad_rpg", "weapon_medkit", "weapon_bugbait", "fire_extinguisher"},
	command = "haku",
	max = 2,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:21640664" or ply:SteamID()=="STEAM_0:1:41860016" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Rigor's Custom Class
TEAM_RIGOR = DarkRP.createJob("Big Baby", {
	color = Color(0, 0, 75, 170),
	model = "models/vinrax/player/doll_player.mdl",
	description = [[Rigor's Custom Class]],
	weapons = {"unarrest_stick",  "weapon_mad_rpg", "weapon_mad_m249", "weapon_mad_awp", "weapon_mad_ak47", "weapon_mad_tmp", "weapon_mad_glock", "pro_lockpick", "keypad_cracker", "weapon_medkit"},
	command = "rigor",
	max = 2,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = true,
	candemote = false,
	customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:8415530" end,
	CustomCheckFailMsg = "You are not the owner of this class."
})

-- Deathzzzzz Custom Class
TEAM_DEATHZ = DarkRP.createJob("FOR SALE CONTACT STORM", {
color = Color(255, 0, 0, 170),
model = "models/player/zombie_classic.mdl",
description = [[FOR SALE CONTACT STORM]],
weapons = { "m9k_acr", "weapon_mad_awp", "weapon_mad_xm1014", "weapon_mad_medic", "weapon_mad_knife", "keypad_cracker", "pro_lockpick"},
command = "deathz",
max = 1,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:50220304" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Ze's Custom Class
TEAM_ZE = DarkRP.createJob("God of the Thieves", {
color = Color(0, 255, 157, 170),
model = "models/player/alyx.mdl",
description = [[Ze's Custom Class]],
weapons = {"weapon_mad_ak47", "weapon_mad_sg550", "pro_lockpick", "keypad_cracker"},
command = "ze",
max = 1,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:26394968" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Not Gabe Newell's Custom Class
TEAM_GABE = DarkRP.createJob("Swag Assassin", {
color = Color(75, 75, 75, 170),
model = "models/nikout/dishonored/assassin1.mdl",
description = [[Not Gabe Newell's Custom Class]],
weapons = {"pro_lockpick", "keypad_cracker", "m9k_ak47", "weapon_medkit", "weapon_mad_knife", "weapon_mad_ump", "weapon_mad_xm1014", "m9k_ex41", "unarrest_stick", "ls_sniper"},
command = "gabe",
max = 10,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:45922874" or ply:SteamID()=="STEAM_0:0:65449127" or ply:SteamID()=="STEAM_0:1:69530933" or ply:SteamID()=="STEAM_0:0:72081079" or ply:SteamID()=="STEAM_0:0:53806138" or ply:SteamID()=="STEAM_0:0:62119256" or ply:SteamID()=="STEAM_0:1:69144742" or ply:SteamID()=="STEAM_0:0:43142019" or ply:SteamID()=="STEAM_0:1:41910570" or ply:SteamID()=="STEAM_0:1:57295523" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Broski's Custom Class
TEAM_BROSKI = DarkRP.createJob("Doctor of Professoring", {
color = Color(75, 75, 75, 170),
model = "models/player/Hostage/hostage_01.mdl",
description = [[Broski's Custom Class]],
weapons = {"weapon_mad_awp", "weapon_medkit", "pro_lockpick", "m9k_m4a1"},
command = "broksi",
max = 1,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:27508423" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- FaceOfBoe's Custom Class
TEAM_FACE = DarkRP.createJob("Bad Mothafucka", {
color = Color(75, 75, 75, 170),
model = "models/player/gman_high.mdl",
description = [[FaceOfBoe's Custom Class]],
weapons = {"weapon_mad_galil", "weapon_mad_tmp", "weapon_mad_deagle", "weapon_medkit", "unarrest_stick", "pro_lockpick", "weapon_mad_awp", "keypad_cracker", "weapon_mad_m4"},
command = "face",
max = 2,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:50280967" or ply:SteamID()=="STEAM_0:1:55868038" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Smite's Custom Class
TEAM_SMITE = DarkRP.createJob("The Almighty", {
color = Color(255, 255, 51, 170),
model = "models/player/leet.mdl",
description = [[Smite's Custom Class]],
weapons = {"pro_lockpick", "keypad_cracker", "weapon_mad_knife", "unarrest_stick", "weapon_mad_ak47", "weapon_mad_p90", "weapon_mad_m249", "weapon_mad_deagle", "weapon_medkit", "weapon_bugbait", "m9k_ex41", "m9k_orbital_strike", "ls_sniper", "m9k_nerve_gas", "m9k_acr", "m9k_ak47", "m9k_ak74", "m9k_scar", "m9k_m4a1", "m9k_val", "weapon_mad_awp", "weapon_mad_galil", "weapon_mad_usp", "fire_molotov", "fire_extinguisher"},
command = "smite",
max = 1,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:30943106" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- ReallyKindGuy's Custom Class
TEAM_REALLY = DarkRP.createJob("ReallyKindGuy's", {
color = Color(75, 75, 75, 170),
model = "models/player/phoenix.mdl",
description = [[ReallyKindGuy's Custom Class]],
weapons = {"weapon_medkit", "unarrest_stick", "weapon_mad_m249", "weapon_mad_awp", "pro_lockpick", "keypad_cracker"},
command = "really",
max = 1,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:50523626" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Magna's Custom Class
TEAM_MAGNA = DarkRP.createJob("Hyuna's Custom Class", {
color = Color(75, 75, 75, 170),
model = "models/player/combine_super_soldier.mdl",
description = [[Hyuna's Custom Class]],
weapons = {"m9k_ex41", "weapon_medkit", "pro_lockpick", "keypad_cracker"},
command = "hyuna",
max = 3,
salary = 200,
admin = 0,
vote = false,
hasLicense = false,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:17823480" or ply:SteamID()=="STEAM_0:0:22449228" or ply:SteamID()=="STEAM_0:0:16142023" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Baezo's Custom Class
TEAM_BAEZO = DarkRP.createJob("God of War", {
color = Color(75, 0, 0, 170),
model = {
		"models/player/techknow/cpt_america/cpt_a.mdl",
		"models/player/anon/anon.mdl"
	},
description = [[Baezo's Custom Class]],
weapons = {"pro_lockpick", "keypad_cracker", "m9k_ares_shrike", "unarrest_stick", "weapon_mad_ak47", "weapon_mad_p90", "weapon_mad_m249", "m9k_pkm", "weapon_medkit", "weapon_bugbait", "m9k_ex41", "m9k_orbital_strike", "ls_sniper", "m9k_nerve_gas", "m9k_acr", "m9k_ak47", "m9k_ak74", "m9k_scar", "m9k_m4a1", "m9k_val", "weapon_mad_awp", "weapon_mad_galil", "weapon_mad_usp", "fire_molotov", "fire_extinguisher", "m9k_damascus", "m9k_m16a4_acog", "m9k_m416", "m9k_auga3", "m9k_g36", "m9k_winchester73", "ak47_beast", "l96_dragon", "m4a1_beast", "m9k_svu", "m9k_aw50", "g36_balrog"},
command = "baezo",
max = 50,
salary = 200,
admin = 0,
vote = false,
hasLicense = true,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:0:44017574" or ply:SteamID()=="STEAM_0:0:59602418" or ply:SteamID()=="STEAM_0:0:25009758" or ply:SteamID()=="STEAM_0:0:67522120" or ply:SteamID()=="STEAM_0:1:84888" or ply:SteamID()=="STEAM_0:0:453707" or ply:SteamID()=="STEAM_0:1:81635" or ply:SteamID()=="STEAM_0:1:67130695" or ply:SteamID()=="STEAM_0:0:41053482" or ply:SteamID()=="STEAM_0:1:29958294" or ply:SteamID()=="STEAM_0:0:34891095" or ply:SteamID()=="STEAM_0:1:53866140" or ply:SteamID()=="STEAM_0:0:43142019" or ply:SteamID()=="STEAM_0:1:48978720" or ply:SteamID()=="STEAM_0:0:53139180" or ply:SteamID()=="STEAM_0:0:36693436" or ply:SteamID()=="STEAM_0:1:40882876" or ply:SteamID()=="STEAM_0:0:72081079" or ply:SteamID()=="STEAM_0:1:71912075" or ply:SteamID()=="STEAM_0:0:44104543" or ply:SteamID()=="STEAM_0:1:68497065" or ply:SteamID()=="STEAM_0:1:73957469" or ply:SteamID()=="STEAM_0:0:38515967" or ply:SteamID()=="STEAM_0:0:68934693" or ply:SteamID()=="STEAM_0:1:84421194" or ply:SteamID()=="STEAM_0:1:39482987" or ply:SteamID()=="STEAM_0:1:50127190" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Marino's Custom Class
TEAM_MARINO = DarkRP.createJob("Knightmare", {
color = Color(75, 75, 75, 170),
model = "models/player/gasmask.mdl",
description = [[Marino's Custom Class]],
weapons = {"m9k_ex41", "m9k_pkm", "weapon_medkit", "pro_lockpick", "unarrest_stick", "weapon_mad_ak47", "weapon_mad_deagle", "weapon_mad_m249", "weapon_mad_xm1014", "keypad_cracker", "m9k_val", "weapon_mad_knife", "weapon_mad_usp", "weapon_mad_awp"},
command = "marino",
max = 18,
salary = 200,
admin = 0,
vote = false,
hasLicense = true,
candemote = false,
customCheck = function(ply) return CLIENT or ply:SteamID()=="STEAM_0:1:77801427" or ply:SteamID()=="STEAM_0:0:45721872" or ply:SteamID()=="STEAM_0:1:46877314" or ply:SteamID()=="STEAM_0:0:33984120" or ply:SteamID()=="STEAM_0:1:38390213" or ply:SteamID()=="STEAM_0:0:68574711" or ply:SteamID()=="STEAM_0:1:55828016" or ply:SteamID()=="STEAM_0:0:62377516"  or ply:SteamID()=="STEAM_0:1:19718283" or ply:SteamID()=="STEAM_0:1:19507104" or ply:SteamID()=="STEAM_0:0:59730520" or ply:SteamID()=="STEAM_0:0:66831212" or ply:SteamID()=="STEAM_0:1:81366839" or ply:SteamID()=="STEAM_0:0:67522120" or ply:SteamID()=="STEAM_0:0:65317899" or ply:SteamID()=="STEAM_0:1:50127190" or ply:SteamID()=="STEAM_0:1:50835092" or ply:SteamID()=="STEAM_0:0:74889496" or ply:SteamID()=="STEAM_0:1:66155680" end,
CustomCheckFailMsg = "You are not the owner of this class."
})

-- Toki's Custom Class
TEAM_TOKI = DarkRP.createJob("Toki's Custom Class", {
color = Color(75, 75, 75, 170),
model = "models/player/combine_super_soldier.mdl",
description = [[Toki's Custom Class]],
weapons = { "weapon_mad_usp", "weapon_mad_m3", "ls_sniper", "weapon_mad_p90", "weapon_mad_ak47", "weapon_mad_knife", "weapon_mad_m249", "pro_lockpick", "keypad_cracker", "weapon_mad_awp", "m9k_nerve_gas", "weapon_medkit", "unarrest_stick", "m9k_val"},
command = "toki",
max = 5,
salary = 200,
admin = 0,
vote = false,
hasLicense = true,
candemote = false,
customCheck = function(ply) return CLIENT or  ply:SteamID()=="STEAM_0:0:25009758" or ply:SteamID()=="STEAM_0:1:17130011" or ply:SteamID()=="STEAM_0:1:73899349" or ply:SteamID()=="STEAM_0:1:76018763" or ply:SteamID()=="STEAM_0:1:21640664" end,
CustomCheckFailMsg = "You are not the owner of this class."
})


/*---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------*/
GAMEMODE.DefaultTeam = TEAM_CITIZEN


/*---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------*/
GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = true,
	[TEAM_CHIEF] = true,
	[TEAM_MAYOR] = true,
}

/*---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------*/
DarkRP.addHitmanTeam(TEAM_HITMAN)
