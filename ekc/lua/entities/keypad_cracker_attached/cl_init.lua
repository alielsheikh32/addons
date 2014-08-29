include("shared.lua")

function ENT:Initialize()
	self.modelscale = self:GetModelScale()
	self.Entity:SetModelScale(self.Entity:GetModelScale() * 0.7, 0)
end

function ENT:Draw()
	if IsValid(self) and self.modelscale == self.Entity:GetModelScale() then
		self.Entity:SetModelScale(self.Entity:GetModelScale() * 0.7, 0)
	end
	self.Entity:DrawModel()
	
	if not IsValid(self:GetNWEntity("cracking")) then return end
	
	local FixAngles = self.Entity:GetAngles()
	local FixRotation = Vector(0, 270, 0)

	FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
	FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
	FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)

 	local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 4.45)
	
	local function garbledtext()
		self.nextgarble = self.nextgarble or 0
		if CurTime() > self.nextgarble then
			self.nextgarble = CurTime() + math.Rand(0, .1)
			local text = {}
			for i = 1, math.random(2, 6) do
				table.insert(text, tobool(math.random(0, 2)) and math.random(0, 9) or string.char(math.random(33, 125)))
			end
			self.garbledtext = table.concat(text)
		end
		return self.garbledtext or ""
	end
	
	cam.Start3D2D(TargetPos, FixAngles, .05)
		draw.RoundedBox( 0, 15, -50, 70, 40, Color( 0, 0, 0, 200 ) )
		draw.DrawText(garbledtext(), "Trebuchet18", 25, -40, Color(255, 255, 255, 255))
	cam.End3D2D()
end

function ENT:Think()
	self.NextSound = self.NextSound or 0
	if IsValid(self:GetNWEntity("cracking")) and self.NextSound < CurTime() then
		self.NextSound = CurTime() + 1
		self:EmitSound("buttons/combine_button_locked.wav")
	end
end