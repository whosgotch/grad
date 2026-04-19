prop.net = prop.net or {}

if SERVER then 
    util.AddNetworkString("prop.ChatBroadcast")
    util.AddNetworkString("prop.DataSync")

    function prop.data.sync(ply, key, value)
        if not IsValid(ply) then return end 

        net.Start("prop.DataSync")
            net.WriteString(key)
            net.WriteType(value)
        net.Send(ply)
    end

end

if CLIENT then 
    net.Receive("prop.DataSync", function ()
        local key = net.ReadString()
        local value = net.ReadType()

        LocalPlayer().prop = LocalPlayer() or {}
        LocalPlayer().prop[key] = value

        print(string.format("[prop] Net Sync: %s = %s", key, tostring(value)))
    end)

    net.Receive("prop.ChatBroadcast", function ()
        local parts = net.ReadTable()
        chat.AddText(unpack(parts))
    end)
end