//create the harpers in their room
void main()
{
    object oDoor = GetObjectByTag("harper_door");
    location lDrelia = GetLocation(GetWaypointByTag("wp_drelia"));
    location lBrenda = GetLocation(GetWaypointByTag("wp_brenda"));
    location lMeyhew = GetLocation(GetWaypointByTag("wp_meyhew"));
    //create the harpers
    CreateObject(OBJECT_TYPE_CREATURE,"db_drelia",lDrelia);
    CreateObject(OBJECT_TYPE_CREATURE,"db_brenda",lBrenda);
    CreateObject(OBJECT_TYPE_CREATURE,"db_meyhew",lMeyhew);
    //prepare the door
    SetPlotFlag(oDoor,FALSE);
    SetLocked(oDoor,FALSE);
    //play Drelia's greeting
    PlaySound("vs_nx2avarf_hi");
}
