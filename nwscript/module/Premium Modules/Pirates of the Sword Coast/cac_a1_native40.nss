//::///////////////////////////////////////////////
//:: cac_a1_native40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has read the map but cannot make
    out the writing, but it is clear that there
    are important structures to the east and west.
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

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A1_NATIVES", 40);
    AddJournalQuestEntry("a1_natives", 40, oPC);
}
