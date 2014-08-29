function EZI.DrawPNG(pngtex, x, y, w, h, color)
	if !(color) then color = Color(255,255,255) end
	surface.SetMaterial( pngtex )
	surface.SetDrawColor(color)
	surface.DrawTexturedRect( x, y, w, h )
end
