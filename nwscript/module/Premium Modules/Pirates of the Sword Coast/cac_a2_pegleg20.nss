//::///////////////////////////////////////////////
//:: cac_a2_pegleg20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Word is the Peg-Leg has a weakness for ladies
    and the sauce. With a drink or two and a bit
    of flirting it shouldn't be difficult to
    convince him to join you.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_pegleg");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_pegleg20");
    int iPlot = GetLocalInt(oModule, "A2_PEGLEG");

    if ((iDoOnce == FALSE) && (iPlot < 20))
    {
        SetLocalInt(oModule, "cac_a2_pegleg20", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_PEGLEG", 20);
        AddJournalQuestEntry("a2_pegleg", 20, oPC);
    }
}
