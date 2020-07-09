//::///////////////////////////////////////////////
//:: cac_a2_necro20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The crew is ready but until the storm
    subsides there is no way you can set sail.

    Maybe you should talk to some one in the
    Temple of umberlee.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_necro");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_necro20");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_necro20", TRUE);

        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A2_NECRO", 20);
        AddJournalQuestEntry("a2_necro", 20, oPC);
    }
}
