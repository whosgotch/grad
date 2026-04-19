prop.chat = prop.chat or {}

function prop.chat.send(target, dataTable)
    net.Start("prop.ChatBroadcast")
        net.WriteTable(dataTable)
    net.Send(target)
end

function prop.chat.broadcast(dataTable)
    prop.chat.send(player.GetAll(), dataTable)
end

function prop.chat.proximity(ply, radius, dataTable)
    local targets = {}
    for _, v in ipairs(player.FindInSphere(ply:GetPos(), radius)) do 
        if v:IsPlayer() then table.insert(targets, v) end
    end
    prop.chat.send(targets, dataTable)
end