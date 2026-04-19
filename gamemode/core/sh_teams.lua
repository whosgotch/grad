prop.team = prop.team or {}
prop.team.list = prop.team.list or {}

function prop.team.register(name, data)
    local id = #prop.team.list + 1
    team.SetUp(id, name, data.color or Color(255, 255, 255))
    
    prop.team.list[id] = {
        name = name,
        model = data.model,
        weapons = data.weapons or {},
        adminOnly = data.adminOnly or false,
        onSpawn = data.onSpawn or function(ply) end
    }

    print("[prop] Registered Job: " .. name .. " (ID: " .. id .. ")")
    return id
end