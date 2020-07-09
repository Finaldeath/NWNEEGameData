//::///////////////////////////////////////////////
//:: cac_a2_willladdr
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Climbing the ladder into Willigan's study.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 22, 2005
//:://////////////////////////////////////////////

void main()
{
    object oWP = GetWaypointByTag("a2_willwindow");
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionJumpToObject(oWP));
}
