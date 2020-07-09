void main()
{
    object oPC=GetPCSpeaker();
    location lTarget = GetLocation(GetWaypointByTag("wp_db_caravan2"));
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lTarget));
}
