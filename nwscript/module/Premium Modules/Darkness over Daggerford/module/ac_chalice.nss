//::///////////////////////////////////////////////
//:: FileName ac_chalice
//:: When caravan item acquired, variable is incremented,
//::  and journal entry is given
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: July 13, 2006
//:://////////////////////////////////////////////
#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    int i1;
    if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {
        object oItem = GetModuleItemAcquired();
        object oPC = GetItemPossessor(oItem);
        if (GetIsPC(oPC))
        {
            if (GetLocalInt(oPC, "ac_vlad_scav_quest") == 1)
            {
                if (GetLocalInt(oItem, "ac_vlad_scav_quest") == 0)
                {
                    SetLocalInt(oItem, "ac_vlad_scav_quest", 1);
                    i1 = GetLocalInt(oPC, "caravan_items_recovered") +1;
                    SetLocalInt(oPC, "caravan_items_recovered", i1);
                    if (i1 == 3)
                    {
                        AddJournalQuestEntry("j51", 3, oPC);
                    }
                    else
                    {
                        AddJournalQuestEntry("j51", 2, oPC);
                    }
                }
            }
        }
    }
}

