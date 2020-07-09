//::///////////////////////////////////////////////
//:: aen_a3_iodintro
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player approaches the island of the dead.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();
    object oGarm, oNisar;
    int iDoOnce = GetLocalInt(OBJECT_SELF, "aen_a3_iodintro");

    cs_AreaOnEnter_Poly(oPC);

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(OBJECT_SELF, "aen_a3_iodintro", TRUE);

        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
        cs_StartCutscene_Poly("cut_a3_iodintro", "exe_a3_jumpiod", 3.0f, TRUE, FALSE, 10, OBJECT_SELF);
    }
}
