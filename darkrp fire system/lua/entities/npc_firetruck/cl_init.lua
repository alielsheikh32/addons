include("shared.lua")

surface.CreateFont("FiretruckFont", {
	font = "Tahoma", 
	size = 15, 
	weight = 600
})

surface.CreateFont("Trebuchet20", {
	font = "Trebuchet MS", 
	size = 18, 
	weight = 900
})

surface.CreateFont("UiBold", {
	font = "Tahoma", 
	size = 20, 
	weight = 600
})

function FIRE_Firetruck_Menu()
	
	local GUI_Truck_Frame = vgui.Create("DFrame")
	GUI_Truck_Frame:SetTitle("")
	GUI_Truck_Frame:SetSize(450,220)
	GUI_Truck_Frame:Center()
	GUI_Truck_Frame.Paint = function(CHPaint)
		-- Draw the menu background color.		
		draw.RoundedBox( 0, 0, 25, CHPaint:GetWide(), CHPaint:GetTall(), Color( 255, 255, 255, 150 ) )

		-- Draw the outline of the menu.
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0, 0, CHPaint:GetWide(), CHPaint:GetTall())
	
		draw.RoundedBox( 0, 0, 0, CHPaint:GetWide(), 25, Color( 255, 255, 255, 200 ) )
		
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0, 0, CHPaint:GetWide(), 25)

		-- Draw the top title.
		draw.SimpleText("Firetruck Station", "FiretruckFont", 62,12.5, Color(70,70,70,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	GUI_Truck_Frame:MakePopup()
	GUI_Truck_Frame:ShowCloseButton(true)
	
	local TruckDisplay = vgui.Create("DModelPanel", GUI_Truck_Frame)
	TruckDisplay:SetModel( FIRETRUCK_VehicleModel )
	TruckDisplay:SetPos( 90, 0 )
	TruckDisplay:SetSize( 290, 290 )
	TruckDisplay:GetEntity():SetAngles(Angle(255, 255, 255))
	TruckDisplay:SetCamPos( Vector( 255, 255, 80 ) )
	TruckDisplay:SetLookAt( Vector( 0, 0, 0 ) )
	
	local GUI_GetTruck = vgui.Create("DButton", GUI_Truck_Frame)	
	GUI_GetTruck:SetSize(200,25)
	GUI_GetTruck:SetPos(20,190)
	GUI_GetTruck:SetText("")
	GUI_GetTruck.Paint = function()
		draw.RoundedBox(8,1,1,GUI_GetTruck:GetWide()-2,GUI_GetTruck:GetTall()-2,Color(0, 0, 0, 130))

		local struc = {}
		struc.pos = {}
		struc.pos[1] = 100 -- x pos
		struc.pos[2] = 12.5 -- y pos
		struc.color = Color(255,255,255,255) -- Red
		struc.text = "Retrieve Firetruck" -- Text
		struc.font = "UiBold" -- Font
		struc.xalign = TEXT_ALIGN_CENTER-- Horizontal Alignment
		struc.yalign = TEXT_ALIGN_CENTER -- Vertical Alignment
		draw.Text( struc )
	end
	
	GUI_GetTruck.DoClick = function()
		net.Start("FIRE_CreateFireTruck")
		net.SendToServer()
		
		GUI_Truck_Frame:Remove()
	end
	
	local GUI_LeaveMenu = vgui.Create("DButton", GUI_Truck_Frame)	
	GUI_LeaveMenu:SetSize(200,25)
	GUI_LeaveMenu:SetPos(225,190)
	GUI_LeaveMenu:SetText("")
	GUI_LeaveMenu.Paint = function()
		draw.RoundedBox(8,1,1,GUI_LeaveMenu:GetWide()-2,GUI_LeaveMenu:GetTall()-2,Color(0, 0, 0, 130))

		local struc = {}
		struc.pos = {}
		struc.pos[1] = 100 -- x pos
		struc.pos[2] = 12.5 -- y pos
		struc.color = Color(255,255,255,255) -- Red
		struc.text = "Leave Station" -- Text
		struc.font = "UiBold" -- Font
		struc.xalign = TEXT_ALIGN_CENTER-- Horizontal Alignment
		struc.yalign = TEXT_ALIGN_CENTER -- Vertical Alignment
		draw.Text( struc )
	end
	
	GUI_LeaveMenu.DoClick = function()
		GUI_Truck_Frame:Remove()
	end
end
usermessage.Hook("FIRE_FiretruckMenu", FIRE_Firetruck_Menu)