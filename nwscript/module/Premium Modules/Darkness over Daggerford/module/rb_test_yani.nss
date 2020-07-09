void main()
{
    object oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT");
    object oYani = CreateObject(OBJECT_TYPE_CREATURE, "ks_yani", GetLocation(oWP));

    // spawn Yani's ox
    oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT_OX");
    object oOx = CreateObject(OBJECT_TYPE_CREATURE, "nw_ox", GetLocation(oWP));
    ChangeFaction(oOx, oYani);

    // spawn Yani's wagon
    oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT_WAGON");
    CreateObject(OBJECT_TYPE_PLACEABLE, "am_wagon1", GetLocation(oWP));

    // spawn Yani's fire
    oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT_FIRE");
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_campfrwpot", GetLocation(oWP));
}
