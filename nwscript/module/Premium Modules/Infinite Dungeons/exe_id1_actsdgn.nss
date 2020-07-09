#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"
#include "inc_id1_creature"

int JitterEncounterSize(int nEncounterSize);

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


    // check to see if secret doors are active
    int nSecretDoorPercentage = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_FREQUENCY);
    DebugMessage("Chance of a secret door is " + IntToString(nSecretDoorPercentage));

    // check to see if secret encounters are active
    int nSecretEncounterPercentage = GetModuleFlagValue(ID1_FLAG_SECRET_ENCOUNTER_FREQUENCY);
    DebugMessage("Chance of a secret encounter is " + IntToString(nSecretEncounterPercentage));

    // check to see if secret treasure is active
    int nSecretTreasurePercentage = GetModuleFlagValue(ID1_FLAG_SECRET_TREASURE_FREQUENCY);
    DebugMessage("Chance of a secret treasure is " + IntToString(nSecretTreasurePercentage));

    int nPartyLevel = GetPartyLevel(oPC, FALSE);
    int nPartySize = GetPartySize(oPC, FALSE);
    int nPartySizeLevel = GetPartyLevelSize(nPartyLevel, nPartySize);
    int nPartyDifficultyLevel = nPartySizeLevel + GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);

    // if secret doors are active
    if (nSecretDoorPercentage > 0)
    {
        // get the number of secret doors in this area
        string sSecretDoor = "nArea" + IntToString(nAreaNum) + "WaypointSecretDoor";
        int nSecretDoorNum = GetLocalInt(oDungeon, sSecretDoor);

        DebugMessage("Number of Secret Doors: " + IntToString(nSecretDoorNum));

        int nDifficulty;
        int nBaseDifficulty;
        if (GetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION) == ID1_SECRET_DOOR_DIFFICULTY_SELECTION_LEVEL)
        {
            nBaseDifficulty = 20 + (nPartyLevel / 2);
        } else
        {
            nBaseDifficulty = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION);
        }
        DebugMessage("Base difficulty is " + IntToString(nBaseDifficulty));

        int nBaseDoorJitter = 0;
        if (GetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER) == ID1_SECRET_DOOR_DIFFICULTY_NUMBER_RANDOM)
        {
            nBaseDoorJitter = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER);
        }

        int nRandom;
        int nPercentage;

        object oSecretDoor;
        object oSecretWaypoint;
        int nSecretWaypoint;
        string sLevel;
        int bActive;
        float fDistance;
        object oSecretDoorExit;


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


        int nDamageID;
        int nDungeonDamageType;


