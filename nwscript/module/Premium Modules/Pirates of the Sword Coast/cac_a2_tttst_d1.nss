//::///////////////////////////////////////////////
//:: cac_a2_tttst_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to the Tattooist
    atleast once about bail.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oTattooist = OBJECT_SELF;

    SetLocalInt(oTattooist, "cac_a2_tttst_d1", TRUE);
}
