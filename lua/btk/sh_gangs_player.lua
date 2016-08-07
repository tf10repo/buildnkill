local Player = FindMetaTable("Player")

function Player:GetBKGang()
	return self:GetNWString("BK_Gang") or "None"
end

function Player:SetBKGang(Gang)
	self:SetNWString("BK_Gang", Gang)
end

function Player:IsGangBuddy(Ply)
	local SelfGang = self:GetNWString("BK_Gang")
	local PlyGang = Ply:GetNWString("BK_Gang")
	if SelfGang and PlyGang then
		return SelfGang == PlyGang
	end
end