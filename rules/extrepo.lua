function main()
  -- support apt
  -- need function that shortcuts whole this stuff
  local content, err = api.fs.readFile(RULESET_DIR.."/configs/extrepo/config.yaml")
  if err ~= nil then
    api.info.error(err)
    return false
  end
  local options = {
    ConfigType = api.fs.config.yaml
  }
  api.fs.updateConfig("/etc/extrepo/config.yaml", content, options)
  return true
end
