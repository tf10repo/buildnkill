local CATEGORY_NAME = "Utility"

function ulx.forcebuilder( calling_ply, target_ply )

	target_ply:SetBKTeam("Builder")
	ulx.fancyLogAdmin( calling_ply, "#A forced #T to move to the builders team.", target_ply )

end
local forcebuilder = ulx.command( CATEGORY_NAME, "ulx forcebuilder", ulx.forcebuilder, "!forcebuilder" )
forcebuilder:addParam{ type=ULib.cmds.PlayerArg }
forcebuilder:defaultAccess( ULib.ACCESS_ADMIN )
forcebuilder:help( "Force a player to go to Builder Team." )

function ulx.forcefighter( calling_ply, target_ply )

	target_ply:SetBKTeam("Fighter")
	ulx.fancyLogAdmin( calling_ply, "#A forced #T to move to the fighters team.", target_ply )

end
local forcefighter = ulx.command( CATEGORY_NAME, "ulx forcefighter", ulx.forcefighter, "!forcefighter" )
forcefighter:addParam{ type=ULib.cmds.PlayerArg }
forcefighter:defaultAccess( ULib.ACCESS_ADMIN )
forcefighter:help( "Force a player to go to Fighter Team." )
