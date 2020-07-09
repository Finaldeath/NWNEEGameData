void main()
{
    //the destination area of the holdfast inn door to upstairs
    //varies depending on the state of the "teygan_quests" integer

    object oPC = GetClickingObject();
    location lMerchant = GetLocation(GetWaypointByTag("wp_hfi_merch"));
    location lHarpers = GetLocation(GetWaypointByTag("wp_hfi_harpers"));
    if (GetLocalInt(GetModule(), "teygan_quests") >2)
    //teygan has told the player to attack the agents (or later)
    {
        AssignCommand(oPC, ActionJumpToLocation(lHarpers));
    }
    else
    {
        AssignCommand(oPC,ActionJumpToLocation(lMerchant));
    }
}
