// xatuum gives the quest, the blood bag, and the first reward

#include "hf_in_plot"
#include "inc_bloodbag"

void main()
{
    object oPC = GetPCSpeaker();

    // give the player the blood bag and knife
    CreateBloodBag(oPC);
    CreateItemOnObject("ks_it_blooddag", oPC, 1);

    // advance the plot and give journal entry
    PlotLevelSet("ks_xatuum", 2);
    AddJournalQuestEntry("j82", 1, oPC);
    SetLocalInt(GetModule(), "StrongholdQuest_bhaal", 1);
}
