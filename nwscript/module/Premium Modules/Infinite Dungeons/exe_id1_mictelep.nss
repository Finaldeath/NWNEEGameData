#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    DebugMessage("");
    DebugMessage("Checking to see if boss area has been cleared.");

    object oDungeon = GetCurrentDungeon();
    int bBossTeleporter = GetLocalInt(oDungeon, "bBossTeleporter");
    if ((bBossTeleporter == FALSE) && (oDungeon != OBJECT_INVALID))
    {
        int bFailed = FALSE;
        int nObjectType;
        string sTag;
        int bClean;
        object oSelf = GetLocalObject(OBJECT_SELF, "oSelf");
        object oArea = GetLocalObject(OBJECT_SELF, "oArea");
        object oObject = GetFirstObjectInArea(oArea);
        while ((oObject != OBJECT_INVALID) && (bFailed == FALSE))
        {
            nObjectType = GetObjectType(oObject);
            if (nObjectType == OBJECT_TYPE_CREATURE)
            {
                sTag = GetTag(oObject);
                DebugMessage("  Found creature with tag " + sTag);

                if (oObject != oSelf)
                {
                    DebugMessage("    This creature is not me.");

                    // determine if this is a normal clean operation
                    bClean = GetLocalInt(oObject, "bClean");
                    if (bClean == FALSE)
                    {
                        DebugMessage("      Creature is not being cleaned.");

                        // determine if creature is hostile
                        if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oObject) > 50)
                        {
                            DebugMessage("        Creature is hostile.");

                            if (GetIsDead(oObject) == FALSE)
                            {
                                DebugMessage("          Creature is not dead.");

                                bFailed = TRUE;
                            }
                        }
                    } else
                    {
                        DebugMessage("      Creature is being cleaned.");
                    }
                } else
                {
                    DebugMessage("    This is me, so I'll ignore it.");
                }
            }

            // check next object
            oObject = GetNextObjectInArea(oArea);
        }

        if (bFailed == FALSE)
        {
            DebugMessage("  Sweep successful.");

            // boss teleporter as active
            int bBossTeleporter = GetLocalInt(oDungeon, "bBossTeleporter");
            if (bBossTeleporter == FALSE)
            {
                DebugMessage("  Spawning portal.");

                // spawn boss teleporter
                SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

                object oWaypoint = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", oSelf);

                // add map pin
                SetMapPinEnabled(oWaypoint, TRUE);

                CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
            }
        }
    } else
    {
        DebugMessage("  Teleporter already spawned.");
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
