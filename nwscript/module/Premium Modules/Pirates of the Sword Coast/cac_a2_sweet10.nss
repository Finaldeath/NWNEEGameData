//::///////////////////////////////////////////////
//:: cac_a2_sweet10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have heard of a  Priestess of Umberlee
    called sweet marie. She doesn't seem to like
    here position in the Clergy and is known as
    a sailor of some reputation. Maybe you could
    convince her to join you crew.
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

    int iEXP = GetJournalQuestExperience("a2_sweet");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_sweet10");

    if ((iDoOnce == FALSE) && (GetGender(oPC) == GENDER_MALE))
    {
        SetLocalInt(oModule, "cac_a2_sweet10", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_SWEET", 10);
        AddJournalQuestEntry("a2_sweet", 10, oPC);
    }
}
