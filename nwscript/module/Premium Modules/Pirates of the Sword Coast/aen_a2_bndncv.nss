//::///////////////////////////////////////////////
//:: aen_a2_bndncv
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This will fire when the player enters the
    abandon cave in the sandy spit.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "_inc_generic"

void main()
{
    object oEnteringObject = GetEnteringObject();

    if (GetIsPCNotDM(oEnteringObject) == TRUE)
    {
        UpdateSafePoint();
    }
}
