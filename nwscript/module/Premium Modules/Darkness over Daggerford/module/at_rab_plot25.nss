void main()
{
    SetLocalInt(GetModule(),"rab_plot",25);
    //create the guard in Mayor Wilsey's House
    location lGuard = GetLocation(GetWaypointByTag("db_lh_guard"));
    CreateObject(OBJECT_TYPE_CREATURE,"db_lh_militia",lGuard);
}
