
/*---------------------------------------------------------
   Name: AdminOptions()
---------------------------------------------------------*/
local function MadAdminOptions(panel)
	if not LocalPlayer():IsAdmin() then return end
	
	panel:AddControl("Label", {Text = ""})
	
	local MadAdminWeaponOptions = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "mad_cows_weapon"}

	MadAdminWeaponOptions.Options["#Default"] = {  mad_admin_sound 	=	"NPC_Sniper.FireBullet",
								  mad_admin_shell 	=	"effect_mad_shell_pistol",
								  mad_admin_recoil 	=	"0.1",
								  mad_admin_damage 	=	"100",
								  mad_admin_numshots 	=	"1",
								  mad_admin_cone 		=	"0",
								  mad_admin_delay 	=	"0.1",
								  mad_admin_maxricochet =	"10",
								  mad_admin_scopezooms 	=	"8"
							     }
									
	MadAdminWeaponOptions.CVars = { 	"mad_admin_sound",
						"mad_admin_shell",
						"mad_admin_recoil",
						"mad_admin_damage",
						"mad_admin_numshots",
						"mad_admin_cone",
						"mad_admin_delay",
						"mad_admin_maxricochet",
						"mad_admin_scopezooms"
					   }
						
	panel:AddControl("ComboBox", MadAdminWeaponOptions)

	local MadAdminWeaponSounds = {Label = "#admin_weapon_sound", MenuButton = 0, Options = {}, CVars = {}}
		MadAdminWeaponSounds["Options"]["#no sound"]		= {mad_admin_sound = ""}
		MadAdminWeaponSounds["Options"]["#pistol sound"]	= {mad_admin_sound = "Weapon_Pistol.Single"}
		MadAdminWeaponSounds["Options"]["#smg sound"]	= {mad_admin_sound = "Weapon_SMG1.Single"}
		MadAdminWeaponSounds["Options"]["#ar-2 sound"]	= {mad_admin_sound = "Weapon_AR2.Single"}
		MadAdminWeaponSounds["Options"]["#shotgun sound"]	= {mad_admin_sound = "Weapon_Shotgun.Single"}
		MadAdminWeaponSounds["Options"]["#turret sound"]	= {mad_admin_sound = "NPC_FloorTurret.Shoot"}
		MadAdminWeaponSounds["Options"]["#airboat sound"]	= {mad_admin_sound = "Airboat.FireGunHeavy"}
		MadAdminWeaponSounds["Options"]["#strider sound"]	= {mad_admin_sound = "NPC_Strider.FireMinigun"}
		MadAdminWeaponSounds["Options"]["#sniper sound"]	= {mad_admin_sound = "NPC_Sniper.FireBullet"}
		
	panel:AddControl("ComboBox", MadAdminWeaponSounds)

	local MadAdminShellEffects = {Label = "#admin_weapon_shell", MenuButton = 0, Options = {}, CVars = {}}
		MadAdminShellEffects["Options"]["#no shell"]			= {mad_admin_shell = ""}
		MadAdminShellEffects["Options"]["#pistol shell"]		= {mad_admin_shell = "effect_mad_shell_pistol"}
		MadAdminShellEffects["Options"]["#rifle shell"]		= {mad_admin_shell = "effect_mad_shell_rifle"}
		MadAdminShellEffects["Options"]["#shotgun shell"]		= {mad_admin_shell = "effect_mad_shell_shotgun"}
		
	panel:AddControl("ComboBox", MadAdminShellEffects)

	panel:AddControl("Slider", {
		Label 	= "Recoil",
		Command 	= "mad_admin_recoil",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "10",
	})

	panel:AddControl("Slider", {
		Label 	= "Damage",
		Command 	= "mad_admin_damage",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "10000",
	})

	panel:AddControl("Slider", {
		Label 	= "Number of bullets per shot",
		Command 	= "mad_admin_numshots",
		Type 		= "Integer",
		Min 		= "1",
		Max 		= "20",
	})

	panel:AddControl("Slider", {
		Label 	= "Precision",
		Command 	= "mad_admin_cone",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "1",
	})

	panel:AddControl("Slider", {
		Label 	= "Delay",
		Command 	= "mad_admin_delay",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "1",
	})

	panel:AddControl("Slider", {
		Label 	= "Max ricochet on metal",
		Command 	= "mad_admin_maxricochet",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "100",
	})

	panel:AddControl("Slider", {
		Label 	= "Scope Zoom",
		Command 	= "mad_admin_scopezooms",
		Type 		= "Integer",
		Min 		= "2",
		Max 		= "25",
	})

	panel:AddControl("CheckBox", {
		Label = "Automatic",
		Command = "mad_admin_automatic",
	})
end

/*---------------------------------------------------------
   Name: MadCowsToolMenu()
---------------------------------------------------------*/
function MadCowsAdminToolMenu()

	spawnmenu.AddToolMenuOption("Options", "Mad Cows Weapons", "Admin Weapon Options", "Admin Weapon Options", "", "", MadAdminOptions)
end
hook.Add("PopulateToolMenu", "MadCowsAdminToolMenu", MadCowsAdminToolMenu)