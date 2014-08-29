TOOL.Category		= "Frozen Odyssey"
TOOL.Name			= "#Textscreen"
TOOL.Command		= nil
TOOL.ConfigName		= ""

local TextBox = {}
local linelabels = {}
local labels = {}
local sliders = {}
for i = 1, 5 do
	TOOL.ClientConVar[ "text"..i ] = ""
	TOOL.ClientConVar[ "size"..i ] = 20
	TOOL.ClientConVar[ "r"..i ] = 255
	TOOL.ClientConVar[ "g"..i ] = 255
	TOOL.ClientConVar[ "b"..i ] = 255
	TOOL.ClientConVar[ "a"..i ] = 255
end

if (SERVER) then
	CreateConVar('sbox_maxtextscreens', 4)
end

cleanup.Register("textscreens")

if (CLIENT) then
	language.Add("Tool.textscreen.name", "SS Textscreen")
	language.Add("Tool.textscreen.desc", "Create a textscreen with multiple lines, font colours and sizes.")	

	language.Add("Tool.textscreen.0", "Left Click: Spawn a textscreen Right Click: Update textscreen with settings")
	language.Add("Tool_textscreen_0", "Left Click: Spawn a textscreen Right Click: Update textscreen with settings")

	language.Add("Undone.textscreens", "Undone textscreen")
	language.Add("Undone_textscreens", "Undone textscreen")
	language.Add("Cleanup.textscreens", "Textscreens")
	language.Add("Cleanup_textscreens", "Textscreens")
	language.Add("Cleaned.textscreens", "Cleaned up all textscreens")
	language.Add("Cleaned_textscreens", "Cleaned up all textscreens")
	
	language.Add("SBoxLimit.textscreens", "You've hit the textscreen limit!")
	language.Add("SBoxLimit_textscreens", "You've hit the textscreen limit!")
end

function TOOL:LeftClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local Ply = self:GetOwner()
	local Text = {}
	local color = {}
	local size = {}
	for i = 1, 5 do
		table.insert(Text, i, self:GetClientInfo("text"..i))
		table.insert(color, i, Color(tonumber(self:GetClientInfo("r"..i)), tonumber(self:GetClientInfo("g"..i)), tonumber(self:GetClientInfo("b"..i)), tonumber(self:GetClientInfo("a"..i))))
		table.insert(size, i, tonumber(self:GetClientInfo("size"..i)))
	end

	local SpawnPos = tr.HitPos
	
	if not (self:GetWeapon():CheckLimit("textscreens")) then return false end

	local TextScreen = ents.Create("sammyservers_textscreen")
	TextScreen:SetPos(SpawnPos)
	TextScreen:Spawn()
	TextScreen:UpdateText(Text, color, size)
	local angle = tr.HitNormal:Angle()
	angle:RotateAroundAxis(tr.HitNormal:Angle():Right(), -90)
	angle:RotateAroundAxis(tr.HitNormal:Angle():Forward(), 90)
	TextScreen:SetAngles(angle)
	TextScreen:Activate()
	
	undo.Create("textscreens")

	undo.AddEntity(TextScreen)
	undo.SetPlayer(Ply)
	undo.Finish()

	Ply:AddCount("textscreens", TextScreen)
	Ply:AddCleanup("textscreens", TextScreen)

	return true
end

