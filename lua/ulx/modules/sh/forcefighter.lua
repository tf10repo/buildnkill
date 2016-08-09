function ulx.forcefighter( calling_ply, target_ply )

	target_ply:SetBKTeam("Fighter")
	ulx.fancyLogAdmin( calling_ply, "#A forced #T to move to the fighters team.", target_ply )

end
local forcefighter = ulx.command( "Utility", "ulx forcefighter", ulx.forcefighter, "!forcefighter" )
forcefighter:addParam{ type=ULib.cmds.PlayerArg }
forcefighter:defaultAccess( ULib.ACCESS_ADMIN )
forcefighter:help( "Force a player to go to Fighter Team." )
