function BK.Fight(Player)
	Player:SetBKTeam("Fighter")
end

local FightCommand = ulx.command("Fun", "ulx fighter", BK.Fight, "!fighter")
FightCommand:defaultAccess(ULib.ACCESS_ALL)
FightCommand:help("Switch team to Fighter")