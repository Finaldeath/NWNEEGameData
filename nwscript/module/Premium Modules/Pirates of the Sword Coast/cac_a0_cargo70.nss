//::///////////////////////////////////////////////
//:: cac_a0_cargo70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has convinced Rahman that the best
    solution for moving the statue is to levitate
    it. The PC has been tasked with finding a spell
    component so Rahman can execute the spell.
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
    iEXP = ConvertPercent(iEXP, 0.10f);
    int iDoOnce = GetLocalInt(GetModule(), "cac_a0_cargo70");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(GetModule(), "cac_a0_cargo70", TRUE);

        CreateItemOnObject("a0_rahmanskey", oPC);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A0_CARGO", 70);
        AddJournalQuestEntry("a0_cargo", 70, oPC);
    }
}
