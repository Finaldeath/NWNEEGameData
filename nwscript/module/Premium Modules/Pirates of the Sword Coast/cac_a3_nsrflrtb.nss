//::///////////////////////////////////////////////
//:: cac_a3_nsrflrtb
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC Flirted with Nisar in Act 3,
    but Nisar was busy and didn't respond.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "POTSC_A3_NISARROMANCEB", TRUE);
}