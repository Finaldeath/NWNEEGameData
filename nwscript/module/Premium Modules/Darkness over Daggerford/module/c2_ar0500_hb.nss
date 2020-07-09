// this is the area heartbeat for daggerford
// .. it handles spawns at dawn or dusk if the player is in the area
// .. (does nothing if the end-game is running)

#include "hf_in_spawn"

void main()
{
    object oPC = GetFirstPC();
    if (GetArea(oPC) == OBJECT_SELF)
    {
        if (GetLocalInt(GetModule(), "pm_endgame_start") == 1)
        {
            return;
        }

        int nLastSpawnType = GetLocalInt(OBJECT_SELF, "nLastSpawnType");
        if (GetIsDay())
        {
            if (nLastSpawnType == -1)
            {
                // it is day and our last spawn type was night, so respawn
                SpawnEnter(oPC);
                SetLocalInt(OBJECT_SELF, "nLastSpawnType", 1);
            }
        }
        else if (GetIsNight())
        {
            if (nLastSpawnType == 1)
            {
                // it is night and our last spawn type was day
                SetLocalInt(OBJECT_SELF, "nLastSpawnType", -1);
                SpawnEnter(oPC);
            }
        }
    }
}
