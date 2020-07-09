//::///////////////////////////////////////////////
//:: aen_abancamp
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

void main()
{
    object oModule = GetModule();
    object oPC = GetEnteringObject();
    int iDoOnce = GetLocalInt(oModule, "aen_abancamp");

    if ((iDoOnce == FALSE) && (GetIsPC(oPC) == TRUE) && (GetIsDM(oPC) == FALSE))
    {
        SetLocalInt(oModule, "aen_abancamp", TRUE);
        UpdateSafePoint();
    }
}


