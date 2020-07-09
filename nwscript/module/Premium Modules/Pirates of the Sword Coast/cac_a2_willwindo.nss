//::///////////////////////////////////////////////
//:: cac_a2_willwindo
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Climbing through the window in Willigan's
    study, back down the ladder.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 22, 2005
//:://////////////////////////////////////////////

void main()
{
    object oWP = GetWaypointByTag("a2_willladder");
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionJumpToObject(oWP));
}
