//::////////////////////////////////////////////////////
//:: Henchmen initiate dialog upon entering the
//:: Swaying Bough inn in Elventree
//::////////////////////////////////////////////////////

#include "hf_in_henchman"

const string NPC_TAG_LYRESSA = "Lyressa";
const string NPC_RESREF_LYRESSA = "lyressa";

const string NPC_TAG_ASTAR = "Astar";
const string NPC_RESREF_ASTAR = "astar";

const string NPC_TAG_EREMUTH = "Eremuth";
const string NPC_RESREF_EREMUTH = "eremuth";


// Make sure the NPC are actually here
// (This should have been setup in "cut_tm_hillsfar" already)
void setupNPC(object oPC)
{
    object oNPC = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    oNPC = GetObjectByTag(NPC_TAG_ASTAR);
    oWaypoint = GetWaypointByTag("WP_Astar_Swaying");
    if (GetIsObjectValid(oNPC))
    {
        if (GetArea(oNPC) != GetArea(oWaypoint))
        {
            AssignCommand(oNPC, ClearAllActions());
            AssignCommand(oNPC, ActionJumpToLocation(GetLocation(oWaypoint)));
            HenchmanSetHome(oNPC, GetLocation(oWaypoint));
        }
    }
    else
    {
        oNPC = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ASTAR, GetLocation(oWaypoint));
        HenchmanSetHome(oNPC, GetLocation(oWaypoint));
    }

    oNPC = GetObjectByTag(NPC_TAG_EREMUTH);
    oWaypoint = GetWaypointByTag("WP_Eremuth_Swaying");
    if (GetIsObjectValid(oNPC))
    {
        if (GetArea(oNPC) != GetArea(oWaypoint))
        {
            AssignCommand(oNPC, ClearAllActions());
            AssignCommand(oNPC, ActionJumpToLocation(GetLocation(oWaypoint)));
            HenchmanSetHome(oNPC, GetLocation(oWaypoint));
        }
    }
    else
    {
        oNPC = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_EREMUTH, GetLocation(oWaypoint));
        HenchmanSetHome(oNPC, GetLocation(oWaypoint));
    }

    oNPC = GetObjectByTag(NPC_TAG_LYRESSA);
    oWaypoint = GetWaypointByTag("WP_Lyressa_Swaying");
    if (GetIsObjectValid(oNPC))
    {
        if (GetArea(oNPC) != GetArea(oWaypoint))
        {
            AssignCommand(oNPC, ClearAllActions());
            AssignCommand(oNPC, ActionJumpToLocation(GetLocation(oWaypoint)));
            HenchmanSetHome(oNPC, GetLocation(oWaypoint));
        }
    }
    else
    {
        oNPC = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_LYRESSA, GetLocation(oWaypoint));
        HenchmanSetHome(oNPC, GetLocation(oWaypoint));
    }
}


void main()
{
    object oPC = GetEnteringObject();
    object oLyressa = GetObjectByTag(NPC_TAG_LYRESSA);

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") == 0))
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        setupNPC(oPC);
        SetLocalInt(oPC, "hench_interject", 3);
        AssignCommand(oPC, ClearAllActions(TRUE));
        // SetCutsceneMode(oPC, TRUE);

        DelayCommand(1.0, AssignCommand(oLyressa, ActionStartConversation(oPC, "tm_hench_inter")));
    }
}
