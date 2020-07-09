//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noric3
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: All Bron's deputies now hostile except Noric
//       who is destroyed. Remove cutscene mode.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    object oPC = GetPCSpeaker();

    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_COMMONER);

    object oHarfist = GetObjectByTag("DeputyHarfist");

    AdjustReputation(oPC, oHarfist, -100);

    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);

    SetCutsceneMode(oPC, FALSE);
    AssignCommand(oPC, SetCameraFacing(90.0, 45.0, 50.0));
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
