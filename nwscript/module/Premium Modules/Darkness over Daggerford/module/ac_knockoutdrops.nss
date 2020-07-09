//::///////////////////////////////////////////////
//:: FileName ac_knockoutdrops
//:: This will fire when using the knockout drops
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 11:59:20 PM
//:://////////////////////////////////////////////

#include "x2_inc_switches"

void Activate()
{
    object oUsed = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    if (GetTag(oTarget) == "ac_harborbottom")
    {
        CreateItemOnObject("ac_taintedharbor", oPC);
        DestroyObject(oUsed);
        DestroyObject(oTarget);
        FloatingTextStringOnCreature("You have created drugged whisky.", oPC);
    }
    else
    {
        FloatingTextStringOnCreature("This does nothing.", oPC);
    }
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        Activate();
    }
}

