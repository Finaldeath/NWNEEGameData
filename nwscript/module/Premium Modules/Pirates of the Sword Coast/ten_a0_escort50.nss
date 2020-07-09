//::///////////////////////////////////////////////
//:: ten_a0_escort50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tasina is safely aboard the Midnight Rose
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oTasina = GetEnteringObject();
    int iDoOnce = GetLocalInt(oModule, "ten_a0_escort50");

    if ((GetTag(oTasina) == "a0_tasina") && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "ten_a0_escort50", TRUE);

        object oPC = GetMaster(oTasina);
        int iEXP = GetJournalQuestExperience("a0_escort");
        iEXP = ConvertPercent(iEXP, 0.60f);

        FireHenchman(GetMaster(oTasina), oTasina);
        AssignCommand(oTasina, ClearAllActions(TRUE));
        AssignCommand(oTasina, ActionForceMoveToObject(oPC, TRUE, 1.0f, 3.0f));
        AssignCommand(oTasina, ActionStartConversation(oPC));

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A0_ESCORT", 50);
        AddJournalQuestEntry("a0_escort", 50, oPC);
    }
}
