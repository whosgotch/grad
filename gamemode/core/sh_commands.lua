prop.command = prop.command or {}
prop.commands.list = prop.command.list or {}

function prop.command.add(name, data)
    prop.command.list[string.lower(name)] = {
        onRun = data.onRun,
        adminOnly = data.adminOnly or false,
        description = data.description or "No description provided."
    }
    print("[prop] Registered Command " .. name)
end

