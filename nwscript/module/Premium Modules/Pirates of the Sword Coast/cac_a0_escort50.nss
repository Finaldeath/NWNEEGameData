//::///////////////////////////////////////////////
//:: cac_a0_escort50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've spoken with Tasina in her inn room and
    she'll will jump to the Rose as soon as you
    leave the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_escort");
    iEXP = ConvertPercent(iEXP, 0.60f);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_ESCORT", 50);
    AddJournalQuestEntry("a0_escort", 50, oPC);
}
