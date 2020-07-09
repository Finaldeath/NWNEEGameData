//::///////////////////////////////////////////////
//:: aen_a2_lghths
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Mark the player as having entered the
    Magic Light House Act 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oModule = GetModule();
    object oEnter = GetEnteringObject();
    object oArea = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oModule, "aen_a2_lghths");

    if ((iDoOnce == FALSE) && (GetIsPCNotDM(oEnter) == TRUE))
    {
        SetLocalInt(oModule, "aen_a2_lghths", TRUE);
    }
    else if (GetIsPCNotDM(oEnter))
    {
        ExecuteScript("exe_autosave", GetModule());
    }

    // multiplayer join cutscene.
    cs_AreaOnEnter_Poly(oEnter);
}
