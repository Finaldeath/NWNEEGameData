//::///////////////////////////////////////////////
//:: aen_darkcave
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This on area enter event will reward the
    Player for exploring the "camp" areas. A
    journal entry will explain to the player
    how these camps work.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "_inc_generic"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPCNotDM(oPC) == TRUE)
    {
        ExecuteScript("exe_a1_surviv20", oPC);

        UpdateSafePoint();
    }
}
