void main()
{
    //set up vejoni's discount store
    object oStore1=GetNearestObjectByTag("store_db_vejoni");
    location lStore=GetLocation(GetWaypointByTag("store_db_vejoni"));
    DestroyObject(oStore1);
    CreateObject(OBJECT_TYPE_STORE,"db_vejoni2",lStore,
    FALSE,"store_db_vejoni");
}
