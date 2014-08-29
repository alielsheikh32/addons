MODERN.Theme = {}
--
-- Modern MOTD Theme
--

MODERN.Theme.WindowColor = Color(26, 30, 38, 0) --Main window color
MODERN.Theme.ControlColor = Color( 5, 60, 169, 150 ) --Main window control color
MODERN.Theme.BannerMaterial = Material("modernmotd/bannerstripefull.png") --Banner material
MODERN.Theme.BannerColor = Color(0, 0, 0, 100) --Banner material, default is blue
MODERN.Theme.ScrollerTextColor = color_white --Scrolling text color

MODERN.Settings = {}
--
-- Modern MOTD Settings
--
MODERN.Settings.MOTDTitle = "Frozen Odyssey DarkRP" --Main title
MODERN.Settings.TextTabFont = "OpenSans18Font" --Font used in text tabs
MODERN.Settings.ShowOnPlayerConnect = true --Open MOTD when players connect
MODERN.Settings.ShowOnPlayerConnectWaitSeconds = 0 --Time before menu can be closed when players first connect
MODERN.Settings.OpenTab = 1 --Which tab to open automatically

MODERN.Settings.MenuSounds = true --Play the menu sounds?
MODERN.Settings.ButtonClickSound = "modernmotd/open.wav" --Menu button sound
MODERN.Settings.MenuOpenSound = "modernmotd/open.wav" --Menu open sound
MODERN.Settings.MenuCloseSound = "modernmotd/close.wav" --Menu close sound

MODERN.Settings.ShowAvatar = false --Show the user avatar in the menu
MODERN.Settings.ShowPlayerName = true --Show the user name in the menu

--Change chat command to "" to disable the chat command
MODERN.ChatCommand = "!motd"
--You can set the FKeyBind to F1,F2,F3 or F4 and change to "" to disable FKeyBind
MODERN.Settings.FKeyBind = "F1"
MODERN.Settings.CloseOnFKeyBind = true


--
-- Modern MOTD Scroller
--
if CLIENT then
MODERN.ScrollerSpeed = 50 --Speed of scrolling text
MODERN.ScrollerWidth = ScrW() - 20
MODERN.ScrollerYPos = ScrH() - 75
MODERN.ScrollerFont = "OpenSans18Font" --Scrolling Text Font
--Scrolling text
MODERN.ScrollerText = ""
end