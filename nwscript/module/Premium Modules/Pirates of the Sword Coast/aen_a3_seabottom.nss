//::///////////////////////////////////////////////
//:: aen_a3_seabottom
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start VFX Bubble and the intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_bubbles"
#include "x0_i0_henchman"
#include "inc_global"

void CreateBubbles(object oTarget);

void main()
{
    object oPC = GetEnteringObject();
    object oModule = GetModule();
    object oGarm, oNisar;
    int iDoOnce = GetLocalInt(OBJECT_SELF, "aen_a3_seabottom");

    int iEXP = GetJournalQuestExperience("a3_water");
    iEXP = ConvertPercent(iEXP, 0.10f);

    cs_AreaOnEnter_Poly(oPC);

    if (GetIsPCNotDM(oPC) == TRUE)
    {
        CreateBubbles(oPC);

        if (iDoOnce == FALSE)
        {
            SetLocalInt(OBJECT_SELF, "aen_a3_seabottom", TRUE);

            HandoutQuestXP(oPC, iEXP);
            SetLocalInt(oModule, "A3_WATER", 30);
            AddJournalQuestEntry("a3_water", 30, oPC);

            oGarm = GetObjectByTag("a1_hench_garm");
            if (GetMaster(oGarm) == OBJECT_INVALID)
            {
                HireHenchman(oPC, oGarm);
            }

            CreateBubbles(oGarm);

            oNisar = GetObjectByTag("a2_hench_nisar");
            if (GetMaster(oGarm) == OBJECT_INVALID)
            {
                HireHenchman(oPC, oNisar);
            }

            CreateBubbles(oNisar);

            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            cs_StartCutscene_Poly("cut_a3_fddlrgrn", "exe_autosave", 3.0f, FALSE, FALSE, 10, OBJECT_SELF);

            DelayCommand(1.0f, AssignCommand(oGarm, JumpToLocation(GetLocation(oPC))));
            DelayCommand(1.0f, AssignCommand(oNisar, JumpToLocation(GetLocation(oPC))));
        }
    }
}

