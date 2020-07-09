void main()
{
    //
    if(!GetLocalInt(GetModule(), "create_tala_lhs") ==1)
    {
        //create the talerenne placeable
        location lTala = GetLocation(GetWaypointByTag("wp_create_tala_lhs"));
        CreateObject(OBJECT_TYPE_PLACEABLE, "db_talerenne_lhs", lTala);
        //set an int so that we only create one invisble Tala
        SetLocalInt(GetModule(), "create_tala_lhs", 1);
    }
}
