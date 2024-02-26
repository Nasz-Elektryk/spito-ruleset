function main()
	hyprlandPackage, err = api.pkg.get("hyprland")
	if err ~= nil or hyprlandPackage.Name == "" then
		err = api.pkg.install("hyprland")
		if err ~= nil then
			api.info.error(err)
			return false
		end
	end

	local config_files = { "hyprland.conf", "startup.conf", "env.conf", "windowrule.conf", "keybinds.conf" }
	for i, config_file in pairs(config_files) do
		hyprlandConfigContents, err = api.fs.readFile(RULESET_DIR .. "/configs/hyprland/" .. config_file)
		if err ~= nil then
			api.info.error(err)
			return false
		end
		api.info.log(config_file)
		err = 
		api.fs.createFile("~/.config/hypr/" .. config_file, hyprlandConfigContents, false)
		if err ~= nil then
			api.info.error(err)
			return false
		end
	end
	
	return true
end