function TOOL:RightClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local Ply = self:GetOwner()
	local Text = {}
	local color = {}
	local size = {}
	for i = 1, 5 do
		table.insert(Text, i, self:GetClientInfo("text"..i))
		table.insert(color, i, Color(tonumber(self:GetClientInfo("r"..i)), tonumber(self:GetClientInfo("g"..i)), tonumber(self:GetClientInfo("b"..i)), tonumber(self:GetClientInfo("a"..i))))
		table.insert(size, i, tonumber(self:GetClientInfo("size"..i)))
	end

	local TraceEnt = tr.Entity

	if (TraceEnt:IsValid() and TraceEnt:GetClass() == "sammyservers_textscreen") then
		TraceEnt:UpdateText(Text, color, size)
		return true
	end
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {	Text = "#Tool.textscreen.name", Description	= "#Tool.textscreen.desc" } )
	CPanel:AddControl("Label", {	Text = "From SammyServers.com\nVisit us online for some awesomely fun game servers!" } )
	resetall = vgui.Create("DButton", resetbuttons)
	resetall:SetSize(100, 25)	
	resetall:SetText("Reset all")
	resetall.DoClick = function()
		local menu = DermaMenu()
		menu:AddOption("Reset colors", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
			end
		end)
		menu:AddOption("Reset sizes", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
			end			
		end)
		menu:AddOption("Reset textboxes", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_text"..i, "")
				TextBox[i]:SetValue("")
			end
		end)
		menu:AddOption("Reset everything", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
				RunConsoleCommand("textscreen_text"..i, "")
				TextBox[i]:SetValue("")
			end
		end)
		menu:Open()
	end
	CPanel:AddItem(resetall)
	resetline = vgui.Create("DButton")
	resetline:SetSize(100, 25)	
	resetline:SetText("Reset line")
	resetline.DoClick = function()
		local menu = DermaMenu()
		for i = 1, 5 do
			menu:AddOption("Reset line "..i, function()
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
				RunConsoleCommand("textscreen_text"..i, "")
				TextBox[i]:SetValue("")
			end)
		end
		menu:AddOption("Reset all lines", function()
			for i = 1, 5 do
				RunConsoleCommand("textscreen_r"..i, 255)
				RunConsoleCommand("textscreen_g"..i, 255)
				RunConsoleCommand("textscreen_b"..i, 255)
				RunConsoleCommand("textscreen_a"..i, 255)
				RunConsoleCommand("textscreen_size"..i, 20)
				sliders[i]:SetValue(20)
				RunConsoleCommand("textscreen_text"..i, "")
				TextBox[i]:SetValue("")
			end			
		end)
		menu:Open()
	end
	CPanel:AddItem(resetline)

	for i = 1, 5 do
		linelabels[i] = CPanel:AddControl("Label", {
			Text = "Line "..i,
			Description = "Line "..i
		})
		linelabels[i]:SetFont("Default")
		CPanel:AddControl("Color", {
			Label = "Line "..i.." font color",
			Red = "textscreen_r"..i,
			Green = "textscreen_g"..i,
			Blue = "textscreen_b"..i,
			Alpha = "textscreen_a"..i,
			ShowHSV = 1,
			ShowRGB = 1,
			Multiplier = 255
		})
		sliders[i] = vgui.Create("DNumSlider")
		sliders[i]:SetText("Font size")
		sliders[i]:SetMinMax(20, 100)
		sliders[i]:SetDecimals(0)
		sliders[i]:SetValue(20)
		sliders[i]:SetConVar("textscreen_size"..i)
		sliders[i].OnValueChanged = function(panel, value)
			labels[i]:SetFont("CV"..math.Round(value))
		end
		CPanel:AddItem(sliders[i])
		TextBox[i] = vgui.Create("DTextEntry")
		TextBox[i]:SetUpdateOnType(true)
		TextBox[i]:SetEnterAllowed(true)
		TextBox[i]:SetConVar("textscreen_text"..i)
		TextBox[i]:SetValue(GetConVarString("textscreen_text"..i))
		TextBox[i].OnTextChanged = function()
			labels[i]:SetText(TextBox[i]:GetValue())
		end
		CPanel:AddItem(TextBox[i])
		labels[i] = CPanel:AddControl("Label", {
			Text = "Line "..i,
			Description = "Line "..i
		})
		labels[i]:SetFont("Default")
		labels[i].Think = function()
			labels[i]:SetColor(Color(GetConVarNumber("textscreen_r"..i), GetConVarNumber("textscreen_g"..i), GetConVarNumber("textscreen_b"..i), GetConVarNumber("textscreen_a"..i)))
		end
	end
end
