//::///////////////////////////////////////////////
//:: aen_a0mr_cut2
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Starts the "cut_mrseige2"on entrance to the
    area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oArea = GetObjectByTag("a0_mr_combat");
    object oPC = GetEnteringObject();
    int iDoOnce = GetLocalInt(oArea, "DOONCE");

    cs_AreaOnEnter(oPC);

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce != TRUE))
    {
        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK, FADE_SPEED_MEDIUM, oArea);
        SetLocalInt(oArea, "DOONCE", TRUE);
        // July 27/04, Jon: cs_StartCutscene parameters changed.
        //cs_StartCutscene(0.0f, TRUE, TRUE, "cut_mrseige2", "", 2, oArea);
        cs_StartCutscene("cut_mrseige2", "exe_a0_a1_jump", 2.5, FALSE, TRUE, 2);
    }
}
