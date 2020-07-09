//::///////////////////////////////////////////////
//:: aen_a1_edgrimm
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    a Player has entered Edgrimm's place.
    Level him up.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_balance"

void main()
{
    object oModule = GetModule();
    object oEnter = GetEnteringObject();
    object oEgrimm = GetObjectByTag("a1_edgrimm");
    int iDoOnce = GetLocalInt(oModule, "aen_a1_edgrimm");
    int iEXP = GetJournalQuestExperience("a1_dwarf");

    // on enter Pete's sewers for the first time levelup pete
    if ((GetIsPC(oEnter) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "aen_a1_edgrimm", TRUE);
        LevelUpNPC(oEgrimm);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A1_DWARF", 40);
        AddJournalQuestEntry("a1_dwarf", 40, oEnter);
    }
}
