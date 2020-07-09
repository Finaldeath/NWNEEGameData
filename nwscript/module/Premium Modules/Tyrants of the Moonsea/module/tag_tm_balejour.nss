// item event script for Bale Khodolis' Journal found in the Beacon Inn Upstairs

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
            if (PlotLevelGet("Bale") == 1)
            {
                AddJournalQuestEntry("ThentiasResistanceArmy", 20, oPC);
            }
        }
    }
}
