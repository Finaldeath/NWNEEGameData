//::///////////////////////////////////////////////
//:: cac_a3_dead20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Kolmarr has taken the PC to an island were a
    special item that can defeat the priestesses
    lays hidden. The PC will need to find the
    solutions to the magical markers and leave
    a crewman behind to hold them active.

    The PC should talk to Old Tom to acquire the
    necessary provisions.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a3_dead");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_DEAD", 20);
    AddJournalQuestEntry("a3_dead", 20, oPC);
}
