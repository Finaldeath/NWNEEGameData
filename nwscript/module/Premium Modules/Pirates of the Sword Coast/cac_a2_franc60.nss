//::///////////////////////////////////////////////
//:: cac_a2_franc60
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has paid Francis's debt and
    received the stolen ring from Pete.
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
    object oPete = OBJECT_SELF;
    object oRing = OBJECT_INVALID;
    int iEXP = GetJournalQuestExperience("a2_franc");

    oRing = GetItemPossessedBy(oPete, "a2_petering");

    DestroyObject(oRing);
    TakeGoldFromCreature(5000, oPC);
    CreateItemOnObject("a2_petering", oPC);

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "cac_a2_franc60", TRUE);
    SetLocalInt(oModule, "A2_FRANC", 60);
    AddJournalQuestEntry("a2_franc", 60, oPC);

}
