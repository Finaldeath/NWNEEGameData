//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_bennart4
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: See below for details.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_cutscene"

void main()
{
    // Define objects used in script
    object oBennart = OBJECT_SELF;
    object oDoor = GetObjectByTag("Voonlar_To_LashansHouse");
    object oSpawn;
    object oTarget = GetWaypointByTag("POST_LashanStocks");;
    object oWaypoint = GetObjectByTag("WP_Bennart_Flee");
    object oJump = GetObjectByTag("WP_Bennart_Jump");

    location lTarget = GetLocation(oTarget);;

    // Create instances of Lashan and Grimswold near stocks in Voonlar
    oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "lashanstocks", lTarget);

    oTarget = GetWaypointByTag("POST_GrimswoldStocks");
    lTarget = GetLocation(oTarget);
    oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "grimswoldstocks", lTarget);

    // Unlock the door to Bennart's house
    SetLocked(oDoor, FALSE);
    SetMapPinEnabled(GetObjectByTag("WatersHouseMapNote"), TRUE);

    // Move Bennart towards his house and jump him there
    PlotLevelSet(GetTag(oBennart), 1);
    SetLocalInt(GetFirstPC(), "lashannothere", 1);
    SetLocalInt(oBennart, "nBusy", 1);
    ActionForceMoveToObject(oWaypoint, FALSE, 1.0, 15.0);
    ActionJumpToObject(oJump);
    ActionDoCommand(SetLocalInt(oBennart, "nBusy", 0));

    // End the cutscene that started this convo
    CutsceneEnd();
}
