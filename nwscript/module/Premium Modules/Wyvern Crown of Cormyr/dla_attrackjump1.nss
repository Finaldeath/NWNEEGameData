// Jumps PC to Thieves Den
void main()
{
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(GetWaypointByTag("WP_PFTDEntry"));
    AddJournalQuestEntry("Careless",20,oPC);
    AssignCommand(oPC,JumpToLocation(lLoc));
}
