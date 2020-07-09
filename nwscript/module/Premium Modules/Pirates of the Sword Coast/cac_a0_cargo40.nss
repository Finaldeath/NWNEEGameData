//::///////////////////////////////////////////////
//:: cac_a0_cargo40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has talked to Martins and heard Martins
    story about the vision the stature gave him.
    The PC must go back to the Silver sails to
    resolve the plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_cargo");
    iEXP = ConvertPercent(iEXP, 0.20f);
    int iDoOnce = GetLocalInt(oModule, "cac_a0_cargo40");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a0_cargo40", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A0_CARGO", 40);
        AddJournalQuestEntry("a0_cargo",40, oPC);
    }
}
