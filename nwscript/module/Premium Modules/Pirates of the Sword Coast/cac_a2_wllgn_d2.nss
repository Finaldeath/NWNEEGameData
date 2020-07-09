//::///////////////////////////////////////////////
//:: cac_a2_wllgn_d2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Whipped
    Willigan atleast once since he's arrived at
    the monkeys cutless.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oWilligan = OBJECT_SELF;
    SetLocalInt(oWilligan, "cac_a2_wllgn_d2", TRUE);
}
