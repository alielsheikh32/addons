--Modern MOTD Tabs
-- This is not the file to add your own tabs, this file processes the tabs
-- See cl_addtabs.lua to easily add your own tabs to the MOTD
MODERN.Tabs = {}
function AddMOTDTab(title, tabsettings)
	if not title or not istable(tabsettings) or not tabsettings.color then
		ErrorNoHalt("Invalid MOTD Tab: " .. title .. " settings missing or invalid.")
	return end
	
	if not tabsettings.url and not tabsettings.steamurl and not tabsettings.panel 
	and not tabsettings.text and not tabsettings.serverlist and not tabsettings.close then
		ErrorNoHalt("Invalid MOTD Tab: '" .. title .. "' no URL or panel specified or invalid.")
	return end

	table.insert(MODERN.Tabs, { title = title, settings = tabsettings})
end

-- This is not the file to add your own servers, this file processes the servers
-- See cl_addservers.lua to easily add your own servers to the MOTD
MODERN.Servers = {}
function AddMOTDServer(title, serversettings)
	if not title or not istable(serversettings) or not serversettings.color then
		ErrorNoHalt("Invalid MOTD Server: " .. title .. " settings missing or invalid.")
	return end
	
	if not serversettings.serveripport then
		ErrorNoHalt("Invalid MOTD Server: '" .. title .. "' server IP/Port is missing or invalid..")
	return end

	table.insert(MODERN.Servers, { title = title, settings = serversettings})
end