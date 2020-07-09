// stegil takes the 4 hearts from the player
// ... this is evil

#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();

    // take the four hearts and "eat" them
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "ks_it_birdheart")
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }

    // update the plot
    PlotLevelSet("ks_stegil", 2);
    SetLocalInt(GetModule(), "StrongholdQuest_druid", 0);

    // this was evil
    AdjustAlignment(oPC, ALIGNMENT_EVIL, 4);

    // update the journal and give some XP
    AddJournalQuestEntry("j86", 8, oPC);
    float fXP = 100.0;
    if (GetAlignmentGoodEvil(oPC) != ALIGNMENT_EVIL)
    {
        fXP -= 50.0;
    }
    GiveQuestXPToCreature(oPC, "j86", fXP);
}

