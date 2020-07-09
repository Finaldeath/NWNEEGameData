// January 2006
// B W-Husey
// Player leaves the general melee area

void main()
{
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(GetWaypointByTag("JP_TTGEndMelee"));
    AssignCommand(oPC,JumpToLocation(lLoc));
}
