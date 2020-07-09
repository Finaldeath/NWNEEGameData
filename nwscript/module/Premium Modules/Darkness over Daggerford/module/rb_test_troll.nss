void main()
{
    CreateObject(OBJECT_TYPE_CREATURE, "ct_troll002", GetLocation(GetWaypointByTag("wp_brenda3")));
    object oPC = GetPCSpeaker();
    CreateItemOnObject("x1_wmgrenade001", oPC, 2);
    CreateItemOnObject("x1_wmgrenade002", oPC, 2);
    CreateItemOnObject("x2_it_sparscr205", oPC, 1);
    CreateItemOnObject("nw_wammar002", oPC, 1);
}
