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
			RunConsoleCommand("ulx", "builder")
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
		function FighterPanel:Paint(w, h)
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
			RunConsoleCommand("ulx", "fighter")
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
		Footer:SetText("Use !builder or !fighter to change teams again")
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

hook.Add("HUDPaint", "BK",
	function ()
		local Position = LocalPlayer():GetPos()
		for _, Player in pairs(player.GetAll()) do
			if Player == LocalPlayer() and not Player:ShouldDrawLocalPlayer() then
				continue
			elseif not Player:Alive() then
				continue
			end

			local Team = Player:GetBKTeam()
			local PlayerPosition = Player:GetPos()
			if Team.TraceRequired then
				local TraceResult = util.TraceLine {
					start = EyePos(),
					endpos = Player:LocalToWorld(Vector(0, 0, 10)),
					filter = {Player, LocalPlayer(), Player:GetVehicle()},
					mins = Player:OBBMins(),
					maxs = Player:OBBMaxs(),
				}
				if TraceResult.Hit then
					continue
				end
			end

			local Clr = Player:GetColor()
			local Alpha = math.Clamp(3500 - Position:Distance(PlayerPosition), 0, 1020) / 4 * Clr.a / 255
			if Alpha > 0 then
				local WorldPosition = PlayerPosition + Vector(0, 0, 80)
				local ScreenPosition = WorldPosition:ToScreen()
				if ScreenPosition.visible then
					draw.SimpleTextOutlined(
						Team.Name,
						"HudFont",
						ScreenPosition.x,
						ScreenPosition.y - 50,
						ColorAlpha(Player:GetBKTeam().Color, Alpha),
						TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1,
						Color(0, 0, 0, Alpha)
					)
				end
			end
		end
	end
)
