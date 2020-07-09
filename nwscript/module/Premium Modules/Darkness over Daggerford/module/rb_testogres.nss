void main()
{
    //SetLocalInt(GetModule(), "nWH_OgresDispatched", 1);   // ogres no more"
    SetLocalInt(GetPCSpeaker(), "nWH_Been_C1AR0902", 1);
    SetLocalInt(GetPCSpeaker(), "nWH_Been_C1AR0903", 1);

    DestroyObject(GetObjectByTag("bw_ogre01"));
    DestroyObject(GetObjectByTag("bw_ogre02"));
    DestroyObject(GetObjectByTag("bw_ogre03"));
    DestroyObject(GetObjectByTag("bw_ogre04"));
    DestroyObject(GetObjectByTag("bw_ogre05"));
    DestroyObject(GetObjectByTag("bw_ogre06"));
    DestroyObject(GetObjectByTag("bw_ogremage"));
    //DestroyObject(GetObjectByTag("bw_ogreking"));
    object oKing = CreateObject(OBJECT_TYPE_CREATURE, "bw_ogreking",GetLocation(GetWaypointByTag("WP_bw_ogre04_03")));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(),oKing));
}
