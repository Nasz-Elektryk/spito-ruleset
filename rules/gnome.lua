-- #![Sudo]
-- #![Unsafe]


local tmpDir = "/tmp/spito-gnome"
local whiteSurGtkPath = tmpDir .. "/WhiteSur-gtk-theme"
  
function main()
  --- temporary commented because it takes a lot of time
  --local err = api.pkg.install("gnome", "gdm")
  if err then
    api.info.error(err)
    return false
  end
  
  err = prepareWhiteSurGtk()
  if err then
    api.info.error(err)
    return false
  end

  err = whiteSurGtk()
  if err then
    api.info.error(err)
    return false
  end

  err = api.daemon.restart("gdm")
  if err then
    api.info.error(err)
    return false
  end

  return true
end

function prepareWhiteSurGtk()
  require_file("rules/stopAndDisableDMs.lua")

  -- I used api.sh in odert to avoid reverting it later
  local mkDirCommand = "mkdir -p " .. tmpDir
  local gitCommand = "git clone https://github.com/vinceliuice/WhiteSur-gtk-theme " .. whiteSurGtkPath .. " || (cd " .. whiteSurGtkPath .." && git pull)"
  local _, err = api.sh.command(mkDirCommand .. " && " .. gitCommand)
  if err then
    api.info.log("------------------------ " .. whiteSurGtkPath)
    return err
  end
  
  _, err = api.sh.command("chmod +x " .. whiteSurGtkPath .. "/tweaks.sh")
  if err then
    return err
  end

  _, err = api.sh.command("chmod +x " .. whiteSurGtkPath .. "/install.sh")
  if err then
    return err
  end

  err = putDownDMs("gdm")
  if err then
    return err
  end

  return api.daemon.start("gdm")
end

function whiteSurGtk()
  local _, err = api.sh.command(whiteSurGtkPath .. "/install.sh -l")
  if err then
    return err
  end

  _, err = api.sh.command(whiteSurGtkPath .. "/tweaks.sh --gdm")
  if err then
    return err
  end

  return nil
end

function revert()
  local err = prepareWhiteSurGtk()
  if err then
    api.info.error(err)
    return false
  end

  _, err = api.sh.command(whiteSurGtkPath .. "/install.sh --uninstall")
  if err then
    api.info.error(err)
    return false
  end
  
  _, err = api.sh.command(whiteSurGtkPath .. "/tweaks.sh -g --revert")
  if err then
    api.info.error(err)
    return false
  end

  return true
end