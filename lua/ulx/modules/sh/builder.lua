function BK.Build(Player)
	Player:SetBKTeam("Builder")
end

local BuildCommand = ulx.command("Fun", "ulx builder", BK.Build, "!builder")
BuildCommand:defaultAccess(ULib.ACCESS_ALL)
BuildCommand:help("Switch team to Builder")