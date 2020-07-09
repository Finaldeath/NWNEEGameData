//::///////////////////////////////////////////////
//:: cac_a0_cargo80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has found the required spell component
    and must return to Rahman to complete the plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_cargo");
    iEXP = ConvertPercent(iEXP, 0.20f);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_CARGO", 80);
    AddJournalQuestEntry("a0_cargo", 80, oPC);
}
