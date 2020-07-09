//::///////////////////////////////////////////////
//:: cac_a2_langer_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Long Neck
    Langer atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oLanger = OBJECT_SELF;

    SetLocalInt(oLanger, "cac_a2_langer_d1", TRUE);
}
