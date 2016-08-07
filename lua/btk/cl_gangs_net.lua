net.Receive("bk_gangs",
	function ()
		BK.Gangs = {}
		
		for i = 1, net.ReadUInt() do
			local Gang = {}
			
			Gang.Name = net.ReadString()
			Gang.Color = net.ReadColor()
			Gang.Leader = net.ReadEntity()
			
			Gang.Members = {}
			for i = 1, net.ReadUInt() do
				table.insert(Gang.Members, net.ReadEntity())
			end
			
			BK.Gangs[Gang.Name] = Gang
		end
		
		if IsValid(BK.GangsPanel) then
			BK.GangsPanel:UpdateGangs()
		end
	end
)

net.Receive("bk_gangs_created",
	function ()
		local Gang = {}
		Gang.Name = net.ReadString()
		Gang.Color = net.ReadColor()
		Gang.Leader = net.ReadEntity()
		Gang.Members = {}
		
		BK.Gangs[Gang.Name] = Gang
		
		if IsValid(BK.GangsPanel) then
			BK.GangsPanel:UpdateGangs()
		end
	end
)

net.Receive("bk_gangs_removed",
	function ()
		BK.Gangs[net.ReadString()] = nil
		
		if IsValid(BK.GangsPanel) then
			BK.GangsPanel:UpdateGangs()
		end
	end
)