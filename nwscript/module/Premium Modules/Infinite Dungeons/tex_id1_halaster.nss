//::////////////////////////////////////////////////////////////////////////////
//:: tex_id1_halaster
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Exit event for the triggers in Halaster's area. When Halaster exits the
    trigger the two nearest "summoner" placeables are deactivated via setting
    local vairables.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Dec 5, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

void main()
{
    object oExit = GetExitingObject();

    if (GetTag(oExit) == HALASTER_TAG)
    {
        // Determine the number of players in the module.
        int nPlayers = 0;
        object oPC = GetFirstPC();

        while (GetIsObjectValid(oPC))
        {
            ++nPlayers;
            oPC = GetNextPC();
        }

        // Ensure that the queue won't be incremented above 0 as elementals die.
        object oSummon1 = DB_GetNearestObjectByTag("ID1_ELEMENTAL_PLC", OBJECT_SELF, 1);
        object oSummon2 = DB_GetNearestObjectByTag("ID1_ELEMENTAL_PLC", OBJECT_SELF, 2);

        DelayCommand(40.0, SetLocalInt(oSummon1, "nSummon", 0 - nPlayers));
        DelayCommand(40.0, SetLocalInt(oSummon2, "nSummon", 0 - nPlayers));
    }
}
