//::///////////////////////////////////////////////
//:: aen_a0_twentyq
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the on area enter script for the
    twenty in a quiver merchant in neverwinter
    Act 0. This script auto balances the guard
    inside.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "inc_balance"

void main()
{
    object oModule = GetModule();
    object oPC = GetEnteringObject();
    object oCursor = GetFirstObjectInArea();
    int iDoOnce = GetLocalInt(oModule, "aen_a0_twentyq");

    if ((iDoOnce == FALSE) && (GetIsPC(oPC) == TRUE) && (GetIsDM(oPC) == FALSE))
    {
        SetLocalInt(oModule, "aen_a0_twentyq", TRUE);

        //Cycle through everything and look for valid targets.
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            // level the guard and the dogs
            if ((GetTag(oCursor) == "a0_orcguard") || (GetTag(oCursor) == "a0_guarddog"))
            {
                    LevelUpNPC(oCursor);
            }

            oCursor = GetNextObjectInArea();
        }
    }
}
