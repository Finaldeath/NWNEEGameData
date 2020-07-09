#include "inc_id1_debug"
#include "inc_id1_clean"
#include "inc_id1_utility"
#include "inc_id1_score"
#include "inc_id_liltimmy"
#include "inc_id1_gen"

void main()
{
    int nActivationProcess = GetLocalInt(GetModule(), "nActivationProcess");

    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    int bTempLevelGen = GetLocalInt(GetModule(), "bTempLevelGen");
    int bTempAreaGen = GetLocalInt(GetModule(), "bTempAreaGen");
    object oSpeaker = GetLocalObject(GetModule(), "oSpeaker");

    DebugMessage("AreaGen is " + IntToString(bTempAreaGen) + " and nActivationProcess is " + IntToString(nActivationProcess));

    object oArea;
    int nAreaIdentifier;
    int nAreaNum;
    string sTileset;
    int nTileset;
    string sTilesetResRef;
    int nObjectNum;
    int nObject;
    int nMaxLine;
    int nObjectLine;
    string sTilesets;
    string sSubString;
    int bUsed;
    int nTilesetObjectNum;
    int bDecorType;

    // if generating, skip ahead
    if (bTempAreaGen == TRUE)
    {
        AssignCommand(oSpeaker, SpeakString("Generating Area."));

        DebugMessage("Area generation at process " + IntToString(nActivationProcess));

        // determine stage in the area generation process
        switch (nActivationProcess)
        {
            case 0: // generate tileset-related lists
                DebugMessage("");
                DebugMessage("==== AREA GENERATION START ====");
                DebugMessage("");
                DebugMessage("");

                oArea = GetArea(oDestinationDoor);
                nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
                nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
                DebugMessage("  Tileset is " + sTileset + " which is number " + IntToString(nTileset));

                // open decor list
                if (GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecorGenerated") == FALSE)
                {
                    DebugMessage("  Open decor objects for this tileset have not been generated.");

                    nObjectNum = GetLocalInt(GetModule(), "nDecor");
                    nObject = GetLocalInt(GetModule(), "nQueueMin");
                    nMaxLine = nObject + 100;
                    while ((nObject <= nObjectNum) && (nObject < nMaxLine))
                    {
                        bDecorType = GetLocalInt(GetModule(), "bDecor" + IntToString(nObject) + "Open");
                        DebugMessage("    bDecor" + IntToString(nObject) + "Open is " + IntToString(bDecorType));
                        if (bDecorType == TRUE)
                        {
                            sTilesets = GetLocalString(GetModule(), "sDecor" + IntToString(nObject) + "Tilesets");
                            sSubString = GetSubString(sTilesets, nTileset - 1, 1);
                            DebugMessage("    Tileset string for open decor " + IntToString(nObject) + " is " + sTilesets + " with substring " + sSubString);

                            // check to see if this decor item is used by this tileset
                            bUsed = StringToInt(sSubString);

                            // if so, increment tileset decor list
                            if (bUsed == TRUE)
                            {
                                nTilesetObjectNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecor");
                                nTilesetObjectNum++;
                                SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecor", nTilesetObjectNum);
                                SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecor" + IntToString(nTilesetObjectNum), nObject);
                                DebugMessage("    Added nTileset" + IntToString(nTileset) + "OpenDecor" + IntToString(nTilesetObjectNum) + " at " + IntToString(nObject));
                            }
                            }

                        nObject++;
                    }

                    // if this process is finished
                    if (nObject > nObjectNum)
                    {
                        DebugMessage("  Completed generation.");

                        SetLocalInt(GetModule(), "nQueueMin", 1);

                        SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecorGenerated", TRUE);
                    } else
                    {
                        SetLocalInt(GetModule(), "nQueueMin", nMaxLine);
                    }

                    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
                } else if (GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecorGenerated") == FALSE) // wall decor list
                {
                    DebugMessage("  Wall decor objects for this tileset have not been generated.");

                    nObjectNum = GetLocalInt(GetModule(), "nDecor");
                    nObject = GetLocalInt(GetModule(), "nQueueMin");
                    nMaxLine = nObject + 100;
                    while ((nObject <= nObjectNum) && (nObject < nMaxLine))
                    {
                        bDecorType = GetLocalInt(GetModule(), "bDecor" + IntToString(nObject) + "Wall");
                        DebugMessage("    bDecor" + IntToString(nObject) + "Wall is " + IntToString(bDecorType));
                        if (bDecorType == TRUE)
                        {
                            sTilesets = GetLocalString(GetModule(), "sDecor" + IntToString(nObject) + "Tilesets");
                            sSubString = GetSubString(sTilesets, nTileset - 1, 1);
                            DebugMessage("    Tileset string for wall decor " + IntToString(nObject) + " is " + sTilesets + " with substring " + sSubString);

                            // check to see if this decor item is used by this tileset
                            bUsed = StringToInt(sSubString);

                            // if so, increment tileset decor list
                            if (bUsed == TRUE)
                            {
                                nTilesetObjectNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecor");
                                nTilesetObjectNum++;
                                SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecor", nTilesetObjectNum);
                                SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecor" + IntToString(nTilesetObjectNum), nObject);
                                DebugMessage("    Added nTileset" + IntToString(nTileset) + "WallDecor" + IntToString(nTilesetObjectNum) + " at " + IntToString(nObject));
                            }
                        }

                        nObject++;
                    }

                    // if this process is finished
                    if (nObject > nObjectNum)
                    {
                        DebugMessage("  Completed generation.");

                        SetLocalInt(GetModule(), "nQueueMin", 1);

                        SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecorGenerated", TRUE);
                    } else
                    {
                        SetLocalInt(GetModule(), "nQueueMin", nMaxLine);
                    }

                    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
                } else if (GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoorGenerated") == FALSE) // secret door list
                {
                    DebugMessage("  Secret door objects for this tileset have not been generated.");

                    nObjectNum = GetLocalInt(GetModule(), "nSecretDoor");
                    nObject = GetLocalInt(GetModule(), "nQueueMin");
                    nMaxLine = nObject + 100;
                    while ((nObject <= nObjectNum) && (nObject < nMaxLine))
                    {
                        sTilesets = GetLocalString(GetModule(), "sSecretDoor" + IntToString(nObject) + "Tilesets");
                        sSubString = GetSubString(sTilesets, nTileset - 1, 1);
                        DebugMessage("    Tileset string for secret door " + IntToString(nObject) + " is " + sTilesets + " with substring " + sSubString);

                        // check to see if this decor item is used by this tileset
                        bUsed = StringToInt(sSubString);

                        // if so, increment tileset decor list
                        if (bUsed == TRUE)
                        {
                            nTilesetObjectNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor");
                            nTilesetObjectNum++;
                            SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor", nTilesetObjectNum);
                            SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor" + IntToString(nTilesetObjectNum), nObject);
                            DebugMessage("    Added nTileset" + IntToString(nTileset) + "SecretDoor" + IntToString(nTilesetObjectNum) + " at " + IntToString(nObject));
                        }

                        nObject++;
                    }

                    // if this process is finished
                    if (nObject > nObjectNum)
                    {
                        DebugMessage("  Completed generation.");

                        SetLocalInt(GetModule(), "nQueueMin", 1);

                        SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoorGenerated", TRUE);
                    } else
                    {
                        SetLocalInt(GetModule(), "nQueueMin", nMaxLine);
                    }

                    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
                } else if (GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageTypeGenerated") == FALSE) // damage type list
                {
                    DebugMessage("  Trap damage types for this tileset have not been generated.");

                    nObjectNum = GetLocalInt(GetModule(), "nDamageType");
                    nObject = GetLocalInt(GetModule(), "nQueueMin");
                    nMaxLine = nObject + 100;
                    while ((nObject <= nObjectNum) && (nObject < nMaxLine))
                    {
                        sTilesets = GetLocalString(GetModule(), "sDamageType" + IntToString(nObject) + "Tilesets");
                        sSubString = GetSubString(sTilesets, nTileset - 1, 1);
                        DebugMessage("    Tileset string for damage type " + IntToString(nObject) + " is " + sTilesets + " with substring " + sSubString);

                        // check to see if this decor item is used by this tileset
                        bUsed = StringToInt(sSubString);

                        // if so, increment tileset decor list
                        if (bUsed == TRUE)
                        {
                            nTilesetObjectNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType");
                            nTilesetObjectNum++;
                            SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType", nTilesetObjectNum);
                            SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType" + IntToString(nTilesetObjectNum), nObject);
                            DebugMessage("    Added nTileset" + IntToString(nTileset) + "DamageType" + IntToString(nTilesetObjectNum) + " at " + IntToString(nObject));
                        }

                        nObject++;
                    }

                    // if this process is finished
                    if (nObject > nObjectNum)
                    {
                        DebugMessage("  Completed generation.");

                        SetLocalInt(GetModule(), "nQueueMin", 1);

                        SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageTypeGenerated", TRUE);
                    } else
                    {
                        SetLocalInt(GetModule(), "nQueueMin", nMaxLine);
                    }

                    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
                } else if (GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "ContainerGenerated") == FALSE) // container list
                {
                    DebugMessage("  Containers for this tileset have not been generated.");

                    nObjectNum = GetLocalInt(GetModule(), "nContainer");
                    nObject = GetLocalInt(GetModule(), "nQueueMin");
                    nMaxLine = nObject + 100;
                    while ((nObject <= nObjectNum) && (nObject < nMaxLine))
                    {
                        sTilesets = GetLocalString(GetModule(), "sContainer" + IntToString(nObject) + "Tilesets");
                        sSubString = GetSubString(sTilesets, nTileset - 1, 1);
                        DebugMessage("    Tileset string for container " + IntToString(nObject) + " is " + sTilesets + " with substring " + sSubString);

                        // check to see if this decor item is used by this tileset
                        bUsed = StringToInt(sSubString);

                        // if so, increment tileset decor list
                        if (bUsed == TRUE)
                        {
                            nTilesetObjectNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container");
                            nTilesetObjectNum++;
                            SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container", nTilesetObjectNum);
                            SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container" + IntToString(nTilesetObjectNum), nObject);
                            DebugMessage("    Added nTileset" + IntToString(nTileset) + "Container" + IntToString(nTilesetObjectNum) + " at " + IntToString(nObject));
                        }

                        nObject++;
                    }

                    // if this process is finished
                    if (nObject > nObjectNum)
                    {
                        DebugMessage("  Completed generation.");

                        SetLocalInt(GetModule(), "nQueueMin", 1);

                        SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "ContainerGenerated", TRUE);

                        nActivationProcess++;
                        SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);
                    }

                    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
                } else
                {
                    nActivationProcess++;
                    SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
                }

                break;
            case 1: // generate encounters
                DebugMessage("");
                DebugMessage("Encounter generation.");

                DebugMessage("Awarding discovery points to " + GetName(oPC));
                AwardAreaDiscoveredPoints(oPC);

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                // reset number of active and dead microprocessors
                SetLocalInt(GetModule(), "nMicroNum", 0);
                SetLocalInt(GetModule(), "nMicroDead", 0);

                DelayCommand(0.01, ExecuteScript("exe_id1_actencgn", GetNextCPU()));

                break;

            case 2: // generate bosses
                DebugMessage("");
                DebugMessage("Boss generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                // reset number of active and dead microprocessors
                SetLocalInt(GetModule(), "nMicroNum", 0);
                SetLocalInt(GetModule(), "nMicroDead", 0);

                DelayCommand(0.01, ExecuteScript("exe_id1_actbosgn", GetNextCPU()));

                break;

            case 3: // generate treasure chests
                DebugMessage("");
                DebugMessage("Treasure chest generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_acttrgn", GetNextCPU()));

                break;

            case 4: // generate puzzles and camps
                DebugMessage("");
                DebugMessage("Puzzle and camp generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actpuzgn", GetNextCPU()));

                break;

            case 5: // generate area decor
                DebugMessage("");
                DebugMessage("Area decor generation.");

                SetLocalInt(GetModule(), "nDecorProcess", 1);
                SetLocalInt(GetModule(), "nQueueMin", 1);

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actdecgn", GetNextCPU()));

                break;

            case 6: // generate secret doors
                DebugMessage("");
                DebugMessage("Secret door generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actsdgn", GetNextCPU()));

                break;

            case 7: // generate floor traps
                DebugMessage("");
                DebugMessage("Floor trap generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actfltgn", GetNextCPU()));

                break;

            case 8: // generate generic doors
                DebugMessage("");
                DebugMessage("Generic door generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actgdgn", GetNextCPU()));

                break;

            case 9: // generate plot related
                DebugMessage("");
                DebugMessage("Plot related generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                SetLocalInt(GetModule(), "nCurrentX", 1);

                DelayCommand(0.01, ExecuteScript("exe_id1_actpltgn", GetNextCPU()));

                break;

            case 10: // generate emergency spawns
                DebugMessage("");
                DebugMessage("Emergency spawn generation.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actemrgn", GetNextCPU()));

                break;

            case 11: // clean up
                DebugMessage("");
                DebugMessage("==== AREA GENERATION END ====");
                DebugMessage("");
                DebugMessage("");

                DebugMessage("");
                DebugMessage("Cleaning up generation.");

                // finished generating the level
                SetLocalInt(GetModule(), "bTempAreaGen", FALSE);

                // reset process
                SetLocalInt(GetModule(), "nActivationProcess", 0);

                DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));

                break;
        }
    } else
    {
        AssignCommand(oSpeaker, SpeakString("Activating Area."));

        DebugMessage("Area activation at process " + IntToString(nActivationProcess));

        // determine stage in the area activation process
        switch (nActivationProcess)
        {
            case 0: // clean up destination area
                DebugMessage("");
                DebugMessage("==== AREA ACTIVATION START ====");
                DebugMessage("");
                DebugMessage("");

                DebugMessage("");
                DebugMessage("Cleaning destination area.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actclean", GetNextCPU()));

                break;

            case 1: // spawn treasure chests
                DebugMessage("");
                DebugMessage("Treasure chests spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_acttrsp", GetNextCPU()));

                break;

            case 2: // spawn secret doors
                DebugMessage("");
                DebugMessage("Secret doors spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actsdsp", GetNextCPU()));

                break;

            case 3: // spawn secret treasure
                DebugMessage("");
                DebugMessage("Secret treasure spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actstsp", GetNextCPU()));

                break;

            case 4: // spawn floor traps
                DebugMessage("");
                DebugMessage("Floor traps spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actfltsp", GetNextCPU()));

                break;

            case 5: // spawn generic doors
                DebugMessage("");
                DebugMessage("Generic doors spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actgdsp", GetNextCPU()));

                break;

            case 6: // spawn decor
                DebugMessage("");
                DebugMessage("Decor spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actdecsp", GetNextCPU()));

                break;

            case 7: // door blocker spawn
                DebugMessage("");
                DebugMessage("Door blockers spawning.");

                // because of stupid case statements not allowing variable definitions
                if (TRUE)
                {
                    // check each door and spawn in a blocking object
                    object oArea = GetArea(oDestinationDoor);
                    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
                    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                    int nAreaExit;
                    object oDoor;
                    object oMapNote;
                    vector vMap;
                    location lMap;
                    location lDoor;

                    // if north exit does not exist
                    nAreaExit = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "North");
                    DebugMessage("Area exit nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "North is " + IntToString(nAreaExit));
                    oDoor = GetLocalObject(oArea, "oDoorNorth");
                    if (oDoor != OBJECT_INVALID)
                    {
                        lDoor = GetLocation(oDoor);
                        if (nAreaExit < 1)
                        {
                            CreateObject(OBJECT_TYPE_PLACEABLE, "rubbleblocker", lDoor);
                        } else
                        {
                            vMap = GetPositionFromLocation(lDoor);
                            vMap.y -= 0.5;
                            lMap = Location(oArea, vMap, 0.0);
                            CreateObject(OBJECT_TYPE_WAYPOINT, "map_area_door", lMap);
                        }
                    }

                    // if east exit does not exist
                    nAreaExit = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "East");
                    DebugMessage("Area exit nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "East is " + IntToString(nAreaExit));
                    oDoor = GetLocalObject(oArea, "oDoorEast");
                    if (oDoor != OBJECT_INVALID)
                    {
                        lDoor = GetLocation(oDoor);
                        if (nAreaExit < 1)
                        {
                            CreateObject(OBJECT_TYPE_PLACEABLE, "rubbleblocker", lDoor);
                        } else
                        {
                            vMap = GetPositionFromLocation(lDoor);
                            vMap.x -= 0.5;
                            lMap = Location(oArea, vMap, 0.0);
                            CreateObject(OBJECT_TYPE_WAYPOINT, "map_area_door", lMap);
                        }
                    }

                    // if south exit does not exist
                    nAreaExit = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "South");
                    DebugMessage("Area exit nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "South is " + IntToString(nAreaExit));
                    oDoor = GetLocalObject(oArea, "oDoorSouth");
                    if (oDoor != OBJECT_INVALID)
                    {
                        lDoor = GetLocation(oDoor);
                        if (nAreaExit < 1)
                        {
                            CreateObject(OBJECT_TYPE_PLACEABLE, "rubbleblocker", lDoor);
                        } else
                        {
                            vMap = GetPositionFromLocation(lDoor);
                            vMap.y += 0.5;
                            lMap = Location(oArea, vMap, 0.0);
                            CreateObject(OBJECT_TYPE_WAYPOINT, "map_area_door", lMap);
                        }
                    }

                    // if west exit does not exist
                    nAreaExit = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "West");
                    DebugMessage("Area exit nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "West is " + IntToString(nAreaExit));
                    oDoor = GetLocalObject(oArea, "oDoorWest");
                    if (oDoor != OBJECT_INVALID)
                    {
                        lDoor = GetLocation(oDoor);
                        if (nAreaExit < 1)
                        {
                            CreateObject(OBJECT_TYPE_PLACEABLE, "rubbleblocker", lDoor);
                        } else
                        {
                            vMap = GetPositionFromLocation(lDoor);
                            vMap.x += 0.5;
                            lMap = Location(oArea, vMap, 0.0);
                            CreateObject(OBJECT_TYPE_WAYPOINT, "map_area_door", lMap);
                        }
                    }

                    object oStairs = GetLocalObject(oArea, "oStairsUp");
                    location lStairs = GetLocation(oStairs);
                    if (oStairs != OBJECT_INVALID)
                    {
                        location lStairs = GetLocation(oStairs);
                        vector vStairs = GetPositionFromLocation(lStairs);
                        float fFacing = GetFacing(oStairs);
                        vector vFacing = AngleToVector(fFacing);
                        vector vNormal = VectorNormalize(vFacing);
                        vNormal *= 0.5;
                        vStairs += vNormal;
                        lMap = Location(oArea, vStairs, 0.0);
                        CreateObject(OBJECT_TYPE_WAYPOINT, "map_stairs_up", lStairs);
                    }

                    oStairs = GetLocalObject(oArea, "oStairsDown");
                    if (oStairs != OBJECT_INVALID)
                    {
                        location lStairs = GetLocation(oStairs);
                        vector vStairs = GetPositionFromLocation(lStairs);
                        float fFacing = GetFacing(oStairs);
                        vector vFacing = AngleToVector(fFacing);
                        vector vNormal = VectorNormalize(vFacing);
                        vNormal *= 0.5;
                        vStairs += vNormal;
                        lMap = Location(oArea, vStairs, 0.0);
                        CreateObject(OBJECT_TYPE_WAYPOINT, "map_stairs_down", lStairs);
                    }
                }

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));

                break;

            case 8: // emergency spawns
                DebugMessage("");
                DebugMessage("Emergency objects spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actemrsp", GetNextCPU()));

                break;

            case 9: // plot related spawns
                DebugMessage("");
                DebugMessage("Plots spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actpltsp", GetNextCPU()));

                break;

            case 10: // spawn puzzles and encampments
                DebugMessage("");
                DebugMessage("Puzzles spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actpuzsp", GetNextCPU()));

                break;

            case 11: // spawn bosses
                DebugMessage("");
                DebugMessage("Bosses spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actbossp", GetNextCPU()));

                break;

            case 12: // spawn secret encounters
                DebugMessage("");
                DebugMessage("Secret encounters spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actsesp", GetNextCPU()));

                break;

            case 13: // spawn encounters
                DebugMessage("");
                DebugMessage("Encounter spawning.");

                nActivationProcess++;
                SetLocalInt(GetModule(), "nActivationProcess", nActivationProcess);

                DelayCommand(0.01, ExecuteScript("exe_id1_actencsp", GetNextCPU()));

                break;

            case 14: // clean up
                DebugMessage("");
                DebugMessage("==== AREA ACTIVATION END ====");
                DebugMessage("");
                DebugMessage("");

                DebugMessage("");
                DebugMessage("Cleaning up activation.");

                // reset process
                SetLocalInt(GetModule(), "nActivationProcess", 0);

                // EDIT: check to destination area is a non-plot boss area and spawn teleporter
                if (GetLocalInt(oDungeon, "bBossTeleporter") == TRUE)
                {
                    // check to see if this is a boss area
                    object oArea = GetArea(oDestinationDoor);
                    string sTag = GetTag(oArea);
                    string sSubTag = GetSubString(sTag, 0, 8);
                    DebugMessage("Tag is " + sTag + " and subtag is " + sSubTag);
                    if (sSubTag == "BossArea")
                    {
//                        sSubTag = GetSubString(sTag, 8, 1);
//                        DebugMessage("  Subtag is " + sSubTag);
//                        if (sSubTag != "_")
//                        {
//                        int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
//                        if (nDungeonNumber > 0)
//                        {
                            object oWaypoint = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", oDestinationDoor);

                            // add map pin
                            SetMapPinEnabled(oWaypoint, TRUE);

                            CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
//                        }
                    }
                }

                // main plot variables
                int bBacchaQuest = GetLocalInt(GetModule(), "bBacchaQuestActive");
                int bBacchaQuestCompleted = GetLocalInt(GetModule(), "bBacchaQuestCompleted");
                int bBacchaQuestItem = FALSE;
                int bBacchaDead = GetLocalInt(GetModule(), "bBacchaDead");
                int bHagathaQuest = GetLocalInt(GetModule(), "bHagathaQuestActive");
                int bHagathaQuestCompleted = GetLocalInt(GetModule(), "bHagathaQuestCompleted");
                int bHagathaQuestItem = FALSE;
                int bHagathaDead = GetLocalInt(GetModule(), "bHagathaDead");
                int bMaggrisQuest = GetLocalInt(GetModule(), "bMaggrisQuestActive");
                int bMaggrisQuestCompleted = GetLocalInt(GetModule(), "bMaggrisQuestCompleted");
                int bMaggrisQuestItem = FALSE;
                int bMaggrisDead = GetLocalInt(GetModule(), "bMaggrisDead");
                int bHaratQuest = GetLocalInt(GetModule(), "bHaratQuestActive");
                int bHaratQuestCompleted = GetLocalInt(GetModule(), "bHaratQuestCompleted");
                int bHaratQuestItem = FALSE;
                int bHaratDead = GetLocalInt(GetModule(), "bHaratDead");
                int bGzhorbQuest = GetLocalInt(GetModule(), "bGzhorbQuestActive");
                int bGzhorbQuestCompleted = GetLocalInt(GetModule(), "bGzhorbQuestCompleted");
                int bGzhorbQuestItem = FALSE;
                int bGzhorbDead = GetLocalInt(GetModule(), "bGzhorbDead");
                int bMasteriusQuest = GetLocalInt(GetModule(), "bMasteriusQuestActive");
                int bMasteriusQuestCompleted = GetLocalInt(GetModule(), "bMasteriusQuestCompleted");
                int bMasteriusQuestItem = FALSE;
                int bMasteriusDead = GetLocalInt(GetModule(), "bMasteriusDead");

                // destination items
                int bBacchaFindItem = FALSE;
                int bBacchaItemFound = GetLocalInt(GetModule(), "bBacchaQuestItemFound");
                int bHagathaFindItem = FALSE;
                int bHagathaItemFound = GetLocalInt(GetModule(), "bHagathaQuestItemFound");
                int bMaggrisFindItem = FALSE;
                int bMaggrisItemFound = GetLocalInt(GetModule(), "bMaggrisQuestItemFound");
                int bHaratFindItem = FALSE;
                int bHaratItemFound = GetLocalInt(GetModule(), "bHaratQuestItemFound");
                int bGzhorbFindItem = FALSE;
                int bGzhorbItemFound = GetLocalInt(GetModule(), "bGzhorbQuestItemFound");
                int bMasteriusFindItem = FALSE;
                int bMasteriusItemFound = GetLocalInt(GetModule(), "bMasteriusQuestItemFound");

                object oDestinationDoor2 = oDestinationDoor;

                // for each player
                object oPlayer;
                if (GetLocalInt(GetModule(), "bTransportAll") == TRUE)
                {
                    oPlayer = GetFirstPC();
                } else
                {
                    oPlayer = oPC;
                }
                while (oPlayer != OBJECT_INVALID)
                {
                    DebugMessage("Removing cutscene mode from player " + GetName(oPlayer));

                    // bring out of in cutscene mode
                    if (GetCutsceneMode(oPlayer) == TRUE)
                    {
                        SetCutsceneMode(oPlayer, FALSE);
                    }

                    // clean up this player's map
//                    CleanMap(oPlayer);

                    // explore destination
                    object oArea = GetArea(oDestinationDoor2);
                    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
                    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                    string sPlayer = GetPCIdentifier(oPlayer);
                    string sLevel = "Area" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel);
                    SetExploredState(oPlayer, "", nAreaNum, nCurrentLevel, 1, oDungeon);

                    // reset commoner faction
                    SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPC);

                    // check conditions to see if this should be a cutscene
                    if (GetTag(oArea) == "DungeonEntrance")
                    {
                        int nMainPlot = lt_GetDungeonLevel();
                        int nTriggerPlot = GetLocalInt(GetModule(), "nTriggerPlot");
                        if ((nMainPlot == ID_LOCAL_FIRST_DUNGEON_COMPLETED) && (nTriggerPlot == 1)) // first lieutenant done
                        {
                            object oNarratorArea = GetObjectByTag("NarratorArea");
                            SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 2);
                            SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                            oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                        } else if ((nMainPlot == ID_LOCAL_THIRD_DUNGEON_COMPLETED) && (nTriggerPlot == 2)) // all lieutenants done
                        {
                            object oNarratorArea = GetObjectByTag("NarratorArea");
                            SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 3);
                            SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                            oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                        } else if ((nMainPlot == ID_LOCAL_THIRD_BOSS_DEFEATED) && (nTriggerPlot == 3)) // all inner circle done
                        {
                            object oNarratorArea = GetObjectByTag("NarratorArea");
                            SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 4);
                            SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                            oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                        } else if ((nMainPlot == ID_LOCAL_HALASTER_TIMMY) && (nTriggerPlot == 4)) // halaster done
                        {
                            object oNarratorArea = GetObjectByTag("NarratorArea");
                            SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 5);
                            SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                            oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                        }
                    }

                    // set the respawn point as the dungeon stairs
                    SetLocalObject(oPlayer, "ptr_id1_door", oDestinationDoor);

                    // warp the player
                    DebugMessage("Clearing actions. Point X3.");
                    DelayCommand(0.01, AssignCommand(oPlayer, ClearAllActions()));
                    DelayCommand(0.02, AssignCommand(oPlayer, JumpToObject(oDestinationDoor)));
                    DelayCommand(0.03, AssignCommand(oDestinationDoor, ActionOpenDoor(oDestinationDoor)));
                    ExploreAreaForPlayer(GetArea(oDestinationDoor), oPlayer, FALSE);

                    // setting plot to false to be safe
                    if (GetPlotFlag(oPC) == TRUE)
                    {
                        DebugMessage("Plot flag was set on player.");
                    }
                    SetPlotFlag(oPC, FALSE);

                    // create microprocess searching area entering plots
                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU41");
                    SetLocalInt(oMicroCPU, "nAreaNum", nAreaNum);
                    SetLocalObject(oMicroCPU, "oArea", oArea);
                    DelayCommand(0.01, ExecuteScript("exe_id1_micplot4", oMicroCPU));

                    // cycle to next player
                    if (GetLocalInt(GetModule(), "bTransportAll") == TRUE)
                    {
                        SendMessageToPC(oPlayer, "Entering level " + IntToString(nCurrentLevel) + " of " + GetLocalString(oDungeon, "sDungeonName") + ".");

                        // if this is a level transition, check to see if anyone has needed plot items
                        if ((bBacchaQuest == TRUE) && (bBacchaQuestCompleted == FALSE))
                        {
                            DebugMessage("Baccha's quest is active.");
                            if (GetItemPossessedBy(oPlayer, "itm_id1_anttot_dormant") != OBJECT_INVALID)
                            {
                                DebugMessage("  Baccha's item is present.");
                                bBacchaQuestItem = TRUE;
                            }
                            if (GetItemPossessedBy(oPlayer, "id1_bossplot_ant") != OBJECT_INVALID)
                            {
                                DebugMessage("  Baccha's find item is present.");
                                bBacchaFindItem = TRUE;
                            }
                        }
                        if ((bHagathaQuest == TRUE) && (bHagathaQuestCompleted == FALSE))
                        {
                            DebugMessage("Hagatha's quest is active.");
                            if (GetItemPossessedBy(oPlayer, "itm_id1_widhair_dormant") != OBJECT_INVALID)
                            {
                                DebugMessage("  Hagatha's item is present.");
                                bHagathaQuestItem = TRUE;
                            }
                            if (GetItemPossessedBy(oPlayer, "id1_bossplot_hag") != OBJECT_INVALID)
                            {
                                DebugMessage("  Hagatha's find item is present.");
                                bHagathaFindItem = TRUE;
                            }
                        }
                        if ((bMaggrisQuest == TRUE) && (bMaggrisQuestCompleted == FALSE))
                        {
                            DebugMessage("Maggris' quest is active.");
                            if (GetItemPossessedBy(oPlayer, "itm_id1_maggegg_dormant") != OBJECT_INVALID)
                            {
                                DebugMessage("  Maggris' item is present.");
                                bMaggrisQuestItem = TRUE;
                            }
                            if (GetItemPossessedBy(oPlayer, "id1_bossplot_mag") != OBJECT_INVALID)
                            {
                                DebugMessage("  Maggris' find item is present.");
                                bMaggrisFindItem = TRUE;
                            }
                        }
                        if ((bHaratQuest == TRUE) && (bHaratQuestCompleted == FALSE))
                        {
                            DebugMessage("Harat's quest is active.");
                            if (GetItemPossessedBy(oPlayer, "itm_id1_harattg_dormant") != OBJECT_INVALID)
                            {
                                DebugMessage("  Harat's item is present.");
                                bHaratQuestItem = TRUE;
                            }
                            if (GetItemPossessedBy(oPlayer, "id1_bossplot_har1") != OBJECT_INVALID)
                            {
                                DebugMessage("  Harat's first find item is present.");
                                bHaratFindItem = TRUE;
                            } else
                            {
                                if (GetItemPossessedBy(oPlayer, "id1_bossplot_har2") != OBJECT_INVALID)
                                {
                                    DebugMessage("  Harat's second find item is present.");
                                    bHaratFindItem = TRUE;
                                }
                            }
                        }
                        if ((bGzhorbQuest == TRUE) && (bGzhorbQuestCompleted == FALSE))
                        {
                            DebugMessage("Gzhorb's quest is active.");
                            if (GetItemPossessedBy(oPlayer, "itm_id1_gzrbeye_dormant") != OBJECT_INVALID)
                            {
                                DebugMessage("  Gzhorb's item is present.");
                                bGzhorbQuestItem = TRUE;
                            }
                            if (GetItemPossessedBy(oPlayer, "id1_bossplot_gzb") != OBJECT_INVALID)
                            {
                                DebugMessage("  Gzhorb's find item is present.");
                                bGzhorbFindItem = TRUE;
                            }
                        }
                        if ((bMasteriusQuest == TRUE) && (bMasteriusQuestCompleted == FALSE))
                        {
                            DebugMessage("Masterius' quest is active.");
                            if (GetItemPossessedBy(oPlayer, "itm_id1_masbone_dormant") != OBJECT_INVALID)
                            {
                                DebugMessage("  Masterius' item is present.");
                                bMasteriusQuestItem = TRUE;
                            }
                            if (GetItemPossessedBy(oPlayer, "id1_bossplot_mas") != OBJECT_INVALID)
                            {
                                DebugMessage("  Masterius' find item is present.");
                                bMasteriusFindItem = TRUE;
                            }
                        }

                        // reset NPC factions
//                        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPlayer);
//                        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oPlayer);
//                        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oPlayer);
//                        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPlayer);

                        // cycle to next player
                        oPlayer = GetNextPC();
                    } else
                    {
                        oPlayer = OBJECT_INVALID;
                    }
                }

                // reset little timmy's faction
