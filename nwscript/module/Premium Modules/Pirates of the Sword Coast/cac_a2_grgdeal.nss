//::///////////////////////////////////////////////
//:: cac_a2_grgdeal
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has obtained Special Pricing.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

void main()
{
    object oGrogBeard = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    GiveXPToCreature(oPC, 100);
    SetLocalInt(oPC, "cac_a2_grgdeal", TRUE);
}
