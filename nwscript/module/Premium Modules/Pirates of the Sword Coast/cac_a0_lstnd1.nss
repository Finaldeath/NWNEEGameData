//::///////////////////////////////////////////////
//:: cac_a0_lstnd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the Player has ever failed the
    listen check at Alledry's door.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    SetLocalInt(oModule, "cac_a0_lstnd1", TRUE);
}
