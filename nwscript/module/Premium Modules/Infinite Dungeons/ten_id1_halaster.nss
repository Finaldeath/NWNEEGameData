//::////////////////////////////////////////////////////////////////////////////
//:: ten_id1_halaster
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Enter event script for the triggers in Halaster's area. When Halaster
    enters the trigger the two nearest "summoning" placeables are activated
    via setting local variables.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: ec 5, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

void main()
{
    object oEnter = GetEnteringObject();

    if (GetTag(oEnter) == HALASTER_TAG)
    {
        // Determine the number of player characters in the module.
        int nPlayers = 0;
        object oPC = GetFirstPC();

        while (GetIsObjectValid(oPC))
        {
            ++nPlayers;
            oPC = GetNextPC();
        }

        // 2 elementals should be summoned for every player.
        object oSummon1 = DB_GetNearestObjectByTag("ID1_ELEMENTAL_PLC", OBJECT_SELF, 1);
        object oSummon2 = DB_GetNearestObjectByTag("ID1_ELEMENTAL_PLC", OBJECT_SELF, 2);

        SetLocalInt(oSummon1, "nSummon", nPlayers);
        SetLocalInt(oSummon2, "nSummon", nPlayers);
    }
}
