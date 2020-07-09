//::///////////////////////////////////////////////
//:: pop_a3_cutseige1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC triggers the seige start cutscene by
    opening the Door.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "inc_global"

void main()
{
    object oPC = GetLastOpenedBy();
    object oArea = GetArea(oPC);
    object oModule = GetModule();
    object oGarm = GetObjectByTag("a1_hench_garm");
    object oNisar = GetObjectByTag("a2_hench_nisar");

    int iDoOnce = GetLocalInt(oModule, "pop_a3_cutseige1");

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "pop_a3_cutseige1", TRUE);

        cs_PreCutsceneFade();
        cs_StartCutscene_Poly("cut_a3_seige1", "exe_a3_sgstrt", 1.0f, FALSE, FALSE, 10, oArea);

        // Add Nisar and Garm to the opener of the door's party.
        if (GetIsObjectValid(oGarm) == TRUE)
        {
            HireHenchman(oPC, oGarm);
        }

        if (GetIsObjectValid(oNisar) == TRUE)
        {
            HireHenchman(oPC, oNisar);
        }
    }
}
