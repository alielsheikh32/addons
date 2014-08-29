cs_items = {
		{ "VIP", "Ranks", "Purchasing this rank will instantly make you a VIP permanently!", 10, function( ply )
			RunConsoleCommand( "ulx", "adduser", ply:Nick(), "vip" )
		end },
		{ "Respected", "Ranks", "Purchasing this rank will instantly make you Respected permanently!", 20, function( ply )
			RunConsoleCommand( "ulx", "adduser", ply:Nick(), "respected" )
		end },
		{ "Mod (30 Days)", "Ranks", "Purchasing this item will make you a Mod for 30 days!", 30, function( ply )
			ply:SetPData( "cs_rankprev", ply:GetPData( "cs_rankexpire" ) and ply:GetPData( "cs_rankprev" ) or ply:GetUserGroup() )
			RunConsoleCommand( "ulx", "adduser", ply:Nick(), "dmod" )
			ply:SetPData( "cs_rankexpire", os.time() + 86400 * 30 )
		end },
		{ "Mod (60 Days)", "Ranks", "Purchasing this item will make you a Mod for 60 days! SAVE 10 CREDITS!", 40, function( ply )
			ply:SetPData( "cs_rankprev", ply:GetPData( "cs_rankexpire" ) and ply:GetPData( "cs_rankprev" ) or ply:GetUserGroup() )
			RunConsoleCommand( "ulx", "adduser", ply:Nick(), "dmod" )
			ply:SetPData( "cs_rankexpire", os.time() + 172800 * 30 )
		end },
		{ "Supporter", "Ranks", "Purchasing this item will instantly make you Supporter permanently!", 50, function( ply )
			RunConsoleCommand( "ulx", "adduser", ply:Nick(), "supporter" )
		end },
		
		{ "RPG", "Weapons", "Purchasing this item will instantly give you an RPG!", 15, function( ply )
			ply:Give( "weapon_mad_rpg" )
		end },
		{ "C4", "Weapons", "Purchasing this item will instantly give you a C4", 10, function( ply )
			 ply:Give( "weapon_mad_c4" )
		end },
		{ "Silent Sniper", "Weapons", "Purchasing this item will instantly give you a Silent Sniper", 15, function( ply )
			 ply:Give( "ls_sniper" )
		end },
	--	{ "Shock Rifle", "Weapons", "Claiming this item will instantly grant you a Shock Rifle!", 15, function( ply )
	--		 ply:Give( "weapon_asmd" )
	--	end },
	
	--	{ "$50k", "Cash", "Purchasing this will instantly grant you $50,000!", 10, function( ply ) ply:AddMoney( 5e4 ) end },
	--	{ "$100k", "Cash", "Purchasing this will instantly grant you $100,000!", 20, function( ply ) ply:AddMoney( 1e5 ) end },
	--	{ "$250k", "Cash", "Purchasing this will instantly grant you $250,000!", 25, function( ply ) ply:AddMoney( 25e4 ) end },
	--	{ "$500k", "Cash", "Purchasing this will instantly grant you $500,000!", 50, function( ply ) ply:AddMoney( 5e5 ) end },
	--	{ "$1M", "Cash", "Purchasing this will instantly grant you $1,000,000!", 100, function( ply ) ply:AddMoney( 1e6 ) end }
}