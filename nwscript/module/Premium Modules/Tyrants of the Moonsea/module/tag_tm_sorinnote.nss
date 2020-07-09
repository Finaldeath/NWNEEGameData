// item event script for Sorin's Note found on Sorin

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
            if(PlotLevelGet("ElmwoodWell") == 0)
            {
                PlotLevelSet("ElmwoodWell", 1);
            }
            AddJournalQuestEntry("HuntingTheTraitor", 40, oPC);
        }
    }
}
