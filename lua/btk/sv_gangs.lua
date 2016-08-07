BK.Gangs = {}

function BK.CreateGang(Name, Color, Leader)
	if not BK.Gang[Name] then
		local Gang = {
			Name = Name,
			Color = Color,
			Leader = Leader,
			Members = {}
		}
		
		BK.Gangs[Gang.Name] = Gang
		
		net.Start("bk_gangs_created")
		net.WriteString(Gang.Name)
		net.WriteColor(Gang.Color)
		net.WriteEntity(Gang.Leader)
		net.Broadcast()
		
		return Gang
	end
end

function BK.RemoveGang(Name)
	if BK.Gang[Name] then
		BK.Gangs[Name] = nil
		
		net.Start("bk_gangs_removed")
		net.WriteString(Name)
		net.Broadcast()
	end
end