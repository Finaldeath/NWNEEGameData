void main()
{
    CreateItemOnObject("a2_chicken", GetPCSpeaker());
    CreateItemOnObject("a2_penguin", GetPCSpeaker());
    CreateItemOnObject("a2_parrot", GetPCSpeaker());
    DestroyObject(GetNearestObjectByTag("psc_PLC_Net", GetPCSpeaker()), 2.0);
    // spawn tatham
   /* if (GetLocalInt(GetFirstPC(), "nTathamSpawned") == 0)
    {
        SetLocalInt(GetFirstPC(), "nTathamSpawned", 1);
        object oWP = GetWaypointByTag("WP_AR1400_TATHAM");
        object oTatham = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_gull", GetLocation(oWP));
        SetLocalInt(oTatham, "HF_DISABLE_AM", 1);
        AssignCommand(oTatham, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oTatham)-1), oTatham));
    }*/
}
