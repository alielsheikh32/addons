local file, folder = file.Find( "recipes/*.lua", "LUA" )

if SERVER then
	include( 'rpc_config.lua' )
	include( 'core/sv_craft.lua' )
	include( 'core/sh_register.lua' )
	include( 'core/sh_notify.lua' )
	include( 'core/sh_rpctab.lua' )

	AddCSLuaFile( "core/sh_register.lua" )
	
	for _, files in pairs( file ) do
		include( 'recipes/' .. files )

		AddCSLuaFile( "recipes/" .. files )
	end

	AddCSLuaFile( "core/sh_notify.lua" )
	AddCSLuaFile( "core/sh_rpctab.lua" )
else
	include( "core/sh_register.lua" )
	include( "core/sh_notify.lua" )

	for _, files in pairs( file ) do
		include( 'recipes/' .. files )
	end

	include( "core/sh_rpctab.lua" )
end