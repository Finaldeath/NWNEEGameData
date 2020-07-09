// lavna rewards the player for killing the worg

#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oHead = GetItemPossessedBy(oPC, "ks_it_worg_head");
    DestroyObject(oHead);
    AddJournalQuestEntry("j84", 2, oPC);
    GiveQuestXPToCreature(oPC, "j84");
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
}
