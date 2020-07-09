// January 2006
// B W-Husey
// Player enters the general melee area

void main()
{
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(GetWaypointByTag("WP_dla_me_end"));
    AssignCommand(oPC,JumpToLocation(lLoc));
}
