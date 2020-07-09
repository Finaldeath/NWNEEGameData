#include "inc_id1_score"
#include "inc_id_liltimmy"

void main()
{
    DebugMessage("");

    // get the player
    object oPC = GetItemActivator();
    DebugMessage("Player for journal is " + GetPCIdentifier(oPC));

    object oArea = GetArea(oPC);
    string sAreaTag = GetTag(oArea);
    DebugMessage("Tag of area is " + sAreaTag);

    int nFirstLieutenant = lt_GetFirstLieutenant();
    int nSecondLieutenant = lt_GetSecondLieutenant();
    int nThirdLieutenant = lt_GetThirdLieutenant();
    int nFirstBoss = lt_GetFirstBoss();
    int nSecondBoss = lt_GetSecondBoss();
    int nThirdBoss = lt_GetThirdBoss();
    DebugMessage("Lieutenants are " + IntToString(nFirstLieutenant) + " " + IntToString(nSecondLieutenant) + " " + IntToString(nThirdLieutenant));
    DebugMessage("Bosses are " + IntToString(nFirstBoss) + " " + IntToString(nSecondBoss) + " " + IntToString(nThirdBoss));

    string sItemTag = GetTag(OBJECT_SELF);
    int nTargetDungeon;
    string sTargetName;
    int bAlreadyFound = FALSE;
    if (sItemTag == "itm_id1_anttot_dormant") // baccha
    {
        if (GetLocalInt(GetModule(), "bBacchaQuestItemFound") == TRUE)
        {
            bAlreadyFound = TRUE;
        } else
        {
            sTargetName = "The Recipe for Poison Cure";
            if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
            {
                nTargetDungeon = -2;
            } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
            {
                nTargetDungeon = -3;
            } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
            {
                nTargetDungeon = -4;
            }
        }
    }
    if (sItemTag == "itm_id1_widhair_dormant") // hagatha
    {
        if (GetLocalInt(GetModule(), "bHagathaQuestItemFound") == TRUE)
        {
            bAlreadyFound = TRUE;
        } else
        {
            sTargetName = "Hilgoth's Finger";
            if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
            {
                nTargetDungeon = -2;
            } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
            {
                nTargetDungeon = -3;
            } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
            {
                nTargetDungeon = -4;
            }
        }
    }
    if (sItemTag == "itm_id1_maggegg_dormant") // maggris
    {
        if (GetLocalInt(GetModule(), "bMaggrisQuestItemFound") == TRUE)
        {
            bAlreadyFound = TRUE;
        } else
        {
            sTargetName = "The Scarab Amulet of Imaskar";
            if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
            {
                nTargetDungeon = -2;
            } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
            {
                nTargetDungeon = -3;
            } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
            {
                nTargetDungeon = -4;
            }
        }
    }
    if (sItemTag == "itm_id1_harattg_dormant") // harat
    {
        if (GetLocalInt(GetModule(), "bHaratQuestItemFound") == TRUE)
        {
            bAlreadyFound = TRUE;
        } else
        {
            sTargetName = "The Abyssal Census";
            if (nFirstBoss == ID_LOCAL_BOSS_DEMON)
            {
                nTargetDungeon = -5;
            } else if (nSecondBoss == ID_LOCAL_BOSS_DEMON)
            {
                nTargetDungeon = -6;
            } else if (nThirdBoss == ID_LOCAL_BOSS_DEMON)
            {
                nTargetDungeon = -7;
            }
        }
    }
    if (sItemTag == "itm_id1_gzrbeye_dormant") // gzhorb
    {
        if (GetLocalInt(GetModule(), "bGzhorbQuestItemFound") == TRUE)
        {
            bAlreadyFound = TRUE;
        } else
        {
            sTargetName = "The Orb of the Unseeable";
            if (nFirstBoss == ID_LOCAL_BOSS_BEHOLDER)
            {
                nTargetDungeon = -5;
            } else if (nSecondBoss == ID_LOCAL_BOSS_BEHOLDER)
            {
                nTargetDungeon = -6;
            } else if (nThirdBoss == ID_LOCAL_BOSS_BEHOLDER)
            {
                nTargetDungeon = -7;
            }
        }
    }
    if (sItemTag == "itm_id1_masbone_dormant") // masterius
    {
        if (GetLocalInt(GetModule(), "bMasteriusQuestItemFound") == TRUE)
        {
            bAlreadyFound = TRUE;
        } else
        {
            sTargetName = "The Lich King's Soul";
            if (nFirstBoss == ID_LOCAL_BOSS_LICH)
            {
                nTargetDungeon = -5;
            } else if (nSecondBoss == ID_LOCAL_BOSS_LICH)
            {
                nTargetDungeon = -6;
            } else if (nThirdBoss == ID_LOCAL_BOSS_LICH)
            {
                nTargetDungeon = -7;
            }
        }
    }

    // if the item has not been found already
    if (bAlreadyFound == FALSE)
    {
        DebugMessage("Target dungeon is " + IntToString(nTargetDungeon));

        int nTargetBoss = 0;
        if (nTargetDungeon == -2)
        {
            nTargetBoss = nSecondLieutenant;
        } else if (nTargetDungeon == -3)
        {
            nTargetBoss = nThirdLieutenant;
        } else if (nTargetDungeon == -4)
        {
            nTargetBoss = nFirstBoss;
        } else if (nTargetDungeon == -5)
        {
            nTargetBoss = nSecondBoss;
        } else if (nTargetDungeon == -6)
        {
            nTargetBoss = nThirdBoss;
        }
        DebugMessage("TargetBoss is " + IntToString(nTargetBoss));

        string sTargetDungeonName;
        if (nTargetDungeon >= -3)
        {
            if (nTargetBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
            {
                sTargetDungeonName = "Lord Antoine's Den";
            } else if (nTargetBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
            {
                sTargetDungeonName = "Widow Hagatha's Home";
            } else if (nTargetBoss == ID_LOCAL_LIEUTENANT_INSECT)
            {
                sTargetDungeonName = "Maggris' Hive";
            }
        } else if (nTargetDungeon >= -6)
        {
            if (nTargetBoss == ID_LOCAL_BOSS_DEMON)
            {
                sTargetDungeonName = "Harat's Sactum";
            } else if (nTargetBoss == ID_LOCAL_BOSS_BEHOLDER)
            {
                sTargetDungeonName = "G'Zhorb's Pit";
            } else if (nTargetBoss == ID_LOCAL_BOSS_LICH)
            {
                sTargetDungeonName = "Masterius' Crypt";
            }
        } else if (nTargetDungeon == -7)
        {
            sTargetDungeonName = "Halaster's Domain";
        }
        DebugMessage("Target dungeon is " + sTargetDungeonName);

        // get current dungeon
        object oDungeon = GetCurrentDungeon();
        int nCurrentDungeon = GetLocalInt(GetModule(), "nDungeonNumber");
        DebugMessage("Current dungeon is " + IntToString(nCurrentDungeon));

        // if in the dungeon entrance
        if ((sAreaTag != "DungeonEntrance") && (nCurrentDungeon == nTargetDungeon))
        {

            int nBossLevel = GetLocalInt(oDungeon, "nBossPlotDepth");
            int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

            string sMessage;
            if (nCurrentLevel == nBossLevel)
            {
                sMessage = sTargetName + " is on this level ";

                int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                int nPlotArea = GetLocalInt(oDungeon, "nBossPlotArea");

                if (nPlotArea == nAreaNum)
                {
                    sMessage += "somewhere in this area.";
                } else
                {
                    int nCurrentX = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "X");
                    int nCurrentY = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "Y");
                    int nPlotX = GetLocalInt(oDungeon, "nArea" + IntToString(nPlotArea) + "Level" + IntToString(nCurrentLevel) + "X");
                    int nPlotY = GetLocalInt(oDungeon, "nArea" + IntToString(nPlotArea) + "Level" + IntToString(nCurrentLevel) + "Y");

                    if ((nCurrentX == nPlotX) && (nCurrentY == nPlotY))
                    {
                        sMessage += "in this area.";
                    } else if (nCurrentX == nPlotX)
                    {
                        sMessage += "in an area to the ";
                        if (nCurrentY < nPlotY)
                        {
                            sMessage += "North.";
                        } else if (nCurrentY > nPlotY)
                        {
                            sMessage += "South.";
                        }
                    } else if (nCurrentY == nPlotY)
                    {
                        sMessage += "in an area to the ";
                        if (nCurrentX < nPlotX)
                        {
                            sMessage += "East.";
                        } else if (nCurrentX > nPlotX)
                        {
                            sMessage += "West.";
                        }
                    } else if (nCurrentX < nPlotX)
                    {
                        sMessage += "in an area to the ";
                        if (nCurrentY < nPlotY)
                        {
                            sMessage += "North-East.";
                        } else if (nCurrentY > nPlotY)
                        {
                            sMessage += "South-East.";
                        }
                    } else if (nCurrentX > nPlotX)
                    {
                        sMessage += "in an area to the ";
                        if (nCurrentY < nPlotY)
                        {
                            sMessage += "North-West.";
                        } else if (nCurrentY > nPlotY)
                        {
                            sMessage += "South-West.";
                        }
                    }
                }
            } else if (nCurrentLevel < nBossLevel)
            {
                sMessage = sTargetName + " is on a level below this one.";
            } else if (nCurrentLevel > nBossLevel)
            {
                sMessage = sTargetName + " is on a level above this one.";
            }

            AssignCommand(oPC, SpeakString(sMessage, TALKVOLUME_WHISPER));
        } else
        {
            string sMessage = sTargetName + " lies in ";
            if (sTargetDungeonName != "")
            {
                sMessage += sTargetDungeonName + ".";
            } else
            {
                sMessage += "another dungeon which you have not yet discovered.";
            }

            AssignCommand(oPC, SpeakString(sMessage, TALKVOLUME_WHISPER));
        }
    } else
    {
        AssignCommand(oPC, SpeakString("The item you have searched for has already been found.", TALKVOLUME_WHISPER));
    }
}
