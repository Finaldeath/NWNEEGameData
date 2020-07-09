void main()
{
    object oPC=GetPCSpeaker();
    location lTarget = GetLocation(GetWaypointByTag("wp_db_caravan1"));
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lTarget));
}
