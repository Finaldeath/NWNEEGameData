//::///////////////////////////////////////////////
//:: cac_a0_oncedw1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script sets a DO ONCE variable on the dock
    workers in the Silver Sails.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "cac_a0_oncedw1", TRUE);
}
