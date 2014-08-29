function EFFECT:Init( data )

	local target = data:GetEntity()
	
	for i = 1, 10 do
		timer.Simple((i - 1) * .02, function()
			if target and target:IsValid() and target:IsPlayer() and target:Alive() then
				local effect = GLOBAL_EMITTER:Add("effects/extinguisher", target:GetShootPos() + target:GetAimVector() * 20)
				effect:SetVelocity(target:GetAimVector() * 500)
				effect:SetDieTime(1)
				effect:SetStartAlpha(0)
				effect:SetEndAlpha(100)
				effect:SetStartSize(5)
				effect:SetEndSize(40)
				effect:SetRoll( math.Rand( 0,10  ) )
				effect:SetRollDelta(math.Rand( -0.2, 0.2 ))
			end
		end)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end