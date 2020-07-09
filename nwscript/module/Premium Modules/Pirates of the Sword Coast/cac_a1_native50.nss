//::///////////////////////////////////////////////
//:: cac_a1_native50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has met the Troglodytes and has
    been forced to battle their strongest
    warrior, Garm.
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
    SetLocalInt(GetModule(), "A1_NATIVES", 50);
    AddJournalQuestEntry("a1_natives", 50, oPC);
}
