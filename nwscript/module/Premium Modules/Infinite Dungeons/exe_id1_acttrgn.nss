#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

#include "inc_id1_treasure"

void main()
{
    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    // get pc level
    int nPartyLevel = GetPartyLevel(oPC, FALSE);

    // check to see if treasure chests are active
    int nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_TREASURE_FREQUENCY);
    DebugMessage("Chance of treasure is " + IntToString(nTreasurePercentage));


    int nLockPercentage = GetModuleFlagValue(ID1_FLAG_LOCK_CHEST_FREQUENCY);
    int nUnlockDC;
    if (GetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_SELECTION) == ID1_LOCK_DIFFICULTY_SELECTION_SET)
    {
        nUnlockDC = GetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_SELECTION);
    } else
    {
        nUnlockDC = 20 + (nPartyLevel / 2);
    }
    int nBaseLockJitter;
    int nJitter;
    if (GetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_NUMBER) == ID1_LOCK_DIFFICULTY_NUMBER_RANDOM)
    {
        nBaseLockJitter = GetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_NUMBER);
    }


    int nTrapPercentage = GetModuleFlagValue(ID1_FLAG_TRAP_CHEST_FREQUENCY);

    string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
    DebugMessage("sArea" + IntToString(nAreaNum) + "Tileset is " + sTileset + " and nTileset is " + IntToString(nTileset));

    int nDamageTypeNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType");
    int nDamageType;

    int nDamageDC;
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_SELECTION) == ID1_TRAP_DAMAGE_SELECTION_SET)
    {
        nDamageDC = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_SELECTION);
    } else
    {
        nDamageDC = 15 + nPartyLevel;
    }
    int nDamageDCJitter;
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_NUMBER) == ID1_TRAP_DAMAGE_NUMBER_RANDOM)
    {
        nDamageDCJitter = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_NUMBER);
    }

    int nDetectDC;
    if (GetModuleFlag(ID1_FLAG_TRAP_DETECT_SELECTION) == ID1_TRAP_DETECT_SELECTION_SET)
    {
        nDetectDC = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_SELECTION);
    } else
    {
        nDetectDC = 10 + (nPartyLevel / 2);
    }
    int nDetectDCJitter;
    if (GetModuleFlag(ID1_FLAG_TRAP_DETECT_NUMBER) == ID1_TRAP_DETECT_NUMBER_RANDOM)
    {
        nDetectDCJitter = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_NUMBER);
    }

    int nDisarmDC;
    if (GetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_SELECTION) == ID1_TRAP_DIFFICULTY_SELECTION_SET)
    {
        nDisarmDC = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_SELECTION);
    } else
    {
        nDisarmDC = 20 + (nPartyLevel / 2);
    }
    int nDisarmDCJitter;
    if (GetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_NUMBER) == ID1_TRAP_DIFFICULTY_NUMBER_RANDOM)
    {
        nDisarmDCJitter = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_NUMBER);
    }

    int nDamageMin = nPartyLevel;
    int nDamageMax = nPartyLevel * 2;

    DebugMessage("Party level " + IntToString(nPartyLevel));

    DebugMessage("nDamageDC " + IntToString(nDamageDC));
    DebugMessage("nDetectDC " + IntToString(nDetectDC));
    DebugMessage("nDisarmDC " + IntToString(nDisarmDC));
    DebugMessage("nDamageMin " + IntToString(nDamageMin));
    DebugMessage("nDamageMax " + IntToString(nDamageMax));


    // if active
    if (nTreasurePercentage > 0)
    {
        string sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointTreasure";
        string sLevel;

        // get number of treasure waypoints
        int nTreasureNum = GetLocalInt(oDungeon, "n" + sWaypoint);

        string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
        int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
        DebugMessage("sArea" + IntToString(nAreaNum) + "Tileset is " + sTileset + " and nTileset is " + IntToString(nTileset));

        int nContainerNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container");
        int nContainerRandom;
        int nContainer;

        int nItemNum;

        int nRandom;
        int nPercentage;

        int nMicroNum;
        object oMicroCPU;

        float fValue;

        int nDamageID;
        int nDungeonDamageType;

        string sResRef;
        int nDungeonContainer;

        // each waypoint
        int nTreasure = 1;
        while (nTreasure <= nTreasureNum)
        {
            sLevel = sWaypoint + IntToString(nTreasure) + "Level" + IntToString(nCurrentLevel);
            nItemNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");

            // get percentage
            nRandom = d100();
            DebugMessage("Random value was " + IntToString(nRandom) + " vs " + IntToString(nTreasurePercentage));
            if ((nRandom <= nTreasurePercentage) || (nItemNum > 0))
            {
                SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);

                DebugMessage("Set " + sLevel + "Used to true.");

                // select chest
                nRandom = Random(nContainerNum) + 1;
                nContainer = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container" + IntToString(nRandom));
                sResRef = GetLocalString(GetModule(), "sContainer" + IntToString(nContainer) + "ResRef");
                nDungeonContainer = GetLocalInt(oDungeon, "nListContainer_" + sResRef);
                if (nDungeonContainer == 0) // if not in the list, add
                {
                    nDungeonContainer = GetLocalInt(oDungeon, "nListContainerNum");
                    nDungeonContainer++;
                    SetLocalInt(oDungeon, "nListContainerNum", nDungeonContainer);
                    SetLocalString(oDungeon, "sListContainer" + IntToString(nDungeonContainer) + "ResRef", sResRef);
                    SetLocalInt(oDungeon, "nListContainer_" + sResRef, nDungeonContainer);
                }
                SetLocalInt(oDungeon, "n" + sLevel + "Container", nDungeonContainer);
                DebugMessage("        Set container n" + sLevel + "Container to " + IntToString(nDungeonContainer));

                if (nRandom <= nTreasurePercentage)
                {
                    // generate treasure
                    oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU52");
                    SetLocalInt(oMicroCPU, "nLevel", nPartyLevel);
                    SetLocalString(oMicroCPU, "sContainer", sLevel);
                    fValue = GetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE) / 100.0;
                    SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                    SetLocalInt(oMicroCPU, "bGoldPresent", TRUE);
                    SetLocalInt(oMicroCPU, "bGemPresent", TRUE);
                    SetLocalInt(oMicroCPU, "bItemPresent", TRUE);
                    SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                    SetLocalInt(oMicroCPU, "bHold", TRUE);

                    // increment number of active microprocessors
                    nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                    nMicroNum++;
                    SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                    DelayCommand(0.01, ExecuteScript("exe_id1_mictre", oMicroCPU));
                }

                // generate lock
                nRandom = d100();
                DebugMessage("Random value was " + IntToString(nRandom) + " vs " + IntToString(nLockPercentage));
                if (nRandom <= nLockPercentage)
                {
                    if (GetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_NUMBER) == ID1_LOCK_DIFFICULTY_NUMBER_RANDOM)
                    {
                        nJitter = Random((2 * nBaseLockJitter) + 1) - nBaseLockJitter;
                    } else
                    {
                        nJitter = 0;
                    }
                    nJitter += nUnlockDC;
                    if (nJitter < 0)
                    {
                        nJitter = 0;
                    }

                    SetLocalInt(oDungeon, "b" + sLevel + "Locked", TRUE);
                    SetLocalInt(oDungeon, "b" + sLevel + "Unlocked", FALSE);
                    SetLocalInt(oDungeon, "n" + sLevel + "UnlockDC", nJitter);
                } else
                {
                    SetLocalInt(oDungeon, "b" + sLevel + "Locked", FALSE);
                    SetLocalInt(oDungeon, "b" + sLevel + "Unlocked", FALSE);
                }

                // generate trap
                nRandom = d100();
                DebugMessage("Random value was " + IntToString(nRandom) + " vs " + IntToString(nTrapPercentage));
                if (nRandom <= nTrapPercentage)
                {
                    SetLocalInt(oDungeon, "b" + sLevel + "Trapped", TRUE);
                    SetLocalInt(oDungeon, "b" + sLevel + "Triggered", FALSE);
                    SetLocalFloat(oDungeon, "f" + sLevel + "Radius", 2.0);

                    nRandom = Random(nDamageTypeNum) + 1;
                    nDamageType = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType" + IntToString(nRandom));
                    nDamageID = GetLocalInt(GetModule(), "nDamageType" + IntToString(nDamageType) + "ID");
                    nDungeonDamageType = GetLocalInt(oDungeon, "nListDamageType_" + IntToString(nDamageID));
                    if (nDungeonDamageType == 0) // if not in the list, add
                    {
                        nDungeonDamageType = GetLocalInt(oDungeon, "nListDamageTypeNum");
                        nDungeonDamageType++;
                        SetLocalInt(oDungeon, "nListDamageTypeNum", nDungeonDamageType);
                        SetLocalInt(oDungeon, "nListDamageType" + IntToString(nDungeonDamageType) + "ID", nDamageID);
                        SetLocalInt(oDungeon, "nListDamageType_" + IntToString(nDamageID), nDungeonDamageType);
                    }
                    SetLocalInt(oDungeon, "n" + sLevel + "DamageType", nDungeonDamageType);
                    DebugMessage("        Set damage type n" + sLevel + "DamageType to " + IntToString(nDungeonDamageType));

                    // damage range
                    SetLocalInt(oDungeon, "n" + sLevel + "DamageMin", nDamageMin);
                    SetLocalInt(oDungeon, "n" + sLevel + "DamageMax", nDamageMax);

                    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_NUMBER) == ID1_TRAP_DAMAGE_NUMBER_RANDOM)
                    {
                        nJitter = Random((2 * nDamageDCJitter) + 1) - nDamageDCJitter;
                    } else
                    {
                        nJitter = 0;
                    }
                    nJitter += nDamageDC;
                    if (nJitter < 0)
                    {
                        nJitter = 0;
                    }
                    SetLocalInt(oDungeon, "n" + sLevel + "DamageDC", nJitter);


                    if (GetModuleFlag(ID1_FLAG_TRAP_DETECT_NUMBER) == ID1_TRAP_DETECT_NUMBER_RANDOM)
                    {
                        nJitter = Random((2 * nDetectDCJitter) + 1) - nDetectDCJitter;
                    } else
                    {
                        nJitter = 0;
                    }
                    nJitter += nDetectDC;
                    if (nJitter < 0)
                    {
                        nJitter = 0;
                    }
                    SetLocalInt(oDungeon, "n" + sLevel + "DetectDC", nJitter);

                    if (GetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_NUMBER) == ID1_TRAP_DIFFICULTY_NUMBER_RANDOM)
                    {
                        nJitter = Random((2 * nDisarmDCJitter) + 1) - nDisarmDCJitter;
                    } else
                    {
                        nJitter = 0;
                    }
                    nJitter += nDisarmDC;
                    if (nJitter < 0)
                    {
                        nJitter = 0;
                    }
                    SetLocalInt(oDungeon, "n" + sLevel + "DisarmDC", nJitter);
                } else
                {
                    SetLocalInt(oDungeon, "b" + sLevel + "Trapped", FALSE);
                    SetLocalInt(oDungeon, "b" + sLevel + "Triggered", FALSE);
                }
            }

            // cycle to next treasure waypoint
            nTreasure++;
        }
    }


    // enter holding pattern
    DebugMessage("Entering holding pattern.");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

