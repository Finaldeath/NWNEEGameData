//::///////////////////////////////////////////////
//:: cac_a1_cutesc_b
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start End Cutscene B for Act 1
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "_inc_generic"

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oArea = GetObjectByTag("a1_escapepoint");
    object oWay = GetWaypointByTag("cuta1_escape");

    SetLocalInt(oModule, "A1_DWARF", 90);
    AddJournalQuestEntry("a1_dwarf", 90, oPC);

    SetLocalString(oArea, "ESCAPE", "cut_a1_escapeb");
    SetLocalObject(oArea, "A1_ECSPC", oPC);

    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
        RemovePolymorph(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        //JE: JumpToObject is not reliable
        //AssignCommand(oPC, JumpToObject(oWay));
        JumpPCsToLocation(GetLocation(oWay), 0, oPC);

        oPC = GetNextPC();
    }
}
