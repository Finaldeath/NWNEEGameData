// give a journal update when player picks up peredus' bones

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        object oItem = GetModuleItemAcquired();
        object oPC = GetItemPossessor(oItem);
        if (GetIsPC(oPC))
        {
            if (GetLocalInt(oItem, "nTalked") == 0)
            {
                SetLocalInt(oItem, "nTalked", 1);
                AddJournalQuestEntry("j60", 6, oPC);
            }
        }
    }
}

