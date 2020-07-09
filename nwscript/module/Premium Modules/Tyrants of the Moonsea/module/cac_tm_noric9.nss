//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noric9
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Noric is now friendly to PC and hostile to
//       other deputies. Set Bron's Deputy faction to
//       hostile and move Noric into guest chamber.
//
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    object oPC = GetPCSpeaker();
    object oHarfist = GetObjectByTag("DeputyHarfist");
    object oWaypoint = GetObjectByTag("WP_Noric_Move");

    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);

    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_DEFENDER);
    AdjustReputation(oPC, oHarfist, -100);
    ActionMoveToObject(oWaypoint, FALSE);
}
