// B W-Husey
// Sned PC and horses back to Tournament ground

void main()
{
    object oPC = GetPCSpeaker();
    SetCutsceneMode(oPC,FALSE);
    ExecuteScript("dla_attrangetho2",oPC); //Get the horses
    AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("WP_TTGWest1"))));
}
