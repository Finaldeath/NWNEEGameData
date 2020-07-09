void main()
{
    //handle the set up for the orcs in the fields mission

    //remember we've been briefed by Gaslo
    SetLocalInt(GetModule(), "gaslo_met", 1);
    //bring in the interactive placeable
    if (GetLocalInt(OBJECT_SELF, "nSpawnedShadows") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nSpawnedShadows", 1);
        object oWP = GetWaypointByTag("WP_AR1500_DRAGON_SKULL");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_orcsatnight", GetLocation(oWP));
    }
}
