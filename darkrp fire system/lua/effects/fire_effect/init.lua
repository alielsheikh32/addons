local function collideCallback ( particle )
	particle:SetDieTime(10)
end

function EFFECT:Init( data )

	local Trace = {}
	Trace.start = data:GetOrigin() - Vector(0, 0, 5)
	Trace.endpos = data:GetOrigin() - Vector(0, 0, 5) + Vector(0, 0, 500)
	
	local tr = util.TraceLine(Trace)
	
	local TheFire = GLOBAL_EMITTER:Add( "effects/flame", data:GetOrigin() - Vector(0, 0, 5))
	
	if tr.Hit then
		TheFire:SetVelocity(Vector(math.random(-30,30),math.random(-30,30), math.random(0, 70)))
	else
		TheFire:SetVelocity(Vector(math.random(-30,-20),math.random(20,30), math.random(0, 70)))
	end

	TheFire:SetDieTime(math.Rand(2, 3))
	TheFire:SetStartAlpha(230)
	TheFire:SetEndAlpha(0)
	TheFire:SetStartSize(math.random(70, 80))
	TheFire:SetEndSize(10)
	TheFire:SetRoll( math.Rand( 0,10  ) )
	TheFire:SetRollDelta(math.Rand( -0.2, 0.2 ))
	
	if tr.Hit and math.sin(CurTime() * 5) > 0 then
		local TheFire = GLOBAL_EMITTER:Add("effects/extinguisher", data:GetOrigin() - Vector(0, 0, 5) + Vector(math.random(-40,40),math.random(-40,40), math.random(50, 100)))
		TheFire:SetVelocity(Vector(math.random(-20,20),math.random(-20,20), math.random(0, 20)))
		TheFire:SetDieTime(20)
		TheFire:SetStartAlpha(20)
		TheFire:SetEndAlpha(0)
		TheFire:SetStartSize(math.random(40, 50))
		TheFire:SetEndSize(200)
	end
end

function EFFECT:Render()
end