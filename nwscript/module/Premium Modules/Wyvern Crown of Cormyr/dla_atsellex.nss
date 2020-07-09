////////////////////////////////////////////////////////////////////////////////
// dla_atsellex - Make Wangle walk back to his standing position
// Scripted By: Deva B. Winblood  8/3/2006
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oWangle=OBJECT_SELF;
    object oGo=GetWaypointByTag("WP_WANGLE_POSITION");
    AssignCommand(oWangle,ActionMoveToObject(oGo,FALSE));
    AssignCommand(oWangle,ActionDoCommand(SetFacing(GetFacing(oGo))));
}
