void main()
{
    SetLocalInt(GetPCSpeaker(), "CS_MARINER", 1);
    AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetWaypointByTag("WP_CS_MARINER2")));
}
