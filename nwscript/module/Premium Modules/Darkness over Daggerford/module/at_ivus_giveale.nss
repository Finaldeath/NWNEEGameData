void main()
{
    object oSelf = GetObjectByTag("ivus_ale_barrels");
    object oPC = GetPCSpeaker();
    object oRabsDoor = GetObjectByTag("rabs_door");
    object oMap = GetWaypointByTag("wp_map_rab");
    CreateItemOnObject("db_ivusale",oPC,1);
    SetMapPinEnabled(oMap,TRUE);
    SetLocked(oRabsDoor,FALSE);
    DestroyObject(oSelf,5.0);
}
