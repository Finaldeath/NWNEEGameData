//sets that the PC has already been briefed by Hevesar
//creates Gaslo and his wife in the farmlands AR1200 area
//Author: Damian Brown (Luspr)
//Date: 28-07-2005
void main()
{
    //pc left daggerford without meeting hevesar
    if(GetLocalInt(GetModule(),"hevesar_quest")==3)
    {
        SetLocalInt(GetModule(), "hevesar_quest", 4);
        location lGaslo = GetLocation(GetWaypointByTag("wp_creategaslo"));
        location lWife = GetLocation(GetWaypointByTag("wp_creategaslowife"));
        CreateObject(OBJECT_TYPE_CREATURE,"db_gaslo2",lGaslo);
        CreateObject(OBJECT_TYPE_CREATURE,"db_gasloswife",lWife);
    }
    else
    //player meets hevesar in the happy cow
    {
        SetLocalInt(GetModule(), "hevesar_quest", 1);
        location lGaslo = GetLocation(GetWaypointByTag("wp_creategaslo"));
        location lWife = GetLocation(GetWaypointByTag("wp_creategaslowife"));
        CreateObject(OBJECT_TYPE_CREATURE,"db_gaslo2",lGaslo);
        CreateObject(OBJECT_TYPE_CREATURE,"db_gasloswife",lWife);
    }
}
