if CLIENT or engine.ActiveGamemode() == "sandbox" then
	local BK = {
		Team = {}
	}

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

	BK.Team.Fighter = {
		Name = "Fighter",
		Color = Color(255, 50, 50),
		Noclip = false,
		Damage = true
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

	local PlayerENT = FindMetaTable("Player")

	function PlayerENT:GetBKTeam()
		return BK.Team[self.BK_Team or "Builder"]
	end

	if SERVER then
		local bk_prechangeteam_delay = CreateConVar("bk_prechange_team_delay", "10", {FCVAR_ARCHIVE})
		local bk_postchangeteam_delay = CreateConVar("bk_postchange_team_delay", "3", {FCVAR_ARCHIVE})

		function PlayerENT:SetBKTeam(Name)
			local TeamTable = BK.Team[Name]
			if not TeamTable then
				return false
			end

			if self.BK_Team == Name then
				ULib.tsay(self, "You're already in that team.", true)
				return false
			end

			if not self.BK_LastChangeTeam or self.BK_LastChangeTeam + bk_prechangeteam_delay:GetInt() < CurTime() then
				self.BK_LastChangeTeam = CurTime()
			else
				ULib.tsay(self, "Wait "..math.ceil(self.BK_LastChangeTeam + bk_prechangeteam_delay:GetInt() - CurTime()).."s before changing team again.")
				return false
			end
			if bk_postchangeteam_delay:GetInt() > 0 then
				ULib.tsay(self, "You will change your team to "..TeamTable.Name.." in "..bk_postchangeteam_delay:GetInt().." seconds")
			end
			timer.Create("bk_"..self:UniqueID(), bk_postchangeteam_delay:GetInt(), 1,
				function ()
					if self:IsValid() then
						self.BK_Team = Name
						TeamTable.OnLoadout(self)
						TeamTable.OnSpawn(self)
						ulx.fancyLogAdmin(self, "#A switched to team #s", Name)
					end
				end
			)
			self:StripWeapons()
			self:RemoveAllAmmo()
		end

		hook.Add("PlayerShouldTakeDamage", "BK",
			function (Player, Attacker)
				if not IsValid(Player) or not Player:IsPlayer() then
					return nil
				elseif not IsValid(Attacker) or not Attacker:IsPlayer() then
					return nil
				elseif Player:GetBKTeam().Damage and Attacker:GetBKTeam().Damage then
					return true
				end
				return false
			end
		)

		hook.Add("PlayerSpawn", "BK",
			function (Player)
				Player:GetBKTeam().OnSpawn(Player)
			end
		)

		hook.Add("PlayerLoadout", "BK",
			function (Player)
				Player:GetBKTeam().OnLoadout(Player)
			end
		)

		hook.Add("ULibLocalPlayerReady", "BK",
			function(Player)
				Player:ConCommand("choosebkteam")
			end
		)
	end

	hook.Add("PlayerNoClip", "BK",
		function (Player, Active)
			if not Active then
				return true
			elseif Player:GetBKTeam().Noclip then
				return true
			end
			return false
		end
	)

	function BK.Build(Player)
		Player:SetBKTeam("Builder")
	end

	function BK.Fight(Player)
		Player:SetBKTeam("Fighter")
	end

	local BuildCommand = ulx.command("Fun", "ulx build", BK.Build, "!build")
	FightCommand:defaultAccess(ULib.ACCESS_ALL)
	FightCommand:help("Switch team to Builder")

	local FightCommand = ulx.command("Fun", "ulx fight", BK.Fight, "!fight")
	FightCommand:defaultAccess(ULib.ACCESS_ALL)
	FightCommand:help("Switch team to Fighter")
end

if CLIENT then
	surface.CreateFont("SmallFont", {font = "roboto", size = 24})
	surface.CreateFont("MediumFont", {font = "roboto", size = 32})
	surface.CreateFont("BigFont", {font = "roboto", size = 64})
	surface.CreateFont("HudFont", {font = "Arial", size = 16, weight = 500, antialias 	= true, additive = true})

	concommand.Add("choosebkteam",
		function()
			if IsValid(Picker) then
				Picker:Remove()
			end
			Picker = vgui.Create("DPanel")
			Picker:SetSize(470, 250)
			Picker:SetVisible(true)
			Picker:Center()
			Picker:MakePopup()
			function Picker:Paint(w, h)
				surface.SetDrawColor(Color(100, 100, 170, 255))
				surface.DrawRect(1, 1, w - 2, h - 2)
				surface.SetDrawColor(Color(48, 48, 48, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local Caption = vgui.Create("DLabel", Picker)
			Caption:SetText("Select your team")
			Caption:SetColor(Color(255, 255, 0, 255))
			Caption:SetFont("MediumFont")
			Caption:SetContentAlignment(5)
			Caption:SizeToContents()
			Caption:SetTall(48)
			Caption:Dock(TOP)
			function Caption:Paint(w, h)
				surface.SetDrawColor(Color(100, 100, 170, 255))
				surface.DrawRect(1, 1, w - 2, h - 2)
				surface.SetDrawColor(Color(48, 48, 48, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local Divider = vgui.Create("DHorizontalDivider", Picker)
			Divider:Dock(FILL)

			local BuilderPanel = vgui.Create("DPanel", Divider)
			function BuilderPanel:Paint(w, h)
				surface.SetDrawColor(Color(100, 100, 170, 255))
				surface.DrawRect(1, 1, w - 2, h - 2)
				surface.SetDrawColor(Color(48, 48, 48, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local BuilderButton = vgui.Create("DButton", BuilderPanel)
			BuilderButton:Dock(TOP)
			BuilderButton:SetText("Builder")
			BuilderButton:SetColor(BK.Team.Builder.Color)
			BuilderButton:SetFont("BigFont")
			BuilderButton:SetTall(80)
			function BuilderButton.DoClick(self)
				RunConsoleCommand("ulx", "build")
				Picker:Remove()
			end

			local BuilderLabel1 = vgui.Create("DLabel", BuilderPanel)
			BuilderLabel1:SetText("NoClip enabled")
			BuilderLabel1:SetColor(Color(80, 180, 150))
			BuilderLabel1:SetFont("SmallFont")
			BuilderLabel1:SetContentAlignment(5)
			BuilderLabel1:SizeToContents()
			BuilderLabel1:SetTall((Picker:GetTall() - 70 - 48 - 32)/4)
			BuilderLabel1:Dock(TOP)

			local BuilderLabel2 = vgui.Create("DLabel", BuilderPanel)
			BuilderLabel2:SetText("No weapons")
			BuilderLabel2:SetColor(Color(80, 180, 150))
			BuilderLabel2:SetFont("SmallFont")
			BuilderLabel2:SetContentAlignment(5)
			BuilderLabel2:SizeToContents()
			BuilderLabel2:SetTall((Picker:GetTall() - 70 - 48 - 32)/4)
			BuilderLabel2:Dock(TOP)

			local BuilderLabel3 = vgui.Create("DLabel", BuilderPanel)
			BuilderLabel3:SetText("Damage disabled")
			BuilderLabel3:SetColor(Color(80, 180, 150))
			BuilderLabel3:SetFont("SmallFont")
			BuilderLabel3:SetContentAlignment(5)
			BuilderLabel3:SizeToContents()
			BuilderLabel3:SetTall((Picker:GetTall() - 70 - 48 - 32)/4)
			BuilderLabel3:Dock(TOP)

			local FighterPanel = vgui.Create("DPanel", Divider)
			function FigtherPanel:Paint(w, h)
				surface.SetDrawColor(Color(100, 100, 170, 255))
				surface.DrawRect(1, 1, w - 2, h - 2)
				surface.SetDrawColor(Color(48, 48, 48, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local FighterButton = vgui.Create("DButton", FighterPanel)
			FighterButton:Dock(TOP)
			FighterButton:SetText("Fighter")
			FighterButton:SetColor(BK.Team.Fighter.Color)
			FighterButton:SetFont("BigFont")
			FighterButton:SetTall(80)
			function FighterButton.DoClick(self)
				RunConsoleCommand("ulx", "fight")
				Picker:Remove()
			end

			local FighterLabel1 = vgui.Create("DLabel", FighterPanel)
			FighterLabel1:SetText("NoClip disabled")
			FighterLabel1:SetColor(Color(190, 150, 80))
			FighterLabel1:SetFont("SmallFont")
			FighterLabel1:SetContentAlignment(5)
			FighterLabel1:SizeToContents()
			FighterLabel1:SetTall((Picker:GetTall() - 70 - 48 - 32)/4)
			FighterLabel1:Dock(TOP)

			local FighterLabel2 = vgui.Create("DLabel", FighterPanel)
			FighterLabel2:SetText("All weapons")
			FighterLabel2:SetColor(Color(190, 150, 80))
			FighterLabel2:SetFont("SmallFont")
			FighterLabel2:SetContentAlignment(5)
			FighterLabel2:SizeToContents()
			FighterLabel2:SetTall((Picker:GetTall() - 70 - 48 - 32)/4)
			FighterLabel2:Dock(TOP)

			local FighterLabel3 = vgui.Create("DLabel", FighterPanel)
			FighterLabel3:SetText("Damage enabled")
			FighterLabel3:SetColor(Color(190, 150, 80))
			FighterLabel3:SetFont("SmallFont")
			FighterLabel3:SetContentAlignment(5)
			FighterLabel3:SizeToContents()
			FighterLabel3:SetTall((Picker:GetTall() - 70 - 48 - 32)/4)
			FighterLabel3:Dock(TOP)

			Divider:SetLeft(BuilderPanel)
			Divider:SetRight(FighterPanel)
			Divider:SetDividerWidth(0)
			function Divider:Paint(w, h)
				surface.SetDrawColor(Color(100, 100, 170, 255))
				surface.DrawRect(1, 1, w - 2, h - 2)
				surface.SetDrawColor(Color(48, 48, 48, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			function Divider:Think()
				self:SetLeftWidth(self:GetWide()/2)
			end

			local Footer = vgui.Create("DLabel", Picker)
			Footer:SetText("Use !build or !kill to change teams again")
			Footer:SetColor(Color(255, 255, 0))
			Footer:SetFont("SmallFont")
			Footer:SetContentAlignment(5)
			Footer:SizeToContents()
			Footer:SetTall(32)
			Footer:Dock(BOTTOM)
			function Footer:Paint(w, h)
				surface.SetDrawColor(Color(100, 100, 170, 255))
				surface.DrawRect(1, 1, w - 2, h - 2)
				surface.SetDrawColor(Color(48, 48, 48, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
	)

	hook.Add("HUDPaint", "BK", function()
		local Position = LocalPlayer():GetPos()
		for _, Player in pairs(player.GetAll()) do
			if Player == LocalPlayer() and not Player:ShouldDrawLocalPlayer() then
				continue
			elseif not ply:Alive() then
				continue
			end

			local PlayerPosition = Player:GetPos()
			local Alpha = math.Clamp(3500 - Position:Distance(PlayerPosition), 0, 510)
			if Alpha > 0 then
				local WorldPosition = PlayerPosition + Vector(0, 0, 80)
				local ScreenPosition = WorldPosition:ToScreen()
				if ScreenPosition.visible then
					draw.SimpleTextOutlined(
						Player:GetBKTeam().Name,
						"HudFont",
						ScreenPosition.x,
						ScreenPosition.y - 50,
						ColorAlpha(Player:GetBKTeam().Color, Alpha),
						TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1,
						Color(0, 0, 0, alpha)
					)
				end
			end
		end
	end)
end
