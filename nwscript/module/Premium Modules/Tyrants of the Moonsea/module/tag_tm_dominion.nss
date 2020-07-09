// item event script for the weaker Dominion found in Maganus' chamber

#include "x2_inc_switches"
#include "hf_in_plot"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oItem;
    object oPC;

    if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        oItem = GetModuleItemAcquired();
        oPC = GetModuleItemAcquiredBy();

        if(GetIsPC(oPC) && GetLocalInt(oItem, "nAcquired") == 0)
        {
            int i = 1;

            object oAssassin;

            SetLocalInt(oItem, "nAcquired", 1);
            //We don't want to spawn in future if player returns
            SetLocalInt(GetArea(oPC), "nShadovarAssassinsSpawned", 1);
            //Ensure assassins gather around PC and one initiates dialog
            oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, i);

            while(oAssassin != OBJECT_INVALID)
            {
                if(!GetIsDead(oAssassin))
                {
                    SetLocalInt(oAssassin, "nForceDialog", 1);
                    PlotLevelSet("ShadovarAssassinKT", 6);
                    break;
                }
                i++;
                oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, i);
            }
        }
    }
}
