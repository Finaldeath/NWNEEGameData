//::///////////////////////////////////////////////
//:: exe_a1_a2_jump
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Jump the players from Act 1 to Act 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "inc_balance"

void main()
{
    object oModule = GetModule();
    object oCursor = OBJECT_INVALID;
    object oTarget = GetObjectByTag("act_2_island");
    object oWood, oPlans;
    location lTarget = GetLocation(oTarget);

    // Recalculate the global difficulty for the next act
    ReCalcGlobalDif();

    oCursor = GetFirstPC();
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        oWood = GetItemPossessedBy(oCursor, "a1_sacredwood");
        oPlans = GetItemPossessedBy(oCursor, "a1_raftplans");
        DestroyObject(oWood);
        DestroyObject(oPlans);

        ForceRest(oCursor);
        RemovePolymorph(oCursor);

        oCursor = GetNextPC();
    }


    JumpPCsToLocation(lTarget, 2);
}
