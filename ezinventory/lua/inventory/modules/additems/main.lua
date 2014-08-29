if (SERVER) then
	include("sv_additems.lua")
	include("sv_persist.lua")
	AddCSLuaFile("cl_additems.lua")
end

if (CLIENT) then
	include("cl_additems.lua")
end