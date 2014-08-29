hook.Add( "CanDropWeapon", "noclassweps", function( ply, wep )
	
	if not IsValid( ply ) or not IsValid( wep ) then return false end
	
	if table.HasValue( RPExtraTeams[ ply:Team() ].weapons, wep:GetClass() ) then return false end
	
end )