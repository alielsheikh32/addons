for i = 10, 80 do
	surface.CreateFont( "Exo500_"..i, {
	 font = "Quicksand",
	 size = i,
	 weight = 500,
	 antialias = true,
	} )
	
	surface.CreateFont( "Exo700_"..i, {
	 font = "Quicksand",
	 size = i,
	 weight = 700,
	 antialias = true,
	} )
end