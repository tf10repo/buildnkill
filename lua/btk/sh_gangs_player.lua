local Player = FindMetaTable("Player")

function Player:GetBKGang()
	return self:GetNWString("BK_Gang") or "None"
end

function Player:SetBKGang(Gang)
	self:SetNWString("BK_Gang", Gang)
end
