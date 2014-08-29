function NLRBox()


local titletext = "New Life Rule" --Here you can change the title of the box
local backgroundblur = true --Enable or disable blur around the box
local makedraggable = true --Here you can change if you want the box to be drag-gable by your mouse


local warningtext = [[You have just passed away, forget your past and move on. 
You must wait 5 minutes to return to where you previously died. 
If you choose to not follow this rule, you will be punished.]]
local lfont = "DermaDefault"


local timertext = "Please wait 10 seconds" --Here you can change the timer button text
local buttontext = "Continue" --Here you can change the spawn button text
local bfont = "Trebuchet18" -- Here you can change the button 
local tfont = "Trebuchet18" -- Here you can change the countdown font to whatever you would like
local timerwait = 10 --Here you can change how long you want to wait for the timer to countdown


local NFrame = vgui.Create( "DFrame" )
NFrame:SetPos( 350, 200)
NFrame:SetSize( 600, 200)
NFrame:SetTitle(titletext)
NFrame:SetBackgroundBlur( backgroundblur )
NFrame:SetVisible( true)
NFrame:SetDraggable(makedraggable) 
NFrame:ShowCloseButton( false ) 
NFrame.Paint = function()
	surface.SetDrawColor(47, 43, 43, 0 )
	surface.DrawRect( 0, 0, NFrame:GetWide(), NFrame:GetTall() )
end

NFrame:MakePopup() 


local NPanel = vgui.Create( "DPanel", NFrame )
NPanel:SetSize( 578, 150)
NPanel:SetPos( 10, 31)
NPanel.Paint = function()
	surface.SetDrawColor(47, 43, 43, 200 )
	surface.DrawRect( 0, 0, NPanel:GetWide(), NPanel:GetTall() )
end


local NLabel = vgui.Create( "DLabel", NPanel )
NLabel:SetPos(130, 20)
NLabel:SetText(warningtext) 
NLabel:SetFont(lfont)
NLabel:SetTextColor( Color( 229, 229, 229) ) 
NLabel:SizeToContents()


local NButton = vgui.Create( "DButton", NFrame )
NButton:SetPos( 210, 121 )
NButton:SetText(timertext)
NButton:SetFont(bfont)
NButton:SetTextColor( Color( 47, 43, 43 ) )
NButton:SetSize( 180, 30 )
NButton.Paint = function()
	surface.SetDrawColor( 0, 110, 160 )
	surface.DrawRect( 0, 0, NButton:GetWide(), NButton:GetTall() )
end
NButton:SetDisabled( true )
NButton.DoClick = function ()
	if NButton:GetDisabled() then
		return
	else
		NFrame:Close()
		RunConsoleCommand("nlrspawn")
	end
end


timer.Simple ( timerwait, function()
	NButton:SetDisabled(false)
	NButton:SetText(buttontext)
	NButton:SetFont(tfont)
end)


end
concommand.Add("drawnlrbox", NLRBox)