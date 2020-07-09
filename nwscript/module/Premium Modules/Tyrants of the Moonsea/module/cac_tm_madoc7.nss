//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_madoc7
// DATE: August 29, 2005
// AUTH: Luke Scull
// NOTE: Pauses conversation to allow Bron to join.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    // Defines Bron and waypoint destination
    object oBron = GetObjectByTag("TheBron");
    object oTarget = GetWaypointByTag("WP_Bron_Inn");

    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oBron);
    // Pause conversation
    ActionPauseConversation();

    // Tell guard to walk to waypoint
    AssignCommand(oBron, ActionMoveToObject(oTarget));
    AssignCommand(oBron, ActionMoveToObject(oTarget));

    // Resumes the conversation once guard reaches waypoint
    DelayCommand(5.0, ActionResumeConversation());
}
