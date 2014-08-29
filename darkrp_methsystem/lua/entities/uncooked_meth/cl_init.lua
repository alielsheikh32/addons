include("shared.lua")

function ENT:Initialize()

end

surface.CreateFont( "TrebuchetC", {
 font = "Trebuchet24",
 size = 60,
 weight = 0,
} )

surface.CreateFont( "TrebuchetD", {
 font = "Trebuchet24",
 size = 200,
 weight = 0,
} )

function ENT:Draw()
	self:DrawModel()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local Ang2 = self:GetAngles()
	local TextAng2 = Ang2
	local TextAng = Ang
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	TextAng:RotateAroundAxis(TextAng:Right(), 0)

	Ang2:RotateAroundAxis(Ang:Forward(), 90)
	TextAng2:RotateAroundAxis(TextAng:Right(), 180)

	
	
	//Time
	local time = self:GetMethTimer()
	local minutes = math.floor(time / 60)
	local sec = time - (minutes * 60)
	local dots = ":"
	if sec < 10 then dots = ":0"
	end
	local actualtime = tonumber(minutes)..dots..tonumber(sec)

	
	
	cam.Start3D2D(Pos + Ang:Right() * -60, TextAng, 0.05)
		
	if time <= 0 then
		draw.RoundedBox(0,-75/2*8,-50*8,75*8,15*8,Color(75,139,191))
		draw.RoundedBox(0,-75/2*8,-35*8,75*8,20*8,Color(32,34,38,200))
		draw.SimpleTextOutlined('Meth timer', "TrebuchetC", -75/2*7.5 + 3, -50*7.5, Color( 255,255,255 ), TEXT_ALIGN_LEFT,0,0, Color( 0,0,0,255))
		draw.SimpleTextOutlined("DONE", "TrebuchetD", -3.5, -37*7.5, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,0, Color( 0,0,0,255))
	else
		draw.RoundedBox(0,-75/2*8,-50*8,75*8,15*8,Color(75,139,191))
		draw.RoundedBox(0,-75/2*8,-35*8,75*8,20*8,Color(32,34,38,200))
		draw.SimpleTextOutlined('Meth timer', "TrebuchetC", -75/2*7.5 + 3, -50*7.5, Color( 255,255,255 ), TEXT_ALIGN_LEFT,0,0, Color( 0,0,0,255))
		draw.SimpleTextOutlined(actualtime, "TrebuchetD", -3.5, -37*7.5, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,0, Color( 0,0,0,255))
	end
	cam.End3D2D()
	
	//Backside
	cam.Start3D2D(Pos + Ang2:Right() * -60, TextAng2, 0.05)
	if time <= 0 then
		draw.SimpleTextOutlined('Meth timer', "TrebuchetC", -75/2*7.5 + 3, -50*7.5, Color( 255,255,255 ), TEXT_ALIGN_LEFT,0,0, Color( 0,0,0,255))
		draw.SimpleTextOutlined("DONE", "TrebuchetD", -3.5, -37*7.5, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,0, Color( 0,0,0,255))
	else
		draw.SimpleTextOutlined('Meth timer', "TrebuchetC", -75/2*7.5 + 3, -50*7.5, Color( 255,255,255 ), TEXT_ALIGN_LEFT,0,0, Color( 0,0,0,255))
		draw.SimpleTextOutlined(actualtime, "TrebuchetD", -3.5, -37*7.5, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,0, Color( 0,0,0,255))
	end
	cam.End3D2D()
	
end


