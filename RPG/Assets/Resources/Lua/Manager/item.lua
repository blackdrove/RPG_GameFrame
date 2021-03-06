local self = {}
self.__index = self

self.itemBag_1 = {}  --任务道具背包(不可叠加，不可重复)
self.itemBag_2 = {}  --消耗道具背包(可叠加，不可重复)

self.equipBag_1 = {}
self.equipBag_2 = {}
self.equipBag_3 = {}
self.equipBag_4 = {}
self.equipBag_5 = {}
self.equipBag_6 = {}

local function ClearAllBag()
	self.itemBag_1 = {}
	self.itemBag_2 = {}
	self.equipBag_1 = {}
	self.equipBag_2 = {}
	self.equipBag_3 = {}
	self.equipBag_4 = {}
	self.equipBag_5 = {}
	self.equipBag_6 = {}
end

local function IsTableHasKey(tb, id)
	for k, v in pairs(tb)do
		if k == id then
			return true
		end
	end
	return false
end

function self:GetItemBag(i)
	if i == 1 then
		return self.itemBag_1
	elseif i == 2 then
		return self.itemBag_2
	end
end

function self:GetEquipBag(i)
	if i == 1 then
		return self.equipBag_1
	elseif i == 2 then
		return self.equipBag_2
	elseif i == 3 then
		return self.equipBag_3
	elseif i == 4 then
		return self.equipBag_4
	elseif i == 5 then
		return self.equipBag_5
	elseif i == 6 then
		return self.equipBag_6
	end
end

function self:Init()
	ClearAllBag()
end

function self:AddEquip(id)
	local data = GlobalHooks.dataReader:FindData("equip", id)
	if data["SLOT"] == "1" then
		table.insert(self.equipBag_1, data["ID"])
	elseif data["SLOT"] == "2" then
		table.insert(self.equipBag_2, data["ID"])
	elseif data["SLOT"] == "3" then
		table.insert(self.equipBag_3, data["ID"])
	elseif data["SLOT"] == "4" then
		table.insert(self.equipBag_4, data["ID"])
	elseif data["SLOT"] == "5" then
		table.insert(self.equipBag_5, data["ID"])
	elseif data["SLOT"] == "6" then
		table.insert(self.equipBag_6, data["ID"])
	end
end

function self:AddItem(id, count)
	local data = GlobalHooks.dataReader:FindData("item", id)
	if data["ITEMTYPE"] == "1" then
		self.itemBag_1[data["ID"]] = 1
	elseif data["ITEMTYPE"] == "2" then
		if(IsTableHasKey(self.itemBag_2, data["ID"]))then
			self.itemBag_2[data["ID"]] = self.itemBag_2[data["ID"]] + count
		else
			self.itemBag_2[data["ID"]] = count
		end
	end
end

function self:ConsumeItem(id, count)  --使用消耗品
	if(self.itemBag_2[id] and self.itemBag_2[id] >= count)then
		local data = GlobalHooks.dataReader:FindData("item", id)
		self.itemBag_2[id] = self.itemBag_2[id] - count
		GlobalHooks.uiUitls:ShowFloatingMsg(GetText(data["NAME"]) .." - "..count)
		if GlobalHooks.eventManager == nil then
			print("eventManager == nil")
		else
		end
		GlobalHooks.eventManager:Broadcast("Item.UpdateItemCount", {})
	else
		GlobalHooks.uiUitls:ShowFloatingMsg(GetText("Tip_NotEnoughItems"))
	end
end

return self