#include "inc_id1_utility"
#include "inc_id_liltimmy"

// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

int StartingConditional()
{
    int nDungeonState = GetLocalInt(OBJECT_SELF, "nDungeonState");
    int bGenerating = GetLocalInt(GetModule(), "bGenerating");
    if ((nDungeonState == 1) || (nDungeonState == 3) && (bGenerating == FALSE))
    {
        string sString = "";

        if (nDungeonState == 1)
        {
            object oDungeon = GetCurrentDungeon();
            string sDungeonName = GetLocalString(oDungeon, "sDungeonName");
            sString += "Enter " + sDungeonName + ".";
        } else
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

            sString += "Enter " + sDungeonName;
        }
        SetCustomToken(5201, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
