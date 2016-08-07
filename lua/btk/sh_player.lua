local Player = FindMetaTable("Player")

function Player:GetBKTeam()
	return BK.Team[self:GetNWString("BK_Team") or "Joining"]
end

function Player:SetBKTeam(Name)
	local TeamTable = BK.Team[Name]
	if not TeamTable then
		return false
	end

	local Team = self:GetNWString("BK_Team", "Joining") or "Joining"
	if Team == Name then
		ULib.tsay(self, "You're already in that team.", true)
		return false
	end

	if not self.BK_LastChangeTeam or self.BK_LastChangeTeam + bk_prechangeteam_delay:GetInt() < CurTime() then
		self.BK_LastChangeTeam = CurTime()
	else
		ULib.tsay(self, "Wait "..math.ceil(self.BK_LastChangeTeam + bk_prechangeteam_delay:GetInt() - CurTime()).."s before changing team again.")
		return false
	end
	if bk_postchangeteam_delay:GetInt() > 0 then
		ULib.tsay(self, "You will change your team to "..TeamTable.Name.." in "..bk_postchangeteam_delay:GetInt().." seconds")
	end
	timer.Create("bk_"..self:UniqueID(), bk_postchangeteam_delay:GetInt(), 1,
		function ()
			if self:IsValid() then
				self:SetNWString("BK_Team", Name)
				TeamTable.OnLoadout(self)
				TeamTable.OnSpawn(self)
				ulx.fancyLogAdmin(self, "#A switched to team #s", Name)
			end
		end
	)
	self:StripWeapons()
	self:RemoveAllAmmo()
end
