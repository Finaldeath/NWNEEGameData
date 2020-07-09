void main()
{
    //spawn and despawn routine for gaslo in the wild pastures
    location lSpwn = GetLocation(GetWaypointByTag("wp_creategaslo"));
    //do it once -- theoretically possible to loop convo here
    if(!GetLocalInt(GetModule(), "gaslo_spwn") ==1)
    {
        CreateObject(OBJECT_TYPE_CREATURE, "db_gaslo2", lSpwn);
        SetLocalInt(GetModule(), "gaslo_spwn", 1);
    }
}
