function main()
    p, err = api.pkg.get("nerd-fonts-meta")
    if err ~= nil then
        api.info.error("Error occured during obtaining package info!")
        return false
    end

    if p.Name == "" then
        api.info.error("Package doesn't have name!")
        return false
    end

    return true
end
