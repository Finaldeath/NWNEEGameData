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

    int nPartyLevel = GetPartyLevel(oPC, FALSE);

    string sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointEncounter";

    // get number of encounter waypoints
    int nWaypointNum = GetLocalInt(oDungeon, "n" + sWaypoint);

    string sLevel;
    int nCreatureNum;
    int nCreature;
    string sCreature;
    int nCreatureType;
    string sResRef;
    int nSubType;
    object oCreature;
    int nPlot;
    int bActivated;
    int nMicroNum;
    object oMicroCPU;

    int nAlignment;

    object oWaypoint;
    int bUsed;
    int bDead;

    DebugMessage("Spawning " + IntToString(nWaypointNum) + " encounter points.");

    int nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sLevel = sWaypoint + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);

        // if there are creatures at this waypoint
        bUsed = GetLocalInt(oDungeon, "b" + sLevel + "Used");
        if (bUsed == TRUE)
        {
            DebugMessage("Waypoint " + IntToString(nWaypoint) + " is used.");

            oWaypoint = GetLocalObject(oArea, "oWaypointEncounter" + IntToString(nWaypoint));

            nCreatureNum = GetLocalInt(oDungeon, "n" + sLevel + "Size");
            DebugMessage("There are " + IntToString(nCreatureNum) + " creatures.");

            nCreature = 1;
            while (nCreature <= nCreatureNum)
            {
                sCreature = sLevel + "Creature" + IntToString(nCreature);

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

                    DebugMessage("Spawning creature " + IntToString(nCreatureType) + " with resref " + sResRef);

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
                        SetLocalInt(oCreature, "nCreatureType", 1);
                    }

                    // set creature variable path
                    SetLocalString(oCreature, "sVariable", sCreature);
                    DebugMessage("        Set sVariable to " + sCreature);

                    // set creature faction
                    ChangeToStandardFaction(oCreature, STANDARD_FACTION_HOSTILE);

                    // set creature conversation
                    SetLocalString(oCreature, "sConversation", "");

                    // can be lawful/neutral/chaotic
                    nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                    // can be good/neutral/evil
                    nAlignment = Random(100) + 1 - GetAlignmentGoodEvil(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);
                }

                nCreature++;
            }
        }

        nWaypoint++;
    }

    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}
