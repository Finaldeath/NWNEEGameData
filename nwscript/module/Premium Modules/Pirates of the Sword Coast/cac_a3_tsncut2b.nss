//::///////////////////////////////////////////////
//:: cac_a3_tsncut2b
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Trigger the cutscene where tasina loses it
    and attacks the player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    object oModule = GetModule();

    int iDoOnce = GetLocalInt(oModule, "cac_a3_tsncut2b");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "cac_a3_tsncut2b", TRUE);
        ExecuteScript("cut_a3_tasina2b", oArea);
    }
}
