-- Set the player into the builders group
function BK.Build(Player)
	Player:SetBKTeam("Builder")
end

local BuildCommand = ulx.command("Fun", "ulx builder", BK.Build, "!builder")
BuildCommand:defaultAccess(ULib.ACCESS_ALL)
BuildCommand:help("Switch team to Builder")

-- Set the players into the fighters group
function BK.Fight(Player)
	Player:SetBKTeam("Fighter")
end

local FightCommand = ulx.command("Fun", "ulx fighter", BK.Fight, "!fighter")
FightCommand:defaultAccess(ULib.ACCESS_ALL)
FightCommand:help("Switch team to Fighter")