//::///////////////////////////////////////////////
//:: cac_a2_tat_cs1
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start XPM cutscene, when talking to the
    tattooist in the prison.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 16/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    SetLocalInt(OBJECT_SELF, "EXIT_TO_PARLOR", FALSE);

    object oModule = GetModule();

    //K2 - 4/12/2005 Update the tattooist plot.
    ExecuteScript("exe_a2_tttst50", oModule);
    cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_StartCutscene_Poly("cut_a2_xpm", "cut_a2_xpm_end", 1.5, TRUE);

    // note: delay on destroying this object must be greater than the delay
    // specified above in cs_StartCutscene - otherwise the cutscene never starts
    effect eCutInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutInvis, OBJECT_SELF));
    DestroyObject(OBJECT_SELF, 30.0);
}
