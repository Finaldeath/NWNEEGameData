//This is the onacquire script for the infiltrator orc note found in the sewer.

#include "x2_inc_switches"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();

    if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        object oItem = GetModuleItemAcquired();
        object oPC = GetItemPossessor(oItem);
        if (GetIsPC(oPC))
        {
            if (GetLocalInt(oItem, "nTalked") == 0)
            {
                SetLocalInt(oItem, "nTalked", 1);
                FloatingTextStringOnCreature("This note looks important", oPC, FALSE);
                SetLocalInt(GetModule(), "pm_inforcdone", 1);
                AddJournalQuestEntry("j202", 2, oPC);
            }
        }
    }
}

