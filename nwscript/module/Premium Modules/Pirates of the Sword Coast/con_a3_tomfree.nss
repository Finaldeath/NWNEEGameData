//::///////////////////////////////////////////////
//:: con_a3_tomfree
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Did the PC Free Old Tom?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March 20, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iResult = GetLocalInt(oModule, "cac_a3_freetom");

    return iResult;
}
