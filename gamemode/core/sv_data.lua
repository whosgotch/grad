prop.data = prop.data or {}

function prop.data.load(ply)
    local sid64 = ply:SteamID64()
    local res = prop.db.query("select data from prop_players where sid64 = " .. sql.Value(sid64))

    if res and res[1] then 
        ply.prop = util.JSONToTable(res[1].data) or {}
        print("[prop] Loaded data for " .. ply:Nick())
    else 
        ply.prop = {first_joined = os.time()}

        local json = util.TableToJSON(ply.prop)

        prop.db.query(string.format(
            "insert into prop_players (sid64, data) values (%s, %s)",
            sql.Value(sid64),
            sql.Value(json)
        ))
        print("[prop] Create new record for " .. ply:Nick())
    end
end

function prop.data.save(ply)
    if not IsValid(ply) or not ply.prop then return end 

    local sid64 = ply:SteamID64()
    local json = util.TableToJSON(ply.prop)

    prop.db.query(string.format(
        "update prop_players set data = %s where sid64 = %s",
        sql.Value(json),
        sql.Value(sid64)
    ))
end

function GM:PlayerInitialSpawn(ply)
    prop.data.load(ply)
    self.BaseClass.PlayerInitialSpawn(self, ply)
end

function GM:PlayerDisconnected(ply)
    prop.data.save(ply)
    self.BaseClass.PlayerDisconnected(self, ply)
end

