//::///////////////////////////////////////////////
//:: Item Event Script
//::
//:: bw_moradinstone
//::
//:: Brian Watson 11/9/2005
//::
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "X0_I0_PARTYWIDE"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    // * This code runs when the item is acquired
    // * Note that this event fires PCs only
    if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        oPC = GetModuleItemAcquiredBy();

        // check for journal update
        string sJournal = "j92"; // relevant quest
        int nStatus = 3;         // status

        string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
        if ((GetLocalInt(oPC, sJournalVar) < nStatus)
            && (GetLocalInt(oPC, sJournalVar) > 0))
        {
            // player needs an update
            AddJournalQuestEntry(sJournal, nStatus, oPC);
        }
    }
}
