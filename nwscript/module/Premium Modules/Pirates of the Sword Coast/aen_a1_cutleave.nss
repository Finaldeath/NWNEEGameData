//::///////////////////////////////////////////////
//:: aen_a1_cutleave
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Activate the escaping the Island cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Dec, 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oWood, oPlans;

    int iDoOnce = GetLocalInt(oArea, "aen_a1_cutleave");
    string sCutscene = GetLocalString(oArea, "ESCAPE");

    cs_AreaOnEnter_Poly(oPC);

    if(GetIsPCNotDM(oPC) == TRUE)
    {

        // Destroy the sacred wood and R.A.F.T. plans
        oWood = GetItemPossessedBy(oPC, "a1_sacredwood");
        oPlans = GetItemPossessedBy(oPC, "a1_raftplans");
        DestroyObject(oWood);
        DestroyObject(oPlans);

        if (iDoOnce != TRUE)
        {
            SetLocalInt(oArea, "aen_a1_cutleave", TRUE);

            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            cs_StartCutscene_Poly(sCutscene, "exe_a1_a2_jump", 2.0f, TRUE, TRUE, 1, oArea);

            ExecuteScript("exe_a1_escp50", GetModule());
        }
    }
}
