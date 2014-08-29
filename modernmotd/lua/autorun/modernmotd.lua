if SERVER then
	AddCSLuaFile()
	AddCSLuaFile('cl_modernmotd.lua')
	AddCSLuaFile('sh_config.lua')
	AddCSLuaFile('cl_fonts.lua')
	AddCSLuaFile('cl_tabs.lua')
	AddCSLuaFile('cl_addtabs.lua')
	AddCSLuaFile('cl_addservers.lua')
	
	--Add panel files
	AddCSLuaFile('panels/cl_menubutton.lua')
	AddCSLuaFile('panels/cl_serverpanel.lua')
	
	--Add server files
	include('sv_modernmotd.lua')
	
	--Add resources
	local function AddResourceDir(dir)
		local files, dirs = file.Find(dir.."/*", "GAME")

		for _, fdir in pairs(dirs) do
			if fdir != ".svn" then
				AddResourceDir(dir.."/"..fdir)
			end
		end

		for k,v in pairs(files) do
			//print(dir.."/"..v)
			resource.AddSingleFile(dir.."/"..v)
		end
	end

	AddResourceDir("materials/modernmotd")
	AddResourceDir("sound/modernmotd")
	resource.AddFile("resource/fonts/BebasNeue.ttf")
	resource.AddFile("resource/fonts/OpenSansC.ttf")
end

if CLIENT then
	include('cl_modernmotd.lua')
end