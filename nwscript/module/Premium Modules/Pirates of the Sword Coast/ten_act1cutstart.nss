//::///////////////////////////////////////////////
//:: ten_act1cutstart
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This trigger on enter script will start the
    act1 intro cutscene
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    int iDoOnce = GetLocalInt(OBJECT_SELF, "ten_act1cutstart");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce != TRUE))
    {
        SetLocalInt(OBJECT_SELF, "ten_act1cutstart", TRUE);

        cs_StartCutscene("cut_intro_act1", "ten_a1_plysmn_1", 2.0f, TRUE, FALSE, 1, oArea);
        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK, FADE_SPEED_MEDIUM, oArea);
    }
}
