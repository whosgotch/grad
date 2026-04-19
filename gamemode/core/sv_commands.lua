function GM:PlayerSay(ply, text, teamOnly)
    if string.sub(text, 1, 1) == "/" then 
        local args = string.Explode(" ", string.sub(text, 2))
        local cmdName = string.lower(table.remove(args, 1))

        local cmd = prop.command.list[cmdName]

        if cmd then 
            if cmd.adminOnly and not ply:IsAdmin() then 
                ply:ChatPrint("[prop] You don't have permission to use this!")
                return
            end

            local success, err = pcall(cmd.onRun, ply, args) 

            if not success then 
                ply:ChatPrint("[prop] Error: " .. tostring(err))
            end

            return ""
        end
    end

    return self.BaseClass.PlayerSay(self, text, teamOnly)
end