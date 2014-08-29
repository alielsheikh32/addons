--Modern MOTD Fonts
local function LoadModernMOTDFonts()
if MODERN.FontsLoaded then return end
surface.CreateFont("Bebas24Font", {font = "Bebas Neue", size= 24, weight = 400, antialias = true } ) --Font used for titles
surface.CreateFont("Bebas14Font", {font = "Bebas Neue", size= 14, weight = 400, antialias = true } ) --Font used for titles
surface.CreateFont("Bebas18Font", {font = "Bebas Neue", size= 18, weight = 400, antialias = true } ) --Font used for titles
surface.CreateFont("Bebas70Font", {font = "Bebas Neue", size= 70, weight = 400, antialias = true } ) --Font used for titles

surface.CreateFont("OpenSans14Font", {font = "Open Sans Condensed", size= 14, weight = 400, antialias = true } ) --Font used for titles
surface.CreateFont("OpenSans18Font", {font = "Open Sans Condensed", size= 18, weight = 400, antialias = true } ) --Font used for titles
MODERN.FontsLoaded = true
end
LoadModernMOTDFonts()
hook.Add("InitPostEntity", "MODERN_InitPostLoadFonts", LoadModernMOTDFonts)