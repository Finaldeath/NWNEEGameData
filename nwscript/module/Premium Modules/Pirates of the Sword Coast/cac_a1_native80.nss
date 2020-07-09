//::///////////////////////////////////////////////
//:: cac_a1_native80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You the Troglodyte Champion, Garm. He
    asked you to swear to eat him however you
    have refused. He will wait in the Troglodyte
    village until you change your mind.
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

    SetLocalInt(GetModule(), "A1_GARMHNCH", 10);

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A1_NATIVES", 80);
    AddJournalQuestEntry("a1_natives", 80, oPC);

    ExecuteScript("exe_a1garmsurr", OBJECT_SELF);
}
