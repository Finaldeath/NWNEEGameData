//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_hirlad3
//:: DATE: January 27, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Ensure the necessary NPC are present.
//:: This script will jump them to their waypoints
//:: should they still be too far away.
//::////////////////////////////////////////////////////

const string NPC_TAG_ASTAR = "Astar";
const string WP_TAG_ASTAR_MOVE = "WP_swaying_astar_2";

const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_MOVE = "WP_swaying_lyressa_2";

const string NPC_TAG_EREMUTH = "Eremuth";
const string WP_TAG_EREMUTH_MOVE = "WP_swaying_eremuth_2";


void jumpNonHenchmen(string sNpcTag, string sWaypointTag, object oPC)
{
    object oNPC = GetObjectByTag(sNpcTag);
    object oWaypoint = GetWaypointByTag(sWaypointTag);

    if ((GetMaster(oNPC) != oPC) &&
        (GetDistanceBetween(oNPC, oWaypoint) >= 1.0f))
    {
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, JumpToLocation(GetLocation(oWaypoint)));
    }
}


void main()
{
    object oPC = GetPCSpeaker();

    jumpNonHenchmen(NPC_TAG_ASTAR, WP_TAG_ASTAR_MOVE, oPC);
    jumpNonHenchmen(NPC_TAG_EREMUTH, WP_TAG_EREMUTH_MOVE, oPC);
    jumpNonHenchmen(NPC_TAG_LYRESSA, WP_TAG_LYRESSA_MOVE, oPC);
}
