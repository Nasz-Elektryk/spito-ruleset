function gnome_exists()
  app_info, err = api.pkg.get("gnome-shell")
  if err ~= nil then
    api.info.error("Error occured during obtaining package info!")
    return false
  end
  return true
end

function main()
  return gnome_exists()
end