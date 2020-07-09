//::///////////////////////////////////////////////
//:: X-treme Pirate Makeover (end script)
//:: cut_a2_xpm_end.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    X-treme Pirate Makeover cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 16/05
//:://////////////////////////////////////////////
//:: Modified By: Keith Hayward
//:: Modified On: March 29, 2005
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_global"

void main()
{
    //K2 Set the langer plot variable
    object oPC = GetNearestPC();
    object oModule = GetModule();
    int iEXP = GetJournalQuestExperience("a2_langer");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_LANGER", 50);
    AddJournalQuestEntry("a2_langer", 50, oPC);
}
