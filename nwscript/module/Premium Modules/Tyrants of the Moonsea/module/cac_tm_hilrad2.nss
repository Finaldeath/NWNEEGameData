//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_hirlad2
//:: DATE: January 27, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Ensure the necessary NPC are present.
//:: This script will make them start walk towards
//:: their respective waypoints.
//::////////////////////////////////////////////////////

const string NPC_TAG_ASTAR = "Astar";
const string WP_TAG_ASTAR_MOVE = "WP_cut_hilrad_astar_init";

const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_MOVE = "WP_cut_hilrad_lyressa_init";

const string NPC_TAG_EREMUTH = "Eremuth";
const string WP_TAG_EREMUTH_MOVE = "WP_cut_hilrad_eremuth_init";


void MoveHiredHench(string sNpcTag, string sWaypointTag, object oPC)
{
    object oNPC = GetNearestObjectByTag(sNpcTag, oPC);
    object oWaypoint = OBJECT_INVALID;

    if (GetMaster(oNPC) == oPC)
    {
        oWaypoint = GetWaypointByTag(sWaypointTag);
        AssignCommand(oNPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oNPC, 3.0f));
        AssignCommand(oNPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oNPC, ActionMoveToLocation(GetLocation(oWaypoint), TRUE)));
        DelayCommand(1.5f, AssignCommand(oNPC, ActionDoCommand(SetFacing(GetFacing(oWaypoint)))));
    }
}


void main()
{
    object oPC = GetPCSpeaker();

    MoveHiredHench(NPC_TAG_ASTAR, WP_TAG_ASTAR_MOVE, oPC);
    MoveHiredHench(NPC_TAG_EREMUTH, WP_TAG_EREMUTH_MOVE, oPC);
    MoveHiredHench(NPC_TAG_LYRESSA, WP_TAG_LYRESSA_MOVE, oPC);
}
