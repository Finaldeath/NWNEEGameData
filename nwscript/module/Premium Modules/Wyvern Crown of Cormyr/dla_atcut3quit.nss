//February 2006
//B W-Husey
// End farms cutscene, add journal entry.

#include "x0_i0_henchman"
#include "cu_cameras"
#include "dla_i0_horse"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("MainPlot",12,oPC,TRUE);
    AssignCommand(oPC,RestoreCameraFacing());
    SetCutsceneMode(oPC,FALSE);
}
