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

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    string sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointPlot";
    string sLevel;

    int nPartyLevel = GetPartyLevel(oPC, FALSE);


    int nGiverType;
    string sPlot;
    int nPlotNum;
    int nPlot;
    int nSpawnType;
    object oMicroCPU;
    string sCreature;
    int nCreatureType;
    int nSubType;
    string sResRef;
    object oCreature;
    object oWaypoint;
    int nPlotID;
    object oPlaceable;
    int nPlaceableType;

    int nAlignment;
    int bDead;
    int bGone;

    object oChunk;
    location lLocation;

    string sName;
    int bCompleted;
    int bFailed;

    // go through each plot waypoint
    int nWaypointNum = GetLocalInt(oDungeon, "n" + sWaypoint);
    DebugMessage("Number of waypoints to examine: " + IntToString(nWaypointNum));
    int nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        DebugMessage("Spawning plot waypoint " + IntToString(nWaypoint));

        oWaypoint = GetLocalObject(oArea, "oWaypointPlot" + IntToString(nWaypoint));

        // get number of plots
        sLevel = sWaypoint + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
        nPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "PlotNum");
        DebugMessage("  There are " + IntToString(nPlotNum) + " plots at " + sLevel);
        nPlot = 1;
        while (nPlot <= nPlotNum)
        {
            DebugMessage("  Spawning plot " + IntToString(nPlot));

            sPlot = sLevel + "Plot" + IntToString(nPlot);
            DebugMessage("    sPlot is " + sPlot);

            nPlotID = GetLocalInt(oDungeon, "n" + sPlot);
            DebugMessage("    nPlotID is " + IntToString(nPlotID));

            bCompleted = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlotID) + "Completed");
            bFailed = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlotID) + "Failed");
            DebugMessage("    bCompleted is " + IntToString(bCompleted) + ", bFailed is " + IntToString(bFailed));

            if ((bCompleted == FALSE) && (bFailed == FALSE))
            {
                sCreature = sPlot + "Object";
                DebugMessage("    sCreature is " + sCreature);

                // get spawn type
                nSpawnType = GetLocalInt(oDungeon, "n" + sPlot + "SpawnType");
                DebugMessage("    Spawn type " + IntToString(nSpawnType));

                // spawn plot givers and destinations
                if ((nSpawnType == 1) || (nSpawnType == 2))
                {
                    bDead = GetLocalInt(oDungeon, "b" + sCreature + "Dead");
                    bGone = GetLocalInt(oDungeon, "b" + sCreature + "Gone");
                    if ((bDead == FALSE) && (bGone == FALSE))
                    {
                        if (nSpawnType == 1)
                        {
                            DebugMessage("    Spawning plot giver.");
                            CreateObject(OBJECT_TYPE_WAYPOINT, "map_plot", GetLocation(oWaypoint));
                        } else if (nSpawnType == 2)
                        {
                            DebugMessage("    Spawning destination creature.");
                        }

                        nCreatureType = GetLocalInt(oDungeon, "n" + sCreature);

                        sResRef = "";

                        // if a valid creature
                        if (nCreatureType > 0)
                        {
                            sResRef = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "ResRef");
                        }

                        if (sResRef == "") // spawn a penguin
                        {
                            sResRef = "id1_penguin";
                        }

                        DebugMessage("      Spawning creature with resref " + sResRef);

                        oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oWaypoint));
                        if (sResRef == "id1_penguin")
                        {
                            SetLocalInt(oCreature, "nCreatureType", 3);
                            SetLocalInt(oCreature, "nCR", nPartyLevel);
                            SetLocalInt(oCreature, "nBaseHD", 1);
                            SetLocalInt(oCreature, "nClassStartHD", 1);
                            SetLocalInt(oCreature, "nClass", -1);
                            SetName(oCreature, "Penguin CR " + IntToString(nPartyLevel));
                        } else
                        {
                            // set creature type (1 = enemy, 2 = ally)
                            SetLocalInt(oCreature, "nCreatureType", 2);
                        }

                        // set creature variable path
                        SetLocalString(oCreature, "sVariable", sCreature);
                        DebugMessage("        Set sVariable to " + sCreature);

                        // set creature to neutral
                        AssignCommand(oCreature, SurrenderToEnemies());
                        ChangeToStandardFaction(oCreature, STANDARD_FACTION_COMMONER);
    //                    DelayCommand(0.01, ChangeFaction(oCreature, GetObjectByTag("DungeonAngel")));

                        // set creature conversation
                        if (nSpawnType == 1)
                        {
                            SetLocalString(oCreature, "sConversation", "id1_plotgiver");
                            DebugMessage("        Set sConversation to id1_plotgiver");

                            // set name
                            sName = GetLocalString(oDungeon, "s" + sCreature + "Name");
                            SetName(oCreature, sName);
                        } else if (nSpawnType == 2)
                        {
                            SetLocalString(oCreature, "sConversation", "id1_plotdest");
                            DebugMessage("        Set sConversation to id1_plotdest");

                            // set name
                            sName = GetLocalString(oDungeon, "sPlot" + IntToString(nPlotID) + "CreatureName");
                            SetName(oCreature, sName);
                        }

                        // can be lawful/neutral/chaotic
                        nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                        AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                        // can be neutral
                        nAlignment = 50 - GetAlignmentGoodEvil(oCreature);
                        AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);

                        // set plot creature is involved with
                        SetLocalInt(oCreature, "nPlot", nPlotID);
                        DebugMessage("        Set nPlot to " + IntToString(nPlotID));
                    }
                } else if (nSpawnType == 3) // destination placeable
                {
                    DebugMessage("    Spawning destination placeable.");

                    // determine placeable
                    nPlaceableType = GetLocalInt(oDungeon, "nPlot" + IntToString(nPlotID) + "Placeable");
                    DebugMessage("Plot placeable nPlot" + IntToString(nPlotID) + "Placeable is type " + IntToString(nPlaceableType));
                    sResRef = GetLocalString(oDungeon, "sListPlotContainer" + IntToString(nPlaceableType) + "ResRef");
                    DebugMessage("Resref is " + sResRef);

                    // spawn test creature
                    lLocation = GetLocation(oWaypoint);
                    oChunk = CreateObject(OBJECT_TYPE_CREATURE, "neutralchunk", lLocation);
                    lLocation = GetLocation(oChunk);
                    DestroyObject(oChunk);

                    // spawn at determined location
                    oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLocation);

                    // set variable on placeable
                    SetLocalInt(oPlaceable, "nPlot", nPlotID);
                } else
                {
                    DebugMessage("    Illegal spawn type.");
                }
            }

            nPlot++;
        }

        nWaypoint++;
    }


    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}

