//::///////////////////////////////////////////////
//:: cac_a2_vantab20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Vantabular has agreed to swear loyalty to you
    if you can help him in a task. He originally
    purchased the Lighthouse because there was a
    treasure hidden under it. However, he has
    been unable to find the buried loot.

    If you help him acquire the treasure he'll
    join your crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_vantab");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_VANTAB", 20);
    AddJournalQuestEntry("a2_vantab", 20, oPC);
}
