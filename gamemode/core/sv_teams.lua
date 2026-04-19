function prop.team.set(ply, teamID)
    local job = prop.team.list[teamID]
    if not job then return false end 
    ply:SetTeam(teamID)
    prop.data.set(ply, "job_name", job.name)
    ply:Spawn()
    return true
end

function GM:PlayerLoadout(ply)
    local job = prop.team.list[ply:Team()]
    if not job then return self.BaseClass.PlayerLoadout(self, ply) end

    ply:StripWeapons()
    for _, wep in job.weapons do
        ply:Give(wep)
    end

    return true
end

function GM:PlayerSetModel(ply)
    local job = prop.team.list[ply:Team()]
    if job and job.model then
        ply:SetModel(job.model)
    else 
        self.BaseClass.PlayerSetModel(self, ply)
    end
end