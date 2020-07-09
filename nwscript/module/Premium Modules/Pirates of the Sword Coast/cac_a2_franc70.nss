//::///////////////////////////////////////////////
//:: cac_a2_franc70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has successfully tricked Pete out of
    the ring and it is now in their posession.
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
    CreateItemOnObject("a2_petering", oPC);

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "cac_a2_franc70", TRUE);
    SetLocalInt(oModule, "A2_FRANC", 70);
    AddJournalQuestEntry("a2_franc", 70, oPC);

}
