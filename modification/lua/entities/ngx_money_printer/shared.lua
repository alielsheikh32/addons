ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Printers"
ENT.Author = "N"
ENT.Spawnable = false
ENT.AdminSpawnable = false

CFG = {}
//Values after printing
CFG.PrintExp = 10
CFG.PrintMoney = 500
CFG.PrintHeat = 2
//Limits
CFG.MaxHeat = 500
CFG.MaxStorage = 100000

CFG.LvlTbl = {}
CFG.LvlTbl[1] = { PrinterName = "Bronze", Clr = Color( 215, 170, 140, 255 ), PrintMul = 1, ExpReq = 0 }
CFG.LvlTbl[2] = { PrinterName = "Silver",  Clr = Color( 204, 204, 204, 255 ), PrintMul = 1.50, ExpReq = 250 }
CFG.LvlTbl[3] = { PrinterName = "Gold", Clr = Color( 255, 215, 0, 255 ), PrintMul = 2, ExpReq = 500 }
CFG.LvlTbl[4] = { PrinterName = "Diamond", Clr = Color( 175, 250, 255, 255 ), PrintMul = 3, ExpReq = 750, RankRestriction = {"vip", "respected", "supporter", "dmod", "trialmod", "moderator", "admin", "management", "superadmin"} }
CFG.LvlTbl[5] = { PrinterName = "Platinum", Clr = Color( 229, 228, 226, 255 ), PrintMul = 4, ExpReq = 1000, RankRestriction = {"respected", "supporter", "dmod", "trialmod", "moderator", "admin", "management", "superadmin"} }
CFG.Upgrades = {}
CFG.Upgrades["Speed"] = {}
CFG.Upgrades["Speed"][1] = { Mod = 25, Price = 100 }
CFG.Upgrades["Speed"][2] = { Mod = 50, Price = 200 }
CFG.Upgrades["Speed"][3] = { Mod = 75, Price = 300 }
CFG.Upgrades["Speed"][4] = { Mod = 100, Price = 400 }

CFG.Upgrades["Exp"] = {}
CFG.Upgrades["Exp"][1] = { Mod = 2, Price = 100 }
CFG.Upgrades["Exp"][2] = { Mod = 3, Price = 200 }
CFG.Upgrades["Exp"][3] = { Mod = 4, Price = 300 }
CFG.Upgrades["Exp"][4] = { Mod = 5, Price = 400 }

CFG.Upgrades["PrintMul"] = {}
CFG.Upgrades["PrintMul"][1] = { Mod = 1.00, Price = 100 }
CFG.Upgrades["PrintMul"][2] = { Mod = 1.25, Price = 200 }
CFG.Upgrades["PrintMul"][3] = { Mod = 1.50, Price = 300 }
CFG.Upgrades["PrintMul"][4] = { Mod = 2.00, Price = 400 }

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
end
