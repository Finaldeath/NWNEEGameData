//::///////////////////////////////////////////////
//:: cac_a3_tsncut2a
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Trigger the cutscene where Tasina joins the
    player and the guardian interrupts.
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

    int iDoOnce = GetLocalInt(oModule, "cac_a3_tsncut2a");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "cac_a3_tsncut2a", TRUE);
        ExecuteScript("cut_a3_tasina2a", oArea);
    }
}
