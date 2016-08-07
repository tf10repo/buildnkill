BK.Team = {}

-- Builders
BK.Team.Builder = {
	Name = "Builder",
	Color = Color(50, 255, 50),
	Noclip = true,
	Damage = false
}

function BK.Team.Builder.OnSpawn(Player)
	Player:GodEnable()
end

function BK.Team.Builder.OnLoadout(Player)
	Player:StripWeapons()
	Player:RemoveAllAmmo()

	Player:Give("none")
	Player:Give("weapon_physgun")
	Player:Give("gmod_camera")
	Player:Give("gmod_tool")
end

-- Fighters
BK.Team.Fighter = {
	Name = "Fighter",
	Color = Color(255, 50, 50),
	Noclip = false,
	Damage = true,
	TraceRequired = true,
}

function BK.Team.Fighter.OnSpawn(Player)
	Player:GodDisable()
	Player:SetMoveType(MOVETYPE_WALK)
	Player:SetRunSpeed(500)
end

function BK.Team.Fighter.OnLoadout(Player)
	Player:StripWeapons()
	Player:RemoveAllAmmo()

	Player:Give("none")
	Player:Give("weapon_crowbar")
	Player:Give("weapon_physcannon")
	Player:Give("weapon_physgun")
	Player:Give("gmod_camera")
	Player:Give("weapon_fists")
	Player:Give("weapon_medkit")
	Player:Give("weapon_stunstick")
	Player:Give("weapon_pistol");	Player:GiveAmmo(144, "Pistol")
	Player:Give("weapon_357");		Player:GiveAmmo(48, "357")
	Player:Give("weapon_smg1");		Player:GiveAmmo(360, "SMG1");	Player:GiveAmmo(0, "SMG1_Grenade")
	Player:Give("weapon_ar2");		Player:GiveAmmo(240, "AR2");	Player:GiveAmmo(3, "AR2AltFire")
	Player:Give("weapon_shotgun");	Player:GiveAmmo(48, "Buckshot")
	Player:Give("weapon_crossbow");	Player:GiveAmmo(10, "XBowBolt")
	Player:Give("weapon_frag");		Player:GiveAmmo(5, "Grenade")
	Player:Give("weapon_slam");		Player:GiveAmmo(3, "slam")
	Player:Give("weapon_bugbait")
end

-- Joining players
BK.Team.Joining = {
	Name = "Joining",
	Color = Color(255, 255, 0),
	Noclip = false,
	Damage = false
}

function BK.Team.Joining.OnSpawn(Player)
	Player:GodEnable()
end

function BK.Team.Joining.OnLoadout(Player)
	Player:StripWeapons()
	Player:RemoveAllAmmo()
end
