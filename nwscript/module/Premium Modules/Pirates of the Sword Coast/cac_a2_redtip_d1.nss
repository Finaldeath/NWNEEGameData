//::///////////////////////////////////////////////
//:: cac_a2_redtip_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Red Tip
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oRedTip = OBJECT_SELF;

    SetLocalInt(oRedTip, "cac_a2_redtip_d1", TRUE);
}