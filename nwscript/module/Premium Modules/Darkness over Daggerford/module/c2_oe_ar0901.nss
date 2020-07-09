// player enters the dark druid's burrow
// - if all four fowls are rescued, stegil will be there
// - if not, four generic dark druids will be there

#include "hf_in_spawn"
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // prepare for trigger where stegil talks to player
        SetLocalInt(OBJECT_SELF, "nStegilTalks", 0);

        // spawn stegil if the player has found all four fowls
        if (PlotLevelGet("ks_druid_gull") >= 7)
        {
            if (GetLocalInt(OBJECT_SELF, "nStegilSpawned") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nStegilSpawned", 1);

                if (GetLocalInt(OBJECT_SELF, "nDruidsSpawned") == 1)
                {
                    // druids were previously spawned, so destroy them
                    // ... (they might be hostile which would be bad)
                    int i = 0;
                    object oDruid = GetObjectByTag("ks_dark_druid", i);
                    while (GetIsObjectValid(oDruid))
                    {
                        if (GetArea(oDruid) == OBJECT_SELF)
                        {
                            DestroyObject(oDruid);
                        }
                        oDruid = GetObjectByTag("ks_dark_druid", ++i);
                    }
                    SetLocalInt(OBJECT_SELF, "nDruidsSpawned", 0);
                }
                object oWP = GetWaypointByTag("WP_AR0901_STEGIL");
                object oStegil = CreateObject(OBJECT_TYPE_CREATURE, "ks_stegil", GetLocation(oWP));
                int nCR = SpawnGetPartyCR(oPC, 50);
                SpawnLevelupCreature(oStegil, nCR);
            }
        }

        // spawn generic dark druids; if stegil isn't around they are hostile
        if (GetLocalInt(OBJECT_SELF, "nDruidsSpawned") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDruidsSpawned", 1);
            int i = 0;
            object oWP = GetObjectByTag("WP_AR0901_DRUID", i);
            while (GetIsObjectValid(oWP))
            {
                object oDruid = CreateObject(OBJECT_TYPE_CREATURE, "ks_dark_druid", GetLocation(oWP));
                SetLocalInt(oDruid, "HF_SP_LIMIT_LEVELUP_MAX", 10);
                int nCR = SpawnGetPartyCR(oPC, 25);
                SpawnLevelupCreature(oDruid, nCR);
                if (GetLocalInt(OBJECT_SELF, "nStegilSpawned") == 0)
                {
                    // stegil isn't here yet, so just be hostile
                    ChangeToStandardFaction(oDruid, STANDARD_FACTION_HOSTILE);
                }
                oWP = GetObjectByTag("WP_AR0901_DRUID", ++i);
            }
        }
    }
}
