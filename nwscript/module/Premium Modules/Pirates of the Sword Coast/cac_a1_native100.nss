//::///////////////////////////////////////////////
//:: cac_a1_native100
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has returned the Dwarfs Head to the
    Troglodyte King. The player can now get the
    Troglodytes to build him/her a raft off the
    island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a1_natives");
    object oHead = GetItemPossessedBy(oPC, "a1_edgrimmshead");

    DestroyObject(oHead);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A1_NATIVES", 100);
    AddJournalQuestEntry("a1_natives", 100, oPC);
}
