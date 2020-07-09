//::///////////////////////////////////////////////
//:: cac_a3_cutseige2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start the second part of the cutscene in the
    skull and bones seige encounter.
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

    int iDoOnce = GetLocalInt(oModule, "cac_a3_cutseige2");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        //SetLocalInt(oModule, "cac_a3_cutseige2", TRUE);
        ExecuteScript("cut_a3_seige2", oArea);
    }
}
