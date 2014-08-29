for i = 10, 70 do 
	surface.CreateFont("Exo700_"..i, {
		size = i,
		weight = 700,
		antialias = true,
		shadow = false,
		font = "Trebuchet MS"})

	surface.CreateFont("Exo500_"..i, {
		size = i,
		weight = 500,
		antialias = true,
		shadow = false,
		font = "Trebuchet MS"})
		
	surface.CreateFont("Exo400_"..i, {
		size = i,
		weight = 400,
		antialias = true,
		shadow = false,
		font = "Trebuchet MS"})
		
	surface.CreateFont("Exo300_"..i, {
		size = i,
		weight = 300,
		antialias = true,
		shadow = false,
		font = "Trebuchet MS"})
end

surface.CreateFont( "ItemLabel", {
	font = "Trebuchet MS",
	size = 16,
	weight = 500,
	outline = false,
	antialias = true})