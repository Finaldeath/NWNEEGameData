//::///////////////////////////////////////////////
//:: cac_a0_cargo30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has found Martins in the Seedy Tavern
    but has not yet found the reason for his
    disapearance from the silver sails.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iDoOnce = GetLocalInt(oPC, "cac_a0_cargo30");
    int iEXP = GetJournalQuestExperience("a0_cargo");
    iEXP = ConvertPercent(iEXP, 0.10f);

    if (iDoOnce == FALSE)
    {
        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A0_CARGO", 30);
        AddJournalQuestEntry("a0_cargo", 30, oPC);

        //Flag the DoOnce
        SetLocalInt(oPC, "cac_a0_cargo30", TRUE);
    }
}
