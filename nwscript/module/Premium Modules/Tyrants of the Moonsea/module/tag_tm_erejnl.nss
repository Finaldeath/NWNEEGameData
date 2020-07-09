// item event script for Eremuth's Journal

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
            AddJournalQuestEntry("MurderInElmwood", 60, oPC);
            AddJournalQuestEntry("TheUnseen", 10, oPC);
            if (PlotLevelGet("theunseen_status") < 1)
                PlotLevelSet("theunseen_status", 1);
        }
    }
}
