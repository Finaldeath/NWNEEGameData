//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: tag_tm_hlaavinm0
//:: DATE: January 28, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Item event script for Hlaavins Missive
//::////////////////////////////////////////////////////

#include "x2_inc_switches"
#include "hf_in_plot"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;

    if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        oPC = GetModuleItemAcquiredBy();
        if (GetIsPC(oPC) && (PlotLevelGet("theunseen_status") < 3))
        {
            AddJournalQuestEntry("TheUnseen", 30, oPC);
            PlotLevelSet("theunseen_status", 3);
        }
    }
}
