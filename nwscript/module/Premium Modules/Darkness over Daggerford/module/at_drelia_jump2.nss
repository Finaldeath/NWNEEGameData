//Harpers wait, send PC to Teygan
void main()
{
    object oPC = GetPCSpeaker();
    location lPC = GetLocation(GetWaypointByTag("wp_pc_teygan"));
    //set an int so that Drelia's conv fires correctly
    //the harpers are alive but teygan's id is unknown
    SetLocalInt(GetModule(),"harpers_teygan",2);
    //transport the pc
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lPC));
}
