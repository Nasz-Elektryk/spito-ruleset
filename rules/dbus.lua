-- This file is created only for development of spito-rules
-- In the future we should make something that makes sens
-- (opposition of this file)

function main()
    p, err = api.pkg.Get("dbus")
    if err ~= nil then
        return false
    end

    if p.Name == "" then
        return false
    end

    daemon, _ = api.sys.GetDaemon("dbus")
    
    if daemon.IsActive and daemon.IsEnabled then
        return true
    end
    return false
end
