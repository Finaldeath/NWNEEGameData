//::///////////////////////////////////////////////
//:: ten_a3_cutshark
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Initiate the cutscene with the sharks in a
    frenzy.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    object oModule = GetModule();
    effect eDisapear = EffectDisappear();
    int iDoOnce = GetLocalInt(oModule, "ten_a3_cutshark");

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "ten_a3_cutshark", TRUE);
        cs_StartCutscene_Poly("cut_a3_shark", "exe_a3_drgnnt", 0.0f, FALSE, FALSE, 10, oArea);
    }
    else if (GetIsEnemy(GetFirstPC(), oPC))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_PERMANENT,
            eDisapear, oPC));
    }
}
