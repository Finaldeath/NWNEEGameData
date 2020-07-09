//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noric7
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Update journal and remove cutscene mode.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("LocktowerRescue", 71, oPC);

    SetCutsceneMode(oPC, FALSE);
    AssignCommand(oPC, SetCameraFacing(90.0, 45.0, 50.0));
    SetWalkCondition(NW_WALK_FLAG_CONSTANT,TRUE);
}
