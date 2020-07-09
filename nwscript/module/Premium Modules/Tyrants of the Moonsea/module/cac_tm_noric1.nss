//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noric1
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Noric is charmed so set faction as neutral,
//       and rest of deputies as hostile. Set int to
//       change Noric's reponse and remove cutscene mode.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    object oPC = GetPCSpeaker();

    object oHarfist = GetObjectByTag("DeputyHarfist");

    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_COMMONER);

    AdjustReputation(oPC, oHarfist, -100);

    SetLocalInt(GetFirstPC(), "charmednoric", 1);

    SetCutsceneMode(oPC, FALSE);
    AssignCommand(oPC, SetCameraFacing(90.0, 45.0, 50.0));
    SetWalkCondition(NW_WALK_FLAG_CONSTANT,TRUE);
}
