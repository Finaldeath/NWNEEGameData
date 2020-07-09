//::///////////////////////////////////////////////
//:: cac_a0_seige30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You'll need something to enhance your
    hearing if your to listen in on their
    conversation.

    Maybe you can find a cup in the hold.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_seige");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_SEIGE", 30);
    AddJournalQuestEntry("a0_seige", 30, oPC);

    ExecuteScript("cac_a0_lstnd1", OBJECT_SELF);
}
