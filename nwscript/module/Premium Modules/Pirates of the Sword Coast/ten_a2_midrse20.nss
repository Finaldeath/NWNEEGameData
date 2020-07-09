//::///////////////////////////////////////////////
//:: ten_a2_midrse20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've found Nisar and the Rose in Harbor,
    but to man it you'll need a five man crew
    and a clear sky.

    Nisar joins the Party.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
//:: Modified By: Keith K2 Hayward
//:: Modified On: March 2005
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "_inc_generic"

void main()
{
    object oPC = GetEnteringObject();
    object oModule = GetModule();
    object oNisar = GetNearestObjectByTag("a2_hench_nisar", oPC);

    int iEXP = GetJournalQuestExperience("a2_midrose");
    int iPlot = GetLocalInt(oModule, "A2_MIDROSE");
    int iDoOnce = GetLocalInt(OBJECT_SELF, "ten_a2_midrse20");

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce != TRUE) && (iPlot < 20))
    {
        SetLocalInt(OBJECT_SELF, "ten_a2_midrse20", TRUE);

        AssignCommand(oPC, ClearAllActions(TRUE));
        SetCommandable(FALSE, oPC);
        AssignCommand(oNisar, ActionForceMoveToObject(oPC, TRUE, 1.0f, 5.0f));
        AssignCommand(oNisar, ActionStartConversation(oPC));
        DelayCommand(2.0f, SetCommandable(TRUE, oPC));

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_MIDROSE", 20);
        AddJournalQuestEntry("a2_midrose", 20, oPC);
    }
}
