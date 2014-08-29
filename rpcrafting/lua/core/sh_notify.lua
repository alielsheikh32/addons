local plyMeta = FindMetaTable( "Player" )

function plyMeta:Notify( msg, notify )
	if SERVER then
		if notify == 0 then
			format = "NOTIFY_GENERIC"
		elseif notify == 1 then
			format = "NOTIFY_ERROR"
		elseif notify == 2 then
			format = "NOTIFY_UNDO"
		elseif notify == 3 then
			format = "NOTIFY_HINT"
		elseif notify == 4 then
			format = "NOTIFY_CLEANUP"
		end

		local sound = "ambient/water/drip" .. math.random(1, 4) .. ".wav"
		self:SendLua( "GAMEMODE:AddNotify( \"" .. msg .. "\", " .. format .. ", 3 ) surface.PlaySound( \"" .. sound .. "\" )" )
	else
		GAMEMODE:AddNotify( msg, notify, 3 )
		surface.PlaySound( "ambient/water/drip" .. math.random(1, 4) .. ".wav" )
	end
end