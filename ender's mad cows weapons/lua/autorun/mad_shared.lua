/*---------------------------------------------------------
------mmmm---mmmm-aaaaaaaa----ddddddddd---------------------------------------->
     mmmmmmmmmmmm aaaaaaaaa   dddddddddd	  Name: Mad Cows Weapons
     mmm mmmm mmm aaa    aaa  ddd     ddd	  Author: Worshipper
    mmm  mmm  mmm aaaaaaaaaaa ddd     ddd	  Project Start: October 23th, 2009
    mmm       mmm aaa     aaa dddddddddd	  File: mad_shared.lua
---mmm--------mmm-aaa-----aaa-ddddddddd---------------------------------------->
---------------------------------------------------------*/

MAD = {}

if (SERVER) then
	include("autorun/server/mad_admin.lua")
	include("autorun/server/mad_cleanup.lua")
	include("autorun/server/mad_getpos.lua")
	include("autorun/server/mad_server.lua")
	include("autorun/server/mad_spawnpoint.lua")
	include("autorun/server/mad_time.lua")
	//include("autorun/mad_shared.lua")
	//include("autorun/client/mad_client.lua")
	///include("autorun/client/mad_menu.lua")
	//include("autorun/client/mad_view.lua")
	//include("autorun/mad_npcs.lua")
	//include("autorun/mad_sounds.lua")
else
	include("autorun/client/mad_client.lua")
	include("autorun/client/mad_menu.lua")
    include("autorun/client/mad_killicon.lua")
end