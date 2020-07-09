//::///////////////////////////////////////////////
//:: cac_a2_rpete_d2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that this PC has talked to Rascally
    Pete atleast once about francis.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oPlayer = GetPCSpeaker();
    object oPete = OBJECT_SELF;

    SetLocalInt(oPlayer, "cac_a2_rpete_d2", TRUE);
}
