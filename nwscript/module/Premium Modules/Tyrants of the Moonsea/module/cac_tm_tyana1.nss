// sidequest: gorlax - complete

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nXP = GetJournalQuestExperience("GorlaxtheManyEyed");
    GiveXPToCreature(oPC, nXP);
    PlotLevelSet("Tyana", 3);
    SetLocalInt(GetArea(oPC), "HF_REST_DISABLED", 0);
}