//                ChangeFaction(GetObjectByTag("id1_littletimmy"), GetObjectByTag("DungeonAngel"));

                if (GetLocalInt(GetModule(), "bTransportAll") == TRUE)
                {
                    // if a needed plot item isn't present
                    if ((bBacchaQuest == TRUE) && (bBacchaQuestCompleted == FALSE) && (bBacchaDead == FALSE))
                    {
                        if (bBacchaQuestItem == FALSE)
                        {
                            DebugMessage("Baccha's item needed.");
                            CreateItemOnObject("itm_id1_anttot1", GetFirstPC());
                        }
                        if ((bBacchaItemFound == TRUE) && (bBacchaFindItem == FALSE))
                        {
                            DebugMessage("Baccha's find item needed.");
                            CreateItemOnObject("id1_bossplot_ant", GetFirstPC());
                        }
                    }
                    if ((bHagathaQuest == TRUE) && (bHagathaQuestCompleted == FALSE) && (bHagathaDead == FALSE))
                    {
                        if (bHagathaQuestItem == FALSE)
                        {
                            DebugMessage("Hagatha's item needed.");
                            CreateItemOnObject("itm_id1_widhair1", GetFirstPC());
                        }
                        if ((bHagathaItemFound == TRUE) && (bHagathaFindItem == FALSE))
                        {
                            DebugMessage("Hagatha's find item needed.");
                            CreateItemOnObject("id1_bossplot_hag", GetFirstPC());
                        }
                    }
                    if ((bMaggrisQuest == TRUE) && (bMaggrisQuestCompleted == FALSE) && (bMaggrisDead == FALSE))
                    {
                        if (bMaggrisQuestItem == FALSE)
                        {
                            DebugMessage("Maggris' item needed.");
                            CreateItemOnObject("itm_id1_maggegg1", GetFirstPC());
                        }
                        if ((bMaggrisItemFound == TRUE) && (bMaggrisFindItem == FALSE))
                        {
                            DebugMessage("Maggris' find item needed.");
                            CreateItemOnObject("id1_bossplot_mag", GetFirstPC());
                        }
                    }
                    if ((bHaratQuest == TRUE) && (bHaratQuestCompleted == FALSE) && (bHaratDead == FALSE))
                    {
                        if (bHaratQuestItem == FALSE)
                        {
                            DebugMessage("Harat's item needed.");
                            CreateItemOnObject("itm_id1_harattg1", GetFirstPC());
                        }
                        if ((bHaratItemFound == TRUE) && (bHaratFindItem == FALSE))
                        {
                            DebugMessage("Harat's find item needed.");
                            CreateItemOnObject("id1_bossplot_har1", GetFirstPC());
                        }
                    }
                    if ((bGzhorbQuest == TRUE) && (bGzhorbQuestCompleted == FALSE) && (bGzhorbDead == FALSE))
                    {
                        if (bGzhorbQuestItem == FALSE)
                        {
                            DebugMessage("Gzhorb's item needed.");
                            CreateItemOnObject("itm_id1_gzrbeye1", GetFirstPC());
                        }
                        if ((bGzhorbItemFound == TRUE) && (bGzhorbFindItem == FALSE))
                        {
                            DebugMessage("Gzhorb's find item needed.");
                            CreateItemOnObject("id1_bossplot_gzb", GetFirstPC());
                        }
                    }
                    if ((bMasteriusQuest == TRUE) && (bMasteriusQuestCompleted == FALSE) && (bMasteriusDead == FALSE))
                    {
                        if (bMasteriusQuestItem == FALSE)
                        {
                            DebugMessage("Masterius' item needed.");
                            CreateItemOnObject("itm_id1_masbone1", GetFirstPC());
                        }
                        if ((bMasteriusItemFound == TRUE) && (bMasteriusFindItem == FALSE))
                        {
                            DebugMessage("Masterius' find item needed.");
                            CreateItemOnObject("id1_bossplot_mas", GetFirstPC());
                        }
                    }

                    // change destination music to infinite dungeons if the target door is a stairs up
                    if (GetTag(oDestinationDoor) == "ID1_STATIC_STAIRSUP")
                    {
                        MusicBackgroundChangeDay(GetArea(oDestinationDoor), 76);
                        MusicBackgroundChangeNight(GetArea(oDestinationDoor), 76);
                        MusicBackgroundPlay(GetArea(oDestinationDoor));
                    }
                }

                // make the dungeon accessible
                SetLocalInt(GetModule(), "bGenerating", FALSE);
                DebugMessage("Setting bGenerating in activation to FALSE");

                break;
        }
    }
}

