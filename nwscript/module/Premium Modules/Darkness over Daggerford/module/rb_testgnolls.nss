void main()
{
    //SetLocalInt(GetModule(), "nWH_OgresDispatched", 1);   // ogres no more"
    SetLocalInt(GetPCSpeaker(), "nWH_Been_C1AR0904", 1);
    //SetLocalInt(GetPCSpeaker(), "nWH_PaidToll", 100);

    DestroyObject(GetObjectByTag("bw_gnoll01"));
    DestroyObject(GetObjectByTag("bw_gnoll02"));
    DestroyObject(GetObjectByTag("bw_gnoll03"));
    DestroyObject(GetObjectByTag("bw_gnoll04"));
    DestroyObject(GetObjectByTag("bw_gnoll05"));

    DestroyObject(GetObjectByTag("bw_gnollking"));
    object oChief = CreateObject(OBJECT_TYPE_CREATURE, "bw_gnollking",GetLocation(GetWaypointByTag("WP_bw_ogre04_03")));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(),oChief));

}
