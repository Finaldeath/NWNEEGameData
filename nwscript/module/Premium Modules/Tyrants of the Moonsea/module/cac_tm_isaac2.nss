// "Ikathilo's Extraplanar Workshop" quest is completed: reward the player

#include "x0_i0_partywide"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oBook = GetItemPossessedByParty(oPC, "tag_tm_golemart");
    if (GetIsObjectValid(oBook))
    {
        object oTome = CreateItemOnObject("tomeofunderstand", oPC);
        if (GetIsObjectValid(oTome))
        {
            ActionTakeItem(oBook, oPC);
            AddJournalQuestEntry("IkathilosExtraplanarWorkship", 30, oPC);
            GiveXPToCreature(oPC, GetJournalQuestExperience("IkathilosExtraplanarWorkship"));
            PlotLevelSet("Isaac", 3);
        }
    }
}
