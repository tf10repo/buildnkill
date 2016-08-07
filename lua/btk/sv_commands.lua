local BuildCommand = ulx.command("Fun", "ulx builder", BK.Build, "!builder")
BuildCommand:defaultAccess(ULib.ACCESS_ALL)
BuildCommand:help("Switch team to Builder")

local FightCommand = ulx.command("Fun", "ulx fighter", BK.Fight, "!fighter")
FightCommand:defaultAccess(ULib.ACCESS_ALL)
FightCommand:help("Switch team to Fighter")
