void main()
{
    location lLucas=GetLocation(GetWaypointByTag("wp_lucas_spawn"));
    location lTent=GetLocation(GetWaypointByTag("wp_evani_tent"));
    location lFire=GetLocation(GetWaypointByTag("wp_evani_campfire"));
    SetLocalInt(GetModule(),"evani_hasmet",1);
    CreateObject(OBJECT_TYPE_CREATURE,"db_lucas",lLucas);
    CreateObject(OBJECT_TYPE_PLACEABLE,"X2_PLC_TENT_B",lTent);
    CreateObject(OBJECT_TYPE_PLACEABLE,"campfr001",lFire);
}
