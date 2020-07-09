//::///////////////////////////////////////////////
//:: cac_a2_wwgarb40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have Delivered the Willigans Garb.
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

    int iEXP = GetJournalQuestExperience("a2_wwgarb");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WWGARB", 40);
    AddJournalQuestEntry("a2_wwgarb", 40, oPC);

    // JE: Take the item from the PC, and make Willy equip it.
    A2WillyTakeItem(a2i_Willigan_Garb, oPC, OBJECT_SELF);
}
