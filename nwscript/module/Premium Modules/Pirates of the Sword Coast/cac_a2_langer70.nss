//::///////////////////////////////////////////////
//:: cac_a2_langer70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Langer has successfully undergone the extreme
    pirate make over and can be found at the
    monkey's cutless
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
//:: Modified By: Jonathan Epp
//:: Modified On: April 21, 2005
//:: Moved functionality to a function, since I
//:: need to call it in the area on-exit script.
//:://////////////////////////////////////////////
#include "inc_govmanor"

void main()
{
    object oPC = GetPCSpeaker();
    LangerLeavesPrison(oPC, GetArea(OBJECT_SELF));
/*
    object oLanger = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_langer");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    SetLocalInt(oLanger, "EXIT_TO_CUTLESS", TRUE);
    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_LANGER", 70);
    AddJournalQuestEntry("a2_langer", 70, oPC);
*/
}
