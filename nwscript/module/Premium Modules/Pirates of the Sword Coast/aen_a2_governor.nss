//::///////////////////////////////////////////////
//:: aen_a2_governor
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the PC is being jumped into the area
    to start the X-treme Pirate Makeover
    cutscene, then start it.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 16/05
//:://////////////////////////////////////////////
//:: Modified By: Keith K2 Hayward
//:: Modified On: March 20/05
//::----------------------------------------------
//:: Added a tracking variable so we can see if
//:: the area had been ever entered (Nisars conv)
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oModule = GetModule();
    object oPC = GetEnteringObject();
    int iDoOnce = GetLocalInt(oModule, "aen_a2_governor");

    cs_AreaOnEnter_Poly(oPC);

    if(GetIsPCNotDM(oPC))
    {
        // K2 - Set a flag to note the PC has entered here before.
        if (iDoOnce == FALSE)
        {
            SetLocalInt(oModule, "aen_a2_governor", TRUE);
        }

        // if this variable is set, then we need to start the
        // xpm cutscene when the next pc enters
        if(GetLocalInt(OBJECT_SELF, l_n_XPM_START_CS_ON_AEN))
        {
            SetLocalInt(OBJECT_SELF, l_n_XPM_START_CS_ON_AEN, FALSE);
            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            cs_StartCutscene_Poly("cut_a2_xpm", "cut_a2_xpm_end", 1.5, TRUE);
        }
    }
}
