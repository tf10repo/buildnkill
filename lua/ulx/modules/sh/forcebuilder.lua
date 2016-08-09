function ulx.forcebuilder( calling_ply, target_ply )

	target_ply:SetBKTeam("Builder")
	ulx.fancyLogAdmin( calling_ply, "#A forced #T to move to the builders team.", target_ply )

end
local forcebuilder = ulx.command( "Utility", "ulx forcebuilder", ulx.forcebuilder, "!forcebuilder" )
forcebuilder:addParam{ type=ULib.cmds.PlayerArg }
forcebuilder:defaultAccess( ULib.ACCESS_ADMIN )
forcebuilder:help( "Force a player to go to Builder Team." )