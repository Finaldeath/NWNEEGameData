//::///////////////////////////////////////////////
//:: aen_id1_gzhorb_c
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Area on enter for the boss fight intro
    cutscene for G'Zhorb.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 6, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    if(GetIsPCNotDM(GetEnteringObject()))
    {
        if(!cs_GetCutsceneRunning())
        {
            // Just to be safe, when repeating the cutscene we should use a
            // different cutscene number.
            int nCutNumber = GetLocalInt(OBJECT_SELF, "cs_last_cut_number") + 1;
            SetLocalInt(OBJECT_SELF, "cs_last_cut_number", nCutNumber);

            cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, TRUE);
            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            cs_StartCutscene("cut_id1_gzhorb", "cut_id1_gzhorb_e", 2.0, TRUE, TRUE, nCutNumber);
        }
    }
}
