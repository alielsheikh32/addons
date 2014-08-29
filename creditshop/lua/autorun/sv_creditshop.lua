local ranks_amt = {
	1,
	5,
	10,
	25,
	50,
	100
}

-- NO

if CLIENT then return end
mysql.tableExists( "credits", function( ex )
	if ex then return end
	
	mysql.query( "CREATE TABLE IF NOT EXISTS credits ( player BIGINT NOT NULL PRIMARY KEY, current INTEGER, total INTEGER );" )
end )

if game.SinglePlayer() then
	FindMetaTable( "Player" ).SteamID64 = function() return 1 end
	FindMetaTable( "Player" ).UniqueID = function() return 1 end
end

util.AddNetworkString( "cs_menu" )
util.AddNetworkString( "cs_thanks" )
util.AddNetworkString( "cs_msg" )
util.AddNetworkString( "cs_poll" )

local function statMsg( ply, txt )
	net.Start( "cs_msg" )
		net.WriteString( txt )
	net.Send( ply )
end

concommand.Add( "creditsadminset", function( ply, com, args )
	
	if not ply:IsSuperAdmin() then return end
	local tar, set = tonumber( args[1] ), tonumber( args[2] )
	if not tar or not set then return end
	tar = Entity( tar )
	if not IsValid( tar ) or not tar:IsPlayer() then return end
	
	mysql.query( "UPDATE credits SET current = " .. args[2] .. " WHERE player = " .. tar:UniqueID() .. ";", function() if args[3] then ply:ConCommand( "creditsmenu" ) end end )
	
end )

