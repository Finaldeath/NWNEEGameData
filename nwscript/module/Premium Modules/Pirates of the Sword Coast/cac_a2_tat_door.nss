//::///////////////////////////////////////////////
//:: Act 2: Note on Tattooist's Door
//:: cac_a2_tat_door
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag the player as having read the note on
     the door of Falstaff's Follies.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On:MArch 18, 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetEnteringObject();
    object oModule = GetModule();

    int iDoOnce = GetLocalInt(oPC, "cac_a2_tat_door");
    int iEXP = GetJournalQuestExperience("a2_tattoo");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oPC, "cac_a2_tat_door", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_TATTOO", 10);
        AddJournalQuestEntry("a2_tattoo", 10, oPC);
    }
}
