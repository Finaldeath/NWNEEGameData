#include "inc_id1_utility"
#include "inc_id_liltimmy"

int StartingConditional()
{
    if (GetTag(OBJECT_SELF) == "DungeonEntranceStairs")
    {
        string sString = "";

        // if a dungeon is currently active
        object oDungeon = GetCurrentDungeon();
        if (oDungeon != OBJECT_INVALID)
        {
            // store this dungeon
            int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
            string sName = "Dungeon" + IntToString(nDungeonNumber);
            int bStored = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
            DebugMessage("bStored value for " + sName + " was " + IntToString(nDungeonNumber));

            string sDungeonName = GetLocalString(oDungeon, "sDungeonName");

            // if anyone is in the dungeon
            int nCurrentLevel = GetCurrentLevel();

            // determine if there is noone else on a different level of the dungeon
            object oPC = GetFirstPC();
            int bEntrance = TRUE;
            while ((oPC != OBJECT_INVALID) && (bEntrance == TRUE))
            {
                if (GetTag(GetArea(oPC)) != "DungeonEntrance")
                {
                    bEntrance = FALSE;
                } else
                {
                    oPC = GetNextPC();
                }
            }

            if (bEntrance == TRUE)
            {
                DebugMessage("Players were only in the dungeon entrance. Resetting current level. Point X.");

                nCurrentLevel = 0;
                SetLocalInt(GetModule(), "nCurrentLevel", 0);
            }

            if (nCurrentLevel == 0)
            {
                sString += sDungeonName + " is active, but no one is in it currently.";

                SetLocalInt(OBJECT_SELF, "nDungeonState", 1);
            } else
            {
                sString += sDungeonName + " is currently active on level " + IntToString(nCurrentLevel) + ". You have to wait until they return.";

                SetLocalInt(OBJECT_SELF, "nDungeonState", 2);
            }
        } else // if there is no dungeon active
        {
            // if the next dungeon is a plot dungeon
            if (GetLocalInt(GetModule(), "bPlotDungeon") == TRUE)
            {
                // get position in plot
                int nPlotPosition = lt_GetDungeonLevel();
                DebugMessage("        Plot position is " + IntToString(nPlotPosition));

                string sDungeonName = "";

                int nBoss;

                // if lieutenants
                if ((nPlotPosition == ID_LOCAL_DUNGEON_NOT_ENTERED) || (nPlotPosition == ID_LOCAL_FIRST_DUNGEON_COMPLETED) || (nPlotPosition == ID_LOCAL_SECOND_DUNGEON_COMPLETED))
                {
                    if (nPlotPosition == ID_LOCAL_DUNGEON_NOT_ENTERED)
                    {
                        nBoss = lt_GetFirstLieutenant();
                    } else if (nPlotPosition == ID_LOCAL_FIRST_DUNGEON_COMPLETED)
                    {
                        nBoss = lt_GetSecondLieutenant();
                    } else if (nPlotPosition == ID_LOCAL_SECOND_DUNGEON_COMPLETED)
                    {
                        nBoss = lt_GetThirdLieutenant();
                    }

                    if (nBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                    {
                        sDungeonName = "Lord Antoine's Den";
                    } else if (nBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                    {
                        sDungeonName = "Widow Hagatha's Home";
                    } else if (nBoss == ID_LOCAL_LIEUTENANT_INSECT)
                    {
                        sDungeonName = "Maggris' Hive";
                    }
                } else if ((nPlotPosition == ID_LOCAL_THIRD_DUNGEON_COMPLETED) || (nPlotPosition == ID_LOCAL_FIRST_BOSS_DEFEATED) || (nPlotPosition == ID_LOCAL_SECOND_BOSS_DEFEATED)) // if inner circle
                {
                    if (nPlotPosition == ID_LOCAL_THIRD_DUNGEON_COMPLETED)
                    {
                        nBoss = lt_GetFirstBoss();
                    } else if (nPlotPosition == ID_LOCAL_FIRST_BOSS_DEFEATED)
                    {
                        nBoss = lt_GetSecondBoss();
                    } else if (nPlotPosition == ID_LOCAL_SECOND_BOSS_DEFEATED)
                    {
                        nBoss = lt_GetThirdBoss();
                    }

                    if (nBoss == ID_LOCAL_BOSS_DEMON)
                    {
                        sDungeonName = "Harat's Sanctum";
                    } else if (nBoss == ID_LOCAL_BOSS_BEHOLDER)
                    {
                        sDungeonName = "G'Zhorb's Pit";
                    } else if (nBoss == ID_LOCAL_BOSS_LICH)
                    {
                        sDungeonName = "Masterius' Crypt";
                    }
                } else if (nPlotPosition == ID_LOCAL_THIRD_BOSS_DEFEATED) // if halaster
                {
                    sDungeonName = "Halaster's Domain";
                } else
                {
                    sDungeonName = "An invalid plot dungeon was assigned.";
                }

                sString += sDungeonName + " awaits you.";

                SetLocalInt(OBJECT_SELF, "nDungeonState", 3);
            } else
            {
                sString += "There is no dungeon currently active.";

                SetLocalInt(OBJECT_SELF, "nDungeonState", 4);
            }
        }

        SetCustomToken(5200, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
