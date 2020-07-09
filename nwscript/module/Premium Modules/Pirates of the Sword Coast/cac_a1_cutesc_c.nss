//::///////////////////////////////////////////////
//:: cac_a1_cutesc_c
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start End Cutscene C for Act 1
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "_inc_generic"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    object oArea = GetObjectByTag("a1_escapepoint");
    object oWay = GetWaypointByTag("cuta1_escape");

    SetLocalString(oArea, "ESCAPE", "cut_a1_escapec");
    SetLocalObject(oArea, "A1_ECSPC", oPC);

    SetLocalInt(oModule, "A1_NATIVES", 120);
    AddJournalQuestEntry("a1_natives", 120, oPC);

    SetLocalInt(oModule, "A1_DWARF", 80);
    AddJournalQuestEntry("a1_dwarf", 80, oPC);

    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
        RemovePolymorph(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        //JE: JumpToObject is not reliable
        //AssignCommand(oPC, JumpToObject(oWay));
        JumpPCsToLocation(GetLocation(oWay), 0, oPC);
        //AssignCommand(oPC, SpeakString("Escape C"));

        oPC = GetNextPC();
    }
}
