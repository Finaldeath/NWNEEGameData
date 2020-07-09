//::///////////////////////////////////////////////
//:: aen_a0_psc_intro
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Activate the cutscene on addition of a new
    player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Dec, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "inc_safepoint"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPCNotDM(oPC) == TRUE)
    {
        //BlackScreen(oPC);

        if (cs_GetCutsceneRunning() != FALSE)
        {
            cs_AreaOnEnter(oPC);
        }
        else
        {
            // JE: Only start the cutscene once. If the cutscene is currently
            // running, the check above would have put them into the cutscene.
            // But if the cutscene is over entirely, move this PC to the
            // safe point.
            if( !GetLocalInt(OBJECT_SELF, "aen_a0_psc_intro"))
            {
                SetLocalInt(OBJECT_SELF, "aen_a0_psc_intro", TRUE);
                cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
                cs_StartCutscene("cut_a0_psc_intro", "exe_potscjump", 2.0f,
                    TRUE, TRUE, 1, OBJECT_SELF);
            }
            else
            {
                MoveToSafeLoc(oPC);
            }
        }
    }
}
