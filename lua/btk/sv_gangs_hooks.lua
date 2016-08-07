hook.Add("PlayerInitialSpawn",
	function (Player)
		net.Start("bk_gangs")
		net.WriteUInt(table.Count(BK.Gangs))
		
		for Name, Gang in pairs(BK.Gangs) do
			net.WriteString(Gang.Name)
			net.WriteColor(Gang.Color)
			net.WriteEntity(Gang.Leader)
			
			net.WriteUInt(table.Count(Gang.Members))
			for Index, Member in pairs(Gang.Members) do
				net.WriteEntity(Member)
			end
		end
		
		net.Send(Player)
		Player:ConCommand("choosebkgang")
	end
)