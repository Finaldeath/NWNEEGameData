//::///////////////////////////////////////////////
//:: cac_a0_escort20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has learned that Tasina is upstairs and
    some shady characters are after her. The PC
    receives the Key and can continue upstairs.
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
    SetLocalInt(GetModule(), "A0_ESCORT", 20);
    AddJournalQuestEntry("a0_escort", 20, oPC);
    CreateItemOnObject("key_goldenapple", oPC);
}
