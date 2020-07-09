//::///////////////////////////////////////////////
//:: cac_a2_ioutatt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the Tattooists IOU?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oIOU = GetItemPossessedBy(oPC, "a2_ioutatt");

    // Does a IOU for the executioner exist in the PC's inventory?
    if (GetIsObjectValid(oIOU) == TRUE)
    {
        DestroyObject(oIOU);
    }

    SetLocalInt(GetModule(), "A2_TTTST", 40);
    AddJournalQuestEntry("a2_tttst", 40, oPC);
}
