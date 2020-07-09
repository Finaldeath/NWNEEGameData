//::///////////////////////////////////////////////
//:: cac_a2_wwboot30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have Delivered Willigans Boots
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

    int iEXP = GetJournalQuestExperience("a2_wwboot");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WWBOOT", 30);
    AddJournalQuestEntry("a2_wwboot", 30, oPC);

    // JE: Take the item from the PC, and make Willy equip it.
    A2WillyTakeItem(a2i_Willigan_Boots, oPC, OBJECT_SELF);
}
