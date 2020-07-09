//::///////////////////////////////////////////////
//:: exe_a1_polyinit
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Poly initiates dialog with the PC on end of
    the South Island intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetPCInArea();
    object oModule = GetModule();
    location lLoc = GetLocation(oPC);
    object oPoly = CreateObject(OBJECT_TYPE_CREATURE, "a1_poly", lLoc, TRUE);
    int iEXP = GetJournalQuestExperience("a1_surviv");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A1_SURVIV", 10);
    AddJournalQuestEntry("a1_surviv", 10, oPC);

    // Init dialog
    DelayCommand(1.0, AssignCommand(oPoly, ClearAllActions(TRUE)));
    DelayCommand(1.01, AssignCommand(oPoly, ActionStartConversation(oPC)));
    DelayCommand(2.0f, SetLocalInt(oModule, "POLY_FOLLOW_ON", TRUE));
    DelayCommand(2.0f, SetLocalObject(oModule, "POLY_FOLLOW", oPC));
}
