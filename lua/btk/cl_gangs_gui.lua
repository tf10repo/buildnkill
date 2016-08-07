local PANEL = {}

PANEL.BackgroundColor = Color(80, 80, 80, 255)
PANEL.BorderColor = Color(30, 30, 30, 255)

function PANEL:Init()
	self:SetTitle("Build'n'Kill Gangs")
	self:SetSize(1000, 500)
	self:SetVisible(true)
	self:Center()
	self:MakePopup()
	
	self.Sheet = vgui.Create("DPropertySheet", self)
	self.Sheet:Dock(FILL)
	
	self.JoinPanel = vgui.Create("DPanel", self.Sheet)
	self.Sheet:AddSheet("Join or Create a Gang", self.JoinPanel)
	
	function self.JoinPanel:Paint(w, h)
		surface.SetDrawColor(Color(150, 150, 150))
		surface.DrawRect(1, 1, w - 2, h - 2)
		
		surface.SetDrawColor(Color(80, 80, 80))
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	
	self.CreateLabel = vgui.Create("DLabel", self.JoinPanel)
	self.CreateLabel:SetText("Create a gang")
	self.CreateLabel:SetFont("SmallFont")
	self.CreateLabel:SetColor(Color(0, 255, 0))
	self.CreateLabel:SetPos(80, 20)
	self.CreateLabel:SetSize(200, 25)
	
	self.GangPanel = vgui.Create("DPanel", self.JoinPanel)
	self.GangPanel:SetPos(20, 55)
	self.GangPanel:SetSize(300, 210)
	
	self.GangNameLabel = vgui.Create("DLabel", self.GangPanel)
	self.GangNameLabel:SetText("Name")
	self.GangNameLabel:SetPos(10, 5)
	self.GangNameLabel:SetColor(Color(80, 80, 80))
	
	self.GangColorLabel = vgui.Create("DLabel", self.GangPanel)
	self.GangColorLabel:SetText("Color")
	self.GangColorLabel:SetPos(10, 60)
	self.GangColorLabel:SetColor(Color(80, 80, 80))
	
	self.GangName = vgui.Create("DTextEntry", self.GangPanel)
	self.GangName:SetPos(10, 25)
	self.GangName:SetSize(260, 20)
	
	self.Color = {}
	self.Color.RedLabel = vgui.Create("DLabel", self.GangPanel)
	self.Color.RedLabel:SetText("Red")
	self.Color.RedLabel:SetColor(Color(255, 0, 0))
	self.Color.RedLabel:SetPos(10, 90)
	
	self.Color.GreenLabel = vgui.Create("DLabel", self.GangPanel)
	self.Color.GreenLabel:SetText("Green")
	self.Color.GreenLabel:SetColor(Color(0, 255, 0))
	self.Color.GreenLabel:SetPos(10, 120)
	
	self.Color.BlueLabel = vgui.Create("DLabel", self.GangPanel)
	self.Color.BlueLabel:SetText("Blue")
	self.Color.BlueLabel:SetColor(Color(0, 0, 255))
	self.Color.BlueLabel:SetPos(10, 150)
	
	self.Color.R = vgui.Create("Slider", self.GangPanel)
	self.Color.R:SetPos(40, 85)
	self.Color.R:SetWide(150)
	self.Color.R:SetMin(0)
	self.Color.R:SetMax(255)
	self.Color.R:SetDecimals(0)
	
	self.Color.G = vgui.Create("Slider", self.GangPanel)
	self.Color.G:SetPos(40, 115)
	self.Color.G:SetWide(150)
	self.Color.G:SetMin(0)
	self.Color.G:SetMax(255)
	self.Color.G:SetDecimals(0)
	
	self.Color.B = vgui.Create("Slider", self.GangPanel)
	self.Color.B:SetPos(40, 145)
	self.Color.B:SetWide(150)
	self.Color.B:SetMin(0)
	self.Color.B:SetMax(255)
	self.Color.B:SetDecimals(0)
	
	self.Color.Panel = vgui.Create("DPanel", self.GangPanel)
	self.Color.Panel:SetPos(180, 95)
	self.Color.Panel:SetSize(100, 80)
	
	function self.Color.Panel.Paint(s, w, h)
		surface.SetDrawColor(Color(self.Color.R:GetValue(), self.Color.G:GetValue(), self.Color.B:GetValue()))
		surface.DrawRect(1, 1, w - 2, h - 2)
		
		surface.SetDrawColor(Color(80, 80, 80, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	
	self.GangCreateButton = vgui.Create("DButton", self.GangPanel)
	self.GangCreateButton:SetText("Create")
	self.GangCreateButton:SetPos(10, 180)
	self.GangCreateButton:SetSize(100, 20)
	
	self.JoinLabel = vgui.Create("DLabel", self.JoinPanel)
	self.JoinLabel:SetText("Join a gang")
	self.JoinLabel:SetFont("SmallFont")
	self.JoinLabel:SetColor(Color(0, 255, 0))
	self.JoinLabel:SetPos(380, 20)
	self.JoinLabel:SetSize(200, 25)
	
	self.JoinGangPanel = vgui.Create("DPanel", self.JoinPanel)
	self.JoinGangPanel:SetPos(340, 55)
	self.JoinGangPanel:SetSize(600, 250)
	
	self.GangList = vgui.Create("DListView", self.JoinGangPanel)
	self.GangList:SetPos(10, 5)
	self.GangList:SetSize(280, 200)
	self.GangList:AddColumn("Gangs")
	
	function self.GangList.OnClickLine(s, Line, IsSelected)
		self.GangMembersList:Clear()
		for Index, Member in pairs(s:GetLine(Line).Gang.Members) do
			self.GangMembersList:AddLine(Member:GetName())
		end
	end
	
	self.GangMembersList = vgui.Create("DListView", self.JoinGangPanel)
	self.GangMembersList:SetPos(300, 5)
	self.GangMembersList:SetSize(280, 200)
	self.GangMembersList:AddColumn("Members")
	
	self:UpdateGangs()
end

function PANEL:UpdateGangs()
	if BK.Gangs then
		self.GangList:Clear()
		for Name, Gang in pairs(BK.Gangs) do
			self.GangList:AddLine(Gang.Name).Gang = Gang
		end
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(self.BackgroundColor)
	surface.DrawRect(1, 1, w - 2, h - 2)
	
	surface.SetDrawColor(self.BorderColor)
	surface.DrawOutlinedRect(0, 0, w, h)
end

vgui.Register("bk_gangs_panel", PANEL, "DFrame")

concommand.Add("choosebkgang",
	function ()
		if IsValid(BK.GangsPanel) then
			BK.GangsPanel:Remove()
		end
		BK.GangsPanel = vgui.Create("bk_gangs_panel")
	end
)