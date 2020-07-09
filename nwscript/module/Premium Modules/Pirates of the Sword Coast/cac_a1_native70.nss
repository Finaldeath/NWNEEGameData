//::///////////////////////////////////////////////
//:: cac_a1_native70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You defeated the Troglodyte Champion, he has
    asked you to eat him. Until that time, Garm is your sworn
    servant.
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

    SetLocalInt(GetModule(), "A1_GARMHNCH", 20);

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A1_NATIVES", 70);
    AddJournalQuestEntry("a1_natives", 70, oPC);

    ExecuteScript("exe_a1garmsurr", OBJECT_SELF);
}
