void main()
{
    location lJemmy = GetLocation(GetWaypointByTag("wp_create_jemmy"));
    location lBarnabus = GetLocation(GetWaypointByTag("wp_create_barnabus"));
    SetLocalInt(GetModule(),"rab_plot",15);
    CreateObject(OBJECT_TYPE_CREATURE,"db_jemmy",lJemmy);
    CreateObject(OBJECT_TYPE_CREATURE,"db_mrbarnabus",lBarnabus);
}
