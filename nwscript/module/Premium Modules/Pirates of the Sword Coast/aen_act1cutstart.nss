//::///////////////////////////////////////////////
//:: aen_act1cutstart
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This area on enter script will start the
    act1 intro cutscene
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "inc_safepoint"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oArea, "ten_act1cutstart");

    if (GetIsPCNotDM(oPC) == TRUE)
    {
        cs_AreaOnEnter(oPC);
        UpdateSafePoint();

        //start the cutscene.
        if ((iDoOnce != TRUE))
        {
            SetLocalInt(OBJECT_SELF, "ten_act1cutstart", TRUE);

            cs_StartCutscene("cut_intro_act1", "exe_a1_polyinit", 2.0f, TRUE, FALSE, 1, oArea);
            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK, FADE_SPEED_MEDIUM, oArea);

            ExecuteScript("exe_a1_escp10", GetModule());
        }
        else
        {
            // Do an autosave.
            ExecuteScript("exe_autosave", GetModule());
        }
    }
}
