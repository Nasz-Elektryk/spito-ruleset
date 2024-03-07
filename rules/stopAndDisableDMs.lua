-- stop and disable desktop managers

local DMs = {
    "gdm",
    "lightdm",
}

-- We return always true, because this is library
-- and when someone uses require_file it checks main function
-- btw this check should be skipped when using require_file
function main()
    return true
end

--- @param dmToSkip string - name of DM to skip
function putDownDMs(dmToSkip)
    dmToSkip = string.lower(dmToSkip)

    for _, dm in pairs(DMs) do
        if dm == dmToSkip then
            goto continue
        end

        err = api.daemon.stopDaemon(dm)
        if err then
            api.info.error(err)
            return false
        end

        err = api.daemon.disableDaemon(dm)
        if err then
            api.info.error(err)
            return false
        end

        ::continue::
    end

    return true
end