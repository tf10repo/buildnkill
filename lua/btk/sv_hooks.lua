hook.Add("PlayerShouldTakeDamage", "BK",
	function (Player, Attacker)
		if IsValid(Player) and Player:IsPlayer() then
			if not Player:GetBKTeam().Damage then
				return false
			end
		end
		if IsValid(Attacker) and Attacker:IsPlayer() then
			if not Attacker:GetBKTeam().Damage then
				return false
			end
		end
		return true
	end
)

hook.Add("PlayerSpawn", "BK",
	function (Player)
		Player:GetBKTeam().OnSpawn(Player)
	end
)

hook.Add("PlayerLoadout", "BK",
	function (Player)
		Player:GetBKTeam().OnLoadout(Player)
		return true
	end
)

hook.Add("ULibLocalPlayerReady", "BK",
	function(Player)
		Player:ConCommand("choosebkteam")
	end
)

hook.Add("PlayerNoClip", "BK",
	function (Player, Active)
		if not Active then
			return true
		elseif Player:GetBKTeam().Noclip then
			return true
		end
		return false
	end
)
