#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

void main()
{
    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
    DebugMessage("  Tileset is " + sTileset + " which is number " + IntToString(nTileset));

    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    int bTilesetGenerated;
    string sTilesetResRef;
    int nDecorNum;
    int nDecor;
    int nMaxLine;
    int nDecorLine;
    int bUsed;
    int nTilesetDecorNum;
    int nDecorPoint;
    int nDecorMax;
    string sLevel;
    int nRandom;
    int nDecorPercentage = GetModuleFlagValue(ID1_FLAG_DECOR_FREQUENCY);
    int nDungeonDecor;
    string sResRef;

    int nDecorProcess = GetLocalInt(GetModule(), "nDecorProcess");
    DebugMessage("  Decor process is " + IntToString(nDecorProcess));
    switch (nDecorProcess)
    {
        case 1: // generate open decor list
            nDecorPoint = 1;
            nDecorMax = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointDecorOpen");
            while (nDecorPoint <= nDecorMax)
            {
                DebugMessage("    On open decor point " + IntToString(nDecorPoint) + " of " + IntToString(nDecorMax));
                sLevel = "Area" + IntToString(nAreaNum) + "WaypointDecorOpen" + IntToString(nDecorPoint) + "Level" + IntToString(nCurrentLevel);

                nRandom = d100();
                if (nRandom <= nDecorPercentage)
                {
                    DebugMessage("      Decor point used.");
                    SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);

                    nTilesetDecorNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecor");
                    nRandom = Random(nTilesetDecorNum) + 1;
                    nDecor = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecor" + IntToString(nRandom));
                    sResRef = GetLocalString(GetModule(), "sDecor" + IntToString(nDecor) + "ResRef");
                    nDungeonDecor = GetLocalInt(oDungeon, "nListDecorOpen_" + sResRef);
                    if (nDungeonDecor == 0) // if not in the list, add
                    {
                        nDungeonDecor = GetLocalInt(oDungeon, "nListDecorOpenNum");
                        nDungeonDecor++;
                        SetLocalInt(oDungeon, "nListDecorOpenNum", nDungeonDecor);
                        SetLocalString(oDungeon, "sListDecorOpen" + IntToString(nDungeonDecor) + "ResRef", sResRef);
                        SetLocalInt(oDungeon, "nListDecorOpen_" + sResRef, nDungeonDecor);
                    }
                    SetLocalInt(oDungeon, "n" + sLevel + "Object", nDungeonDecor);
                    DebugMessage("        Set decor point n" + sLevel + "Object to " + IntToString(nDungeonDecor));
                }

                nDecorPoint++;
            }

            SetLocalInt(GetModule(), "nDecorProcess", 2);
            DelayCommand(0.01, ExecuteScript("exe_id1_actdecgn", GetNextCPU()));

            break;

        case 2: // generate wall decor waypoints
            nDecorPoint = 1;
            nDecorMax = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointDecorWall");
            while (nDecorPoint <= nDecorMax)
            {
                DebugMessage("    On wall decor point " + IntToString(nDecorPoint) + " of " + IntToString(nDecorMax));
                sLevel = "Area" + IntToString(nAreaNum) + "WaypointDecorWall" + IntToString(nDecorPoint) + "Level" + IntToString(nCurrentLevel);

                nRandom = d100();
                if (nRandom <= nDecorPercentage)
                {
                    DebugMessage("      Decor point used.");
                    SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);

                    nTilesetDecorNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecor");
                    nRandom = Random(nTilesetDecorNum) + 1;
                    nDecor = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecor" + IntToString(nRandom));
                    sResRef = GetLocalString(GetModule(), "sDecor" + IntToString(nDecor) + "ResRef");
                    nDungeonDecor = GetLocalInt(oDungeon, "nListDecorWall_" + sResRef);
                    if (nDungeonDecor == 0) // if not in the list, add
                    {
                        nDungeonDecor = GetLocalInt(oDungeon, "nListDecorWallNum");
                        nDungeonDecor++;
                        SetLocalInt(oDungeon, "nListDecorWallNum", nDungeonDecor);
                        SetLocalString(oDungeon, "sListDecorWall" + IntToString(nDungeonDecor) + "ResRef", sResRef);
                        SetLocalInt(oDungeon, "nListDecorWall_" + sResRef, nDungeonDecor);
                    }
                    SetLocalInt(oDungeon, "n" + sLevel + "Object", nDungeonDecor);
                    DebugMessage("        Set decor point n" + sLevel + "Object to " + IntToString(nDungeonDecor));
                }

                nDecorPoint++;
            }

            DebugMessage("Returning to exe_id1_activate.");
            DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));

            break;
    }
}

