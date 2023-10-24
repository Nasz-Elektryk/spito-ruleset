-- This file is created only for development of spito-rules
-- In the future we should make something that makes sens
-- (opposition of this file)

function main()
    p = Package()
    p.Get(p, "dbus")
    if p.Name == "" then
        return false
    end

    daemon, _ = GetDaemon("dbus")
    
    if daemon.IsActive and daemon.IsEnabled then
        return true
    end
    return false
end