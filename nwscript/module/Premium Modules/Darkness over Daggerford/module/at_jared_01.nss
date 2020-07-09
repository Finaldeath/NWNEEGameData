void main()
{
    object oCleric = OBJECT_SELF;
    object oDst = GetWaypointByTag("WP_AR2104_BRIDGE");
    AssignCommand(oCleric, ActionMoveToObject(oDst, TRUE, 0.5));
}
