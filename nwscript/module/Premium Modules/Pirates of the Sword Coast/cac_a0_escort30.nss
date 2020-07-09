//::///////////////////////////////////////////////
//:: cac_a0_escort30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has met the Brigands leading an assault
    on Tasina's room and defeated them. The PC should
    interact with Tasina door and begin escorting her.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "nw_i0_generic"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_escort");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_ESCORT", 30);
    AddJournalQuestEntry("a0_escort", 30, oPC);
}
