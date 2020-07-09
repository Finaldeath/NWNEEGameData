//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: PC talked to Old Jeffers and know location of the
//:: Graysteel residence
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string DOOR_TAG_GRAYSTEEL = "GraySteeelIN";
const string WP_TAG_GRAYSTEEL = "MN_Mul_ZhQ_GreySteelResidence";


void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("AstarsWidow", 40, oPC);

    object oDoor = GetObjectByTag(DOOR_TAG_GRAYSTEEL);
    SetLocked(oDoor, FALSE);

    object oMapPin = GetWaypointByTag(WP_TAG_GRAYSTEEL);
    SetMapPinEnabled(oMapPin, 1);
    ExploreAreaForPlayer(GetArea(oMapPin), oPC, TRUE);
}
