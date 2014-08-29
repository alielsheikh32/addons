/*---------------------------------------------------------
------mmmm---mmmm-aaaaaaaa----ddddddddd---------------------------------------->
     mmmmmmmmmmmm aaaaaaaaa   dddddddddd	  Name: Mad Cows Weapons
     mmm mmmm mmm aaa    aaa  ddd     ddd	  Author: Ash
    mmm  mmm  mmm aaaaaaaaaaa ddd     ddd	  Project Start: fucking time
    mmm       mmm aaa     aaa dddddddddd	  File: mad_falldamage.lua
---mmm--------mmm-aaa-----aaa-ddddddddd---------------------------------------->
---------------------------------------------------------*/


// Uses the default values from Source
function MPFallDamage( ply, vel )
	if GetConVarNumber("mp_falldamage") == 1 then
		vel = vel - 580
		return vel*(100/(1024-580))
	end
	return 10
end
hook.Add( "GetFallDamage", "MPFallDamage", MPFallDamage )