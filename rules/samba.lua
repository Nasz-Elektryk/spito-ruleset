#[unsafe]
function main()
  -- api.sh.command("apt install samba") -- should be api.sudo.sh.command("apt install")
  local content, err = api.fs.readFile(RULESET_DIR.."/configs/samba/smb.conf")
  if err ~= nil then
    api.info.error(err)
    return false
  end
  api.fs.createConfig("/tmp/smb.conf", content, )
  return true
end
