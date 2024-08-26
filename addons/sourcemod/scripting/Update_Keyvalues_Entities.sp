#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <entitylump>

#define PLUGIN_VERSION "1.0"

public Plugin:myinfo = 
{
    name = "Update Keyvalues Entities ",
    author = "Paralhama",
    description = "A demonstration plugin on how to change entities values ​​in source engine maps",
    version = PLUGIN_VERSION,
    url = ""
}


public void OnMapInit(const char[] mapName)
{
    // Itera sobre todas as entradas de entidades no mapa
    for (int i = 0; i < EntityLump.Length(); i++) 
    {
        EntityLumpEntry entry = EntityLump.Get(i);
        
        char classname[32];
        // Obtém o nome da classe da entidade
        if (entry.GetNextKey("classname", classname, sizeof(classname)) == -1) continue;

        // Verifica se a entidade é trigger_hurt, trigger_hurt_fof ou prop_physics_respawnable
        if (StrEqual(classname, "trigger_hurt") || StrEqual(classname, "trigger_hurt_fof"))
        {
            // Atualiza o tipo de dano para 0
            int damageTypeIndex = entry.FindKey("damagetype", -1);
            if (damageTypeIndex != -1)
            {
                entry.Update(damageTypeIndex, "damagetype", "0");
            }

            // Atualiza o dano para 999
            int damageIndex = entry.FindKey("damage", -1);
            if (damageIndex != -1)
            {
                entry.Update(damageIndex, "damage", "999");
            }
        }
        else if (StrEqual(classname, "prop_physics_respawnable"))
        {
            // Verifica se a chave "spawnflags" é 0, 1 ou 256
            char spawnflags[32];
            if (entry.GetNextKey("spawnflags", spawnflags, sizeof(spawnflags)) != -1 && (StrEqual(spawnflags, "256") || StrEqual(spawnflags, "0") || StrEqual(spawnflags, "1")))
            {
                // Atualiza o modelo para "models/elpaso/barrel2_explosive.mdl"
                int modelIndex = entry.FindKey("model", -1);
                if (modelIndex != -1)
                {
                    entry.Update(modelIndex, "model", "models/elpaso/barrel2_explosive.mdl");
                }

                // Atualiza o tempo de respawn para 30
                int respawnTimeIndex = entry.FindKey("RespawnTime", -1);
                if (respawnTimeIndex != -1)
                {
                    entry.Update(respawnTimeIndex, "RespawnTime", "30");
                }

                // Atualiza o spawnflags para 0
                int spawnflagsIndex = entry.FindKey("spawnflags", -1);
                if (spawnflagsIndex != -1)
                {
                    entry.Update(spawnflagsIndex, "spawnflags", "0");
                }
            }
        }
        else if (StrEqual(classname, "worldspawn"))
        {
            // Atualiza o skyname para "fof05"
            int skynameIndex = entry.FindKey("skyname", -1);
            if (skynameIndex != -1)
            {
                entry.Update(skynameIndex, "skyname", "fof05");
            }
        }
    }
}

