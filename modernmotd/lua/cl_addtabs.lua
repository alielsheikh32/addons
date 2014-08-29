--Modify built in tabs or add your own custom tabs here

--AddMOTDTab("MOTD", {
	--subtitle = "Message of the day",
	--color = Color(51,102,255),
	--icon = "modernmotd/ico-monitor.png",
	--url = "http://www.garrysmod.com/2013/07/05/13-07-05/"
--})

--Set the serverlist = true option in a tab to
--have it open the serverlist based on the server you add in cl_addservers.lua
--AddMOTDTab("Server Portal", {
--	subtitle = "Join our other servers through here",
	--color = Color(153,0,153),
	--icon = "modernmotd/ico-gmod.png",
--	serverlist = true
--})

AddMOTDTab("Server Rules", {
	subtitle = "All server rules will be listed here",
	color = Color(51,102,255),
	icon = "modernmotd/rules.png",
	url = "http://frozenodyssey.com/index.php?topic=11354.0"
})

AddMOTDTab("Close", {
	color = Color(51,102,255),
	icon = "modernmotd/exit.png",
	close = "close"
})