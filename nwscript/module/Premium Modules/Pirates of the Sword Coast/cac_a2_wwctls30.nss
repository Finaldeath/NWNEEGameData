//::///////////////////////////////////////////////
//:: cac_a2_wwctls30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have Delivered Willigans Cutless
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "inc_willigan"
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_wwctls");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WWCTLS", 30);
    AddJournalQuestEntry("a2_wwctls", 30, oPC);

    // JE: Take the item from the PC, and make Willy equip it.
    A2WillyTakeItem(a2i_Willigan_Cutlass, oPC, OBJECT_SELF);
}
