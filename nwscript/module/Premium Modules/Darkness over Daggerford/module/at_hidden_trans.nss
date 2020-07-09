void main()
{
    object oPC=GetPCSpeaker();
    object oWaypoint = GetWaypointByTag("wp_hidden_2101");
    AssignCommand(oPC, ClearAllActions());
    DelayCommand(0.1,AssignCommand(oPC,JumpToObject(oWaypoint)));
}
