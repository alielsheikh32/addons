if CLIENT then return end
require( "mysqloo" )

mysql = {}

mysql.queue = {}
mysql.db = mysqloo.connect( "192.185.41.249", "storm123_donatee", "onPBE,,TOlCl", "storm123_donations", 3306 )

function mysql.db:onConnected()
	
	for k, v in ipairs( mysql.queue ) do
		mysql.query( v[1], v[2] )
	end
	mysql.queue = {}
	
	print( "[SQL] Connected to database!" )
	
end

function mysql.db:onConnectionFailed( err )
	
	print( "[SQL] Attempting connection to database failed!" )
	print( "[SQL] Error:", err )
	print( "[SQL] Attempting to reconnect in 5.." )
	timer.Simple( 5, function() self:connect() end )
	
end

mysql.db:connect()

function mysql.query( query, callback )
	
	local q = mysql.db:query( query )
	
	if not q then table.insert( mysql.queue, { query, callback } ) return end
	
	function q:onSuccess( data )
		
		if callback then callback( data ) end
		
	end
	
	function q:onError( err )
		
		if mysql.db:status() == mysqloo.DATABASE_NOT_CONNECTED then
			
			print( "[SQL] Query error, cannot find server! Reconnecting.." )
			table.insert( mysql.queue, { query, callback } )
			mysql.db:connect()
			return
			
		end
		
		print( "[SQL] Query error! Query:", query, "Error:", err )
		
	end
	
	q:start()
	
end

-- Convenience

function mysql.tableExists( tab, func )
	mysql.query( "SHOW TABLES LIKE \"" .. tab .. "\"", function( data )
		func( #data > 0 )
	end )
end

concommand.Add( "sql_status", function( ply, com, args )
	
	-- if not ply:IsAdmin() then return end
	
	ply:PrintMessage( 2, mysql.db:serverInfo() )
	ply:PrintMessage( 2, mysql.db:hostInfo() )
	if args[1] then
		local stat = mysql.db:status()
		for k, v in pairs( mysqloo ) do
			if string.sub( k, 1, 8 ) == "DATABASE" and stat == v then ply:PrintMessage( 2, k ) break end
		end
	end
	
end )