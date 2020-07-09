//::///////////////////////////////////////////////
//:: cac_a2_blackr10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Get HoneyPea the scepter of storms from the
    temple of umberlee and she will join your
    crew.

    To aid you, you have received a map of the
    inside of the umberlant temple, where the
    scepter resides.
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

    int iEXP = GetJournalQuestExperience("a2_blackr");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_blackr10");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_blackr10", TRUE);

        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A2_BLACKR", 10);
        AddJournalQuestEntry("a2_blackr", 10, oPC);

        CreateItemOnObject("map_scepter", oPC);
    }
}
