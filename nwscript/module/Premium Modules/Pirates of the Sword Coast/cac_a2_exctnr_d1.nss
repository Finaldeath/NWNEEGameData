//::///////////////////////////////////////////////
//:: cac_a2_exctnr_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to the executioner
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oExecutioner = OBJECT_SELF;

    SetLocalInt(oExecutioner, "cac_a2_exctnr_d1", TRUE);
}
