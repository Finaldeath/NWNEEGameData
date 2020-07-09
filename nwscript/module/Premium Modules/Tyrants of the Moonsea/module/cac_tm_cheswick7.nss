//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_cheswick7
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Move Cheswick back to campfire.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////


void main()
{
    object oCheswick = OBJECT_SELF;
    object oCampfireWP = GetWaypointByTag("WP_Cheswick_Move");

    AssignCommand(oCheswick, ClearAllActions(TRUE));
    AssignCommand(oCheswick, ActionMoveToObject(oCampfireWP, FALSE, 0.1));
}
