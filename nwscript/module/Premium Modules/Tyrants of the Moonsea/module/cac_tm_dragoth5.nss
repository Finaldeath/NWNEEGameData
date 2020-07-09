// player refuses lyressa's ritual; dragoth lives on
// sidequest: dragoth the bone mage

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("DragothTheBoneMage", 3);
    AddJournalQuestEntry("DragothTheBoneMage", 40, oPC);
    int nXP = GetJournalQuestExperience("DragothTheBoneMage");
    GiveXPToCreature(oPC, nXP);
}
