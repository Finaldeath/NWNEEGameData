// Orb of Testing

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        oPC = GetItemActivator();
        if (GetIsPC(oPC))
        {
            AssignCommand(oPC, ActionStartConversation(oPC, "zzz_orboftesting", FALSE, FALSE));
        }
    }
}
