//::///////////////////////////////////////////////
//:: cac_a0_escort40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player convinces Tasina to open the
    door.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oTasina = GetObjectByTag("a0_tasina");

    SetCommandable(FALSE, oPC);
    SetLocked(OBJECT_SELF, FALSE);

    AssignCommand(oPC, ClearAllActions());

    DelayCommand(0.2f, ActionOpenDoor(OBJECT_SELF));
    DelayCommand(1.0f, AssignCommand(oTasina, ActionStartConversation(oPC)));
    DelayCommand(1.5f, SetCommandable(TRUE, oPC));

    int iEXP = GetJournalQuestExperience("a0_escort");
    iEXP = ConvertPercent(iEXP, 0.40f);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_ESCORT", 40);
    AddJournalQuestEntry("a0_escort", 40, oPC);
}
