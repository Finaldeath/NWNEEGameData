//::///////////////////////////////////////////////
//:: cac_a1_native110
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has attacked the troglodytes and
    is now there sworn enemy, there is no way to
    negotiate with them now.
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
    SetLocalInt(GetModule(), "A1_NATIVES", 110);
    AddJournalQuestEntry("a1_natives", 110, oPC);

    ExecuteScript("exe_a1_troghosti", GetModule());
}
