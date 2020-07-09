//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_norci2
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Noric is now friendly to PC and hostile to
//       other deputies. Set Bron's Deputy faction to
//       hostile and move Noric into guest chamber.
//       Int added so Noric's reponse changes and remove
//       cutscene mode.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    object oPC = GetPCSpeaker();
    object oHarfist = GetObjectByTag("DeputyHarfist");
    object oWaypoint = GetObjectByTag("WP_Noric_Move");

    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_DEFENDER);
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);

    AdjustReputation(oPC, oHarfist, -100);

    ActionMoveToObject(oWaypoint, FALSE);

    SetLocalInt(oPC, "dominatednoric", 1);

    SetCutsceneMode(oPC, FALSE);
    AssignCommand(oPC, SetCameraFacing(90.0, 45.0, 50.0));
}
