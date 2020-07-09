// onExit event for AR0101 (Chateau Elite)
// .. turns amara into astriel once the player learns her real name

void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        object oMod = GetModule();
        if (GetLocalInt(oMod, "amara_is_astriel") == 1)
        {
            SetLocalInt(oMod, "amara_is_astriel", 2);
            object oAmara = GetObjectByTag("db_amara2");
            object oWP = GetWaypointByTag("db_spawn_astriel");
            DestroyObject(oAmara);
            CreateObject(OBJECT_TYPE_CREATURE, "pm_astriel2", GetLocation(oWP));
        }
    }
}