//        string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
//        int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
        int nContainerNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container");
        int nContainerRandom;
        int nContainer;
        int nMicroNum;
        object oMicroCPU;

        int nCR;
        int nSize;
        int nEncounterSize;
        string sCreature;
        int nTemp;

        float fValue;

        int nDoorNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor");
        int nDoor;
        string sDoor;
        int nDungeonDoor;

        int nTreasurePercentage = GetLocalInt(oDungeon, "nTreasureEncounterPercentage");
        int bTreasureFixed = GetLocalInt(oDungeon, "bTreasureEncounterFrequencyFixed");
        DebugMessage("Treasure fixed is " + IntToString(bTreasureFixed) + " with percentage " + IntToString(nTreasurePercentage));

        string sResRef;
        int nDungeonContainer;

        // go to each secret door
        int nSecretDoor = 1;
        while (nSecretDoor <= nSecretDoorNum)
        {
            DebugMessage("On secret door " + IntToString(nSecretDoor) + " of " + IntToString(nSecretDoorNum));

            nRandom = d100();
            DebugMessage("Random value was " + IntToString(nRandom) + " vs " + IntToString(nSecretDoorPercentage));
            if (nRandom <= nSecretDoorPercentage)
            {
                DebugMessage("Secret door will be used.");

                sLevel = "Area" + IntToString(nAreaNum) + "WaypointSecretDoor" + IntToString(nSecretDoor) + "Level" + IntToString(nCurrentLevel);
                DebugMessage("Secret door path: " + sLevel);

                SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);

                oSecretDoor = GetLocalObject(oArea, "oWaypointSecretDoor" + IntToString(nSecretDoor));

                nDifficulty = nBaseDifficulty;
                if (nBaseDoorJitter > 0)
                {
                    nDifficulty += Random((nBaseDoorJitter * 2) + 1) - nBaseDoorJitter;
                }
                if (nDifficulty < 0)
                {
                    nDifficulty = 0;
                }
                DebugMessage("Assigning difficulty: " + IntToString(nDifficulty));
                SetLocalInt(oDungeon, "n" + sLevel + "DC", nDifficulty);

                nRandom = Random(nDoorNum) + 1;
                nDoor = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor" + IntToString(nRandom));
                DebugMessage("nTileset" + IntToString(nTileset) + "SecretDoor" + IntToString(nRandom) + " is " + IntToString(nDoor));
                sDoor = GetLocalString(GetModule(), "sSecretDoor" + IntToString(nDoor) + "ResRef");
                DebugMessage("sSecretDoor" + IntToString(nDoor) + "ResRef is " + sDoor);
                nDungeonDoor = GetLocalInt(oDungeon, "nListSecretDoor_" + sDoor);
                if (nDungeonDoor == 0) // if not in the list, add
                {
                    nDungeonDoor = GetLocalInt(oDungeon, "nListSecretDoorNum");
                    nDungeonDoor++;
                    SetLocalInt(oDungeon, "nListSecretDoorNum", nDungeonDoor);
                    SetLocalString(oDungeon, "sListSecretDoor" + IntToString(nDungeonDoor) + "ResRef", sDoor);
                    SetLocalInt(oDungeon, "nListSecretDoor_" + sDoor, nDungeonDoor);
                }
                SetLocalInt(oDungeon, "n" + sLevel + "Door", nDungeonDoor);
                DebugMessage("        Set secret door n" + sLevel + "Door to " + IntToString(nDungeonDoor));

                oSecretDoorExit = GetNearestObjectByTag("ID1_STATIC_WP_SECRET_DOOR_EXIT", oSecretDoor);

                nRandom = d100();
                DebugMessage("Random value was " + IntToString(nRandom) + " vs " + IntToString(nSecretEncounterPercentage));
                if (nRandom <= nSecretEncounterPercentage)
                {
                    // if there is a secret encounter waypoint nearby
                    oSecretWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_SECRET_ENCOUNTER", oSecretDoorExit);
                    if (oSecretWaypoint != OBJECT_INVALID)
                    {
                        // if the point is close enough
                        fDistance = fabs(GetDistanceBetween(oSecretDoorExit, oSecretWaypoint));
                        DebugMessage("Distance from door to waypoint = " + FloatToString(fDistance));
                        if (fDistance <= 20.0)
                        {
                            // if the point is not used
                            nSecretWaypoint = GetLocalInt(oSecretWaypoint, "nNumber");
                            sLevel = "Area" + IntToString(nAreaNum) + "WaypointSecretEncounter" + IntToString(nSecretWaypoint) + "Level" + IntToString(nCurrentLevel);
                            bActive = GetLocalInt(oDungeon, "b" + sLevel + "Used");
                            DebugMessage("Waypoint b" + sLevel + "Used is " + IntToString(bActive));
                            if (bActive == FALSE)
                            {
                                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU49");
                                SetLocalString(oMicroCPU, "sVariable", sLevel);
                                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                                SetLocalInt(oMicroCPU, "bHold", TRUE);
                                SetLocalInt(oMicroCPU, "nBaseLevel", nPartyDifficultyLevel);
                                SetLocalInt(oMicroCPU, "nBaseSize", nPartySize);
                                SetLocalInt(oMicroCPU, "nPercentage", nSecretEncounterPercentage);
                                SetLocalInt(oMicroCPU, "bBoss", FALSE);
                                SetLocalInt(oMicroCPU, "nTileset", nTileset);
                                SetLocalInt(oMicroCPU, "nTheme", -1);

                                // increment number of active microprocessors
                                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                                nMicroNum++;
                                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                                DelayCommand(0.01, ExecuteScript("exe_id1_micenc", oMicroCPU));
                            }
                        }
                    }
                }

                // if there should be a secret treasure in this room
                nRandom = d100();
                DebugMessage("Random value was " + IntToString(nRandom) + " vs " + IntToString(nSecretTreasurePercentage));
                if (nRandom <= nSecretTreasurePercentage)
                {
                    // get nearest secret treasure point
                    oSecretWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_SECRET_TREASURE", oSecretDoorExit);

                    // if a valid waypoint
                    if (oSecretWaypoint != OBJECT_INVALID)
                    {
                        DebugMessage("Secret treasure waypoint was valid.");

                        // if not active
                        nSecretWaypoint = GetLocalInt(oSecretWaypoint, "nNumber");
                        sLevel = "Area" + IntToString(nAreaNum) + "WaypointSecretTreasure" + IntToString(nSecretWaypoint) + "Level" + IntToString(nCurrentLevel);
                        bActive = GetLocalInt(oDungeon, "b" + sLevel + "Used");
                        DebugMessage("Waypoint b" + sLevel + "Used is " + IntToString(bActive));
                        if (bActive == FALSE)
                        {
                            fDistance = fabs(GetDistanceBetween(oSecretDoorExit, oSecretWaypoint));
                            DebugMessage("Distance from door to waypoint = " + FloatToString(fDistance));
                            if (fDistance <= 20.0)
                            {
                                SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);
                                DebugMessage("Set b" + sLevel + "Used to true.");

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

                                // generate treasure
                                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU50");
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
                        }
                    }
                }
            }

            // check next secret door
            nSecretDoor++;
        }
    }

    // enter holding pattern
    DebugMessage("Entering holding pattern.");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

