function main()
    p, err = api.pkg.Get("nerd-fonts-meta")
    if err ~= nil then
        api.info.Error("Error occured during obtaining package info!")
        return false
    end

    if p.Name == "" then
        api.info.Error("Package doesn't have name!")
        return false
    end

    return true
end
