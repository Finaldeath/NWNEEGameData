//::///////////////////////////////////////////////
//:: cac_a2_kolmar_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Kolmarr
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oKolmarr = OBJECT_SELF;

    SetLocalInt(oModule, "cac_a2_kolmar_d1", TRUE);
}
