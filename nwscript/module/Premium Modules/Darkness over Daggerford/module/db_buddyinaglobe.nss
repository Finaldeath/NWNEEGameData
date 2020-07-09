// the player picks up tala-in-a-globe
// ... she talks to the player the first time

#include "x2_inc_switches"
#include "hf_in_talatalk"

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
                TalaTalk(oPC);
            }
        }
    }
}
