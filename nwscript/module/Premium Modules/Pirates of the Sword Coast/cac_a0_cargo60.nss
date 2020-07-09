//::///////////////////////////////////////////////
//:: cac_a0_cargo60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Dock hands ran away after hearing that
    Martins feels the statue is cursed. The PC must
    now convince Rahman to levitate the statue.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oDockHand1 = GetObjectByTag("a0_dockhand1");
    object oDockHand2 = GetObjectByTag("a0_dockhand2");
    int iEXP = GetJournalQuestExperience("a0_cargo");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_CARGO", 60);
    AddJournalQuestEntry("a0_cargo", 60, oPC);

    SetLocalInt(oDockHand1, "NO_TALKIE", TRUE);
    SetLocalInt(oDockHand2, "NO_TALKIE", TRUE);
}
