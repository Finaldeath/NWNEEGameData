#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

void main()
{
    // get oPC
    object oPC = GetLocalObject(GetModule(), "oTempPC");

    // get oDestinationDoor
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");

    // get oDungeon
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");

    // get area number
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get stair location
    object oLocation = GetLocalObject(oArea, "oStairsUp");

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    int nPartyLevel = GetPartyLevel(oPC, FALSE);

    // check to see if current area is the first stairs up on the current level
    int nStairsUp = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp1");
    DebugMessage("StairsUp is area " + IntToString(nStairsUp) + " vs current area " + IntToString(nAreaNum));
    if (nAreaNum == nStairsUp)
    {
        string sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);
        DebugMessage("Starting " + sLevel);

        // get the number of creatures
        int nCreatureNum = GetLocalInt(oDungeon, "n" + sLevel + "CreatureNum");
        DebugMessage("There are " + IntToString(nCreatureNum) + " emergency creatures.");
        int nCreature = 1;
        int nCreatureType;
        int nSubType;
        string sCreature;
        string sResRef;
        object oCreature;
        int nPlot;
        int nSpawnType;
        int nAlignment;
        int bDead;
        while (nCreature < nCreatureNum)
        {
            sCreature = sLevel + "Creature" + IntToString(nCreature);
            DebugMessage("Creature is " + sCreature);

            // if creature is not dead
            bDead = GetLocalInt(oDungeon, "b" + sCreature + "Dead");
            if (bDead == FALSE)
            {
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

                DebugMessage("Spawning creature " + IntToString(nCreature) + " with resref " + sResRef);

                oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oLocation));
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
                    SetLocalInt(oCreature, "nCreatureType", 1);
                }

                // set creature variable path
                SetLocalString(oCreature, "sVariable", sCreature);
                DebugMessage("        Set sVariable to " + sCreature);

                // set creature faction
                ChangeToStandardFaction(oCreature, STANDARD_FACTION_HOSTILE);

                nSpawnType = GetLocalInt(oDungeon, "n" + sCreature + "SpawnType");
                if (nSpawnType == 2)
                {
                    SetLocalString(oCreature, "sConversation", "id1_plotdest");
                    DebugMessage("        Set sConversation to id1_plotdest");

                    // set plot creature is involved with
                    nPlot = GetLocalInt(oDungeon, "n" + sCreature + "Plot");
                    SetLocalInt(oCreature, "nPlot", nPlot);
                    DebugMessage("        Set nPlot to " + IntToString(nPlot));

                    // can be lawful/neutral/chaotic
                    nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                    // can be neutral
                    nAlignment = 50 - GetAlignmentGoodEvil(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);
                } else
                {
                    // set creature conversation
                    SetLocalString(oCreature, "sConversation", "");

                    // can be lawful/neutral/chaotic
                    nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                    // can be good/neutral/evil
                    nAlignment = Random(100) + 1 - GetAlignmentGoodEvil(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);
                }
            }

            // cycle to next creature
            nCreature++;
        }

        // get the number of placeables
        int nPlaceableNum = GetLocalInt(oDungeon, "n" + sLevel + "PlaceableNum");
        DebugMessage("There are " + IntToString(nPlaceableNum) + " emergency placeables.");
        int nPlaceable = 1;
        int nPlaceableType;
        string sPlaceable;
        object oPlaceable;
        object oChunk;
        location lLocation;
        while (nPlaceable < nPlaceableNum)
        {
            sPlaceable = sLevel + "Placeable" + IntToString(nPlaceable);

            // determine placeable
            nPlaceableType = GetLocalInt(oDungeon, "n" + sPlaceable);
            nPlot = GetLocalInt(oDungeon, "n" + sPlaceable + "Plot");
            DebugMessage("Plot placeable nPlot" + IntToString(nPlot) + "Placeable is type " + IntToString(nPlaceableType));
            sResRef = GetLocalString(oDungeon, "sListPlotContainer" + IntToString(nPlaceableType) + "ResRef");
            DebugMessage("Resref is " + sResRef);

            // spawn test creature
            lLocation = GetLocation(oLocation);
            oChunk = CreateObject(OBJECT_TYPE_CREATURE, "neutralchunk", lLocation);
            lLocation = GetLocation(oChunk);
            DestroyObject(oChunk);

            oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLocation);

            // set variable on placeable
            SetLocalInt(oPlaceable, "nPlot", nPlot);

            // cycle to next placeable
            nPlaceable++;
        }
    }

    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}

