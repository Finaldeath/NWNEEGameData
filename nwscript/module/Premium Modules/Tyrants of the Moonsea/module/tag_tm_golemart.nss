// item event script for "The Art of Golem Crafting"
// updated player's journal

#include "x2_inc_switches"
#include "hf_in_plot"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;

    if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        oPC = GetModuleItemAcquiredBy();
        if (GetIsPC(oPC))
        {
            if (PlotLevelGet("Isaac") == 2)
            {
                AddJournalQuestEntry("IkathilosExtraplanarWorkship", 20, oPC);
            }
        }
    }
}
