//::///////////////////////////////////////////////
//:: cac_a0_tasfrnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC was nice to Tasina aboard
    the Midnight Rose.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    SetLocalInt(oModule, "POTSC_A0_TASINAFRIENDLY", TRUE);
}
