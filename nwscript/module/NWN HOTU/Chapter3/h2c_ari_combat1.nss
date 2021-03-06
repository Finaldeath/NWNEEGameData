//::///////////////////////////////////////////////
//:: Aribeth, Combat 1-Liner #1 (Condition Script)
//:: H2c_Ari_Combat1.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE as a combat one-liner but will
     only be said once.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: August 15, 2003
//:://////////////////////////////////////////////

int StartingConditional()
{
    // Brad Prince - Added combat check on shouts.
    if(!GetIsObjectValid(GetPCSpeaker()) && GetIsInCombat())
    {
        //DoOnce
        int bDoOnce = GetLocalInt(OBJECT_SELF, "bCombatLine1");
        int bSurrendered = GetLocalInt(OBJECT_SELF, "Generic_Surrender");
        if (bDoOnce == FALSE &&
            bSurrendered == FALSE)
        {
            SetLocalInt(OBJECT_SELF, "bCombatLine1", TRUE);
            return TRUE;
        }
    }
    return FALSE;
}

