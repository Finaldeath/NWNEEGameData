void main()
{
    object oPC = GetEnteringObject();

// added by gaoneng erick
    if (!GetIsPC(oPC)) return;
    if (GetLocalInt(OBJECT_SELF, "doonce")) return;
    SetLocalInt(OBJECT_SELF, "doonce", TRUE);
// end add

    location lSpawn = GetLocation(GetWaypointByTag("WP_SpawnWV"));
    object oDrag = CreateObject(OBJECT_TYPE_CREATURE,"wyvernvapor",lSpawn,TRUE);
    SetLocalObject(oPC,"oKludgeFactor10",oDrag);

    DestroyObject(OBJECT_SELF,0.5);
}
