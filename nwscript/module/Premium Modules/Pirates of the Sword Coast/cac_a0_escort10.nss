//::///////////////////////////////////////////////
//:: cac_a0_escort10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player has received the Tasina Escort quest. Go
    to the Golden apple and meet Tasina.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_escort");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_ESCORT", 10);
    AddJournalQuestEntry("a0_escort", 10, oPC);
}
