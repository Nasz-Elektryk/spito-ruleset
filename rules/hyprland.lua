function installDependencies(packages)
	return api.pkg.install(unpack(packages)) == nil
end

autostart = [[
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec /usr/bin/Hyprland
fi
]]

function main()

	local packages = {"hyprland", "swww", "archlinux-wallpaper", "waybar", 
	"otf-font-awesome", "kitty", "bash"}
	local didPackageInstallationSucceed = true

	for i, packageName in pairs(packages) do
		package, err = api.pkg.get(packageName)
		if err ~= nil or package.Name == "" then
			didPackageInstallationSucceed = installDependencies(packages)
			break
		end	
	end

	if not didPackageInstallationSucceed then
		api.info.error("Package installation failed!")
		return false
	end
	

	local config_files = { "hyprland.conf", "startup.conf", "env.conf", "windowrule.conf", "keybinds.conf", "randwall.sh" }
	for i, config_file in pairs(config_files) do
		hyprlandConfigContents, err = api.fs.readFile(RULESET_DIR .. "/configs/hyprland/" .. config_file)
		if err ~= nil then
			api.info.error(err)
			return false
		end
		err = 
		api.fs.createFile("~/.config/hypr/" .. config_file, hyprlandConfigContents, false)
		if err ~= nil then
			api.info.error(err)
			return false
		end
	end

	bashProfileContents, err = api.fs.readFile("~/.bash_profile")
	if err ~= nil then
		api.info.error(err)
		return false
	end

	if not string.find(bashProfileContents, autostart, 1, true) then
		bashProfileContents = bashProfileContents .. autostart
		err = api.fs.createFile("~/.bash_profile", bashProfileContents, false)
		if err ~= nil then
			api.info.error(err)
			return false
		end
	end
	err = api.sh.exec("Hyprland")
	return err == nil
end
