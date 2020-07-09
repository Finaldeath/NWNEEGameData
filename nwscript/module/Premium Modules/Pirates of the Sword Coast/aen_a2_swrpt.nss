//::///////////////////////////////////////////////
//:: aen_a2_swrpt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    a Player has entered pete's place.
    Level him up.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_balance"

void main()
{
    object oModule = GetModule();
    object oEnter = GetEnteringObject();
    object oPete = GetObjectByTag("oPete");
    int iDoOnce = GetLocalInt(oModule, "aen_a2_swrpt");

    // on enter Pete's sewers for the first time levelup pete
    if ((GetIsPC(oEnter) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "aen_a2_swrpt", TRUE);
        LevelUpNPC(oPete);
    }
}
