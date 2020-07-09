//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovate2
// DATE: February 21, 2006.
// AUTH: Luke Scull
// NOTE: Pause conversation and return golems to guarding
//       the main gate before resuming conversation.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    // Define objects used in script
    object oPC = GetFirstPC();

    object oLeft = GetNearestObjectByTag("Left", oPC);
    object oRight = GetNearestObjectByTag("Right", oPC);

    object oWaypoint1 = GetNearestObjectByTag("WP_Left_Move", oPC);
    object oWaypoint2 = GetNearestObjectByTag("WP_Right_Move", oPC);

    ActionPauseConversation();

    // Move golems back to waypoints
    AssignCommand(oLeft, ActionForceMoveToObject(oWaypoint1, FALSE, 0.0));
    AssignCommand(oRight, ActionForceMoveToObject(oWaypoint2, FALSE, 0.0));

    // Get them facing south again
    DelayCommand(10.0, AssignCommand(oLeft, SetFacing(270.0)));
    DelayCommand(12.5, AssignCommand(oRight, SetFacing (270.0)));

    DelayCommand(5.0, ActionResumeConversation());
}
