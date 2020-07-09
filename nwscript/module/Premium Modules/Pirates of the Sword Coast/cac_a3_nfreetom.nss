//::///////////////////////////////////////////////
//:: cac_a3_nfreetom
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC refuses to Free Old Tom.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March 20, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    SetLocalInt(oModule, "cac_a3_nfreetom", TRUE);
}
