//::///////////////////////////////////////////////
//:: cac_a2_spndrf10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has wasted up on the shore of Spindrift
    island.
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

    int iEXP = GetJournalQuestExperience("a2_spndrf");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_spndrf10");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_spndrf10", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_SPNDRF", 10);
        AddJournalQuestEntry("a2_spndrf", 10, oPC);
    }

    //RB: Set his talked to variable here rather than waiting until the next node.
    SetLocalInt(oModule, "cac_a2_vantab_d1", TRUE);
    SetLocalInt(OBJECT_SELF, "cac_a2_drclrc_d1", TRUE);

    //JE: Set a variable so that on conversation end Vantabular will
    //walk to the lighthouse.
    SetLocalInt(OBJECT_SELF, "EXIT_TO_LIGHTHOUSE", TRUE);
}
