FIRE_MaterialTypes = { -- Full list of material types (ground types), that fire can spread on. For example: wood, grass, carpet.
	MAT_DIRT,
	MAT_WOOD,
	MAT_COMPUTER,
	MAT_FOLIAGE,
	MAT_PLASTIC,
	MAT_SAND,
	MAT_SLOSH,
	MAT_TILE,
	MAT_VENT -- THE LAST LINE SHOULD NOT HAVE A COMMA AT THE END. BE AWARE OF THIS WHEN EDITING THIS!
}

FIRE_MaxFires = 250 -- Maximum amount of fires that can spawn/spread. [Default = 250]
FIRE_RandomFireInterval = 300 -- Interval between random fires are generated around the map. [Default = 300 (5 minutes)]
FIRE_RemoveAllOnLastDC = false -- Remove all fires when there are no more players on the server (to prevent lag?). [Default = false]
FIRE_SpreadInterval = 75 -- Time between fire spreads (in seconds). [Default = 120 (2 minutes)]
FIRE_ExtinguishPay = 50 -- Payment for turning off a fire. [Default = 10]
FIRE_NotifyOnExtinguish = true -- Send the player a notification that they've received money for extinguishing fire. [Default = true]

-- Fire Damage
FIRE_FireFighterDamage = 2 -- The amount of damage fire fighters should take from standing in fire. [Default = 2]
FIRE_FireDamage = 20 -- The amount of damage everyone else should take from standing in fire. [Default = 4]
FIRE_VehicleDamage = 6 -- The amount of damage vehicles should take from being in fire. [Default = 6]
FIRE_DamageInterval = 0.3 -- The amount of time between taking damage when standing in fire (in seconds). [Default = 0.5]

FIRE_BurntPropColor = Color(120, 120, 120, 255) -- If a prop hits the fire, it will set on fire and turn into this color (burnt color). [Default = Color(120, 120, 120, 255)]

-- Firetruck Config
FIRETRUCK_VehicleScript = "scripts/vehicles/firetruck.txt" -- This is the vehicle script for the vehicle. The default vehicle script is from Sickness Models.
FIRETRUCK_VehicleModel = "models/sickness/truckfire.mdl" -- This is the model for the firetruck. The default model is from Sickness Models.
FIRETRUCK_NPCModel = "models/odessa.mdl" -- This is the model of the NPC to get a firetruck from.
FIRETRUCK_Health = 500 -- The amount of health the fire truck has.
FIRETRUCK_MaxTrucks = 0 -- The maximum amount of firetrucks allowed.