concommand.Add( "creditsadminpoll", function( ply, com, args )
	
	if not ply:IsSuperAdmin() then return end
	
	local tab = {}
	for k, v in pairs( player.GetAll() ) do tab[ #tab + 1 ] = v:UniqueID() end
	mysql.query( "SELECT player, current, total FROM credits WHERE player IN ( " .. table.concat( tab, ", " ) .. " );", function( data )
		net.Start( "cs_poll" )
			net.WriteTable( data )
		net.Send( ply )
	end )
	
end )

concommand.Add( "creditsmenu", function( ply, com, args )
	
	if not IsValid( ply ) then return end
	
	print( ply, ply.SteamID, ply.SteamID64 )
	
	mysql.query( "SELECT rank FROM unclaimed WHERE community_id = " .. ply:SteamID64() .. " LIMIT 1;", function( data )
		
		if #data == 0 then
			mysql.query( "SELECT current, total FROM credits WHERE player = " .. ply:UniqueID() .. " LIMIT 1;", function( data )
				net.Start( "cs_menu" )
					net.WriteInt( data[1].current, 16 )
					net.WriteInt( data[1].total, 16 )
					net.WriteBit( ply:GetPData( "cs_rankexpire" ) )
					if tonumber( ply:GetPData( "cs_rankexpire" ) ) then
						net.WriteInt( tonumber( ply:GetPData( "cs_rankexpire" ) ), 32 )
						net.WriteString( ply:GetPData( "cs_rankprev" ) )
					end
				net.Send( ply )
			end )
		else
			local amt = tonumber( data[1].rank )
			if not amt or amt < 1 or amt > #ranks_amt then ply:ChatPrint( "GJ, you fucked yourself here. Contact Storm, citing COMMUNITY_ID " .. ply:SteamID64() ) return end
			amt = ranks_amt[ amt ]
			BroadcastLua( "chat.AddText( Color( 220, 200, 0 ), \"" .. ply:Nick() .. " has just donated for " .. amt .. " credit" .. ( amt == 1 and "" or "s" ) .. "!\" )" )
			mysql.query( "DELETE FROM unclaimed WHERE community_id = " .. ply:SteamID64() .. ";" )
			mysql.query( "UPDATE credits SET current = current + " .. amt .. ", total = total + " .. amt .. " WHERE player = " .. ply:UniqueID() .. ";", function()
				mysql.query( "SELECT current, total FROM credits WHERE player = " .. ply:UniqueID() .. " LIMIT 1;", function( data )
					net.Start( "cs_menu" )
						net.WriteInt( data[1].current, 16 )
						net.WriteInt( data[1].total, 16 )
						net.WriteBit( ply:GetPData( "cs_rankexpire" ) )
						if ply:GetPData( "cs_rankexpire" ) then
							net.WriteInt( tonumber( ply:GetPData( "cs_rankexpire" ) ), 32 )
							net.WriteString( ply:GetPData( "cs_rankprev" ) )
						end
					net.Send( ply )
					net.Start( "cs_thanks" )
					net.Send( ply )
				end )
			end )
		end
		
	end )
	
end )

concommand.Add( "creditsbuy", function( ply, com, args )
	
	if not IsValid( ply ) then return end
	
	local it = tonumber( args[1] )
	if not it or it < 1 or it > #cs_items then return end
	it = cs_items[ it ]
	
	mysql.query( "SELECT current FROM credits WHERE player = " .. ply:UniqueID() .. " LIMIT 1;", function( data )
		
		if not data[1] then return end
		
		if tonumber( data[1].current ) < it[4] then statMsg( ply, "You cannot afford that!" ) return end
		
		local ret = it[5]( ply )
		if ret == false then return end
		
		mysql.query( "UPDATE credits SET current = current - " .. it[4] .. " WHERE player = " .. ply:UniqueID() .. " LIMIT 1;", function()
			
			ply:ConCommand( "creditsmenu" )
			statMsg( ply, "You purchased " .. it[1] .. "!" )
			
		end )
		
	end )
	
end )

concommand.Add( "creditstrade", function( ply, com, args )
	
	if not IsValid( ply ) then return end
	local tar = tonumber( args[1] )
	local amt = tonumber( args[2] )
	if not tar or not amt then return end
	if amt < 1 or amt ~= math.floor( amt ) then return end
	
	mysql.query( "SELECT current FROM credits WHERE player = " .. ply:UniqueID() .. " LIMIT 1;", function( data )
		
		if not data[1] then return end
		
		local cur = tonumber( data[1].current )
		if cur < amt then statMsg( ply, "You don't have that many credits!" ) return end
		
		mysql.query( "SELECT player FROM credits WHERE player = " .. tar .. " LIMIT 1;", function( data )
			
			if not data[1] then statMsg( ply, "Who?" ) return end
			
			mysql.query( "UPDATE credits SET current = current + " .. amt .. " WHERE player = " .. tar .. " LIMIT 1;", function()
				for _, v in pairs( player.GetAll() ) do
					if v:UniqueID() ~= tar then continue end
					statMsg( v, "You received " .. amt .. " credit" .. ( amt == 1 and "" or "s" ) .. " from " .. ply:Nick() .. "!" )
					return
				end
			end )
			mysql.query( "UPDATE credits SET current = current - " .. amt .. " WHERE player = " .. ply:UniqueID() .. " LIMIT 1;", function()
				statMsg( ply, "You sent " .. amt .. " credit" .. ( amt == 1 and "" or "s" ) .. " to " .. tar .. "!" )
			end )
			
		end )
		
	end )
	
end )

hook.Add( "PlayerInitialSpawn", "creditshop", function( ply )
	
	if tonumber( ply:GetPData( "cs_rankexpire" ) ) and tonumber( ply:GetPData( "cs_rankexpire" ) ) < os.time() then
		RunConsoleCommand( "ulx", "adduser", ply:Nick(), ply:GetPData( "cs_rankprev" ) or "user" )
		ply:SetPData( "cs_rankexpire" )
		ply:SetPData( "cs_rankprev" )
	end
	
	mysql.query( "SELECT current FROM credits WHERE player = " .. ply:UniqueID() .. " LIMIT 1;", function( data )
		
		if #data == 0 then
			print( 5 )
			mysql.query( "INSERT INTO credits ( player, current, total ) VALUES ( " .. ply:UniqueID() .. ", 0, 0 );" )
		end
		
	end )
	
end )

hook.Add( "PlayerSay", "shopinnit", function( ply, txt )
	
	if string.Left( txt ) == "!shop" or string.Left( txt ) == "/shop" then
		ply:ConCommand( "creditsmenu" )
		return ""
	end
	
end )