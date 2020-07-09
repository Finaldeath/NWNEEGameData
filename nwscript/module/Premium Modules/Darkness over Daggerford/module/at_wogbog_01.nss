// the player gives wogbog's stick back to him

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oStick = GetItemPossessedBy(oPC, "ks_wogbogs_stick");
    DestroyObject(oStick);
    AddJournalQuestEntry("j81", 3, oPC);
    GiveXPToCreature(oPC, GetJournalQuestExperience("j81"));
    AdjustAlignment(oPC, ALIGNMENT_GOOD, 5);
    PlotLevelSet(GetTag(OBJECT_SELF), 3); // gave wogbog his stick
}
