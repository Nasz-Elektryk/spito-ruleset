function gnome_exists()
  app_info, err = api.pkg.Get("gnome-shell")
  if err ~= nil then
    api.info.Error("Error occured during obtaining package info!")
    return false
  end
  return true
end

function main()
  return gnome_exists()
end