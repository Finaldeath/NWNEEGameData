//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_madoc1
// DATE: August 25, 2005
// AUTH: Luke Scull
// NOTE: Pauses conversation to allow Guard to join.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

// Pause conversation

ActionPauseConversation();

// Defines guard and waypoint destination

object oGuard;
oGuard = GetObjectByTag("VoonlarGuardMadoc");

object oTarget;
oTarget = GetWaypointByTag("WP_Guard_Madoc");

// Tell guard to walk to waypoint

AssignCommand(oGuard, ActionMoveToObject(oTarget));

// Resumes the conversation once guard reaches waypoint

DelayCommand(6.0, ActionResumeConversation());
}

