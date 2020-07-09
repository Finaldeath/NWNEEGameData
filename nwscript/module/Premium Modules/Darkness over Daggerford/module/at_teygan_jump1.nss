void main()
{
    //PC travels to the stronghold with Sememmon
    object oPC = GetPCSpeaker();
    location lPC = GetLocation(GetWaypointByTag("wp_pc_stronghold1"));
    location lSememmon = GetLocation(GetWaypointByTag("wp_drelia4"));
    location lGuard1 = GetLocation(GetWaypointByTag("wp_brenda4"));
    location lGuard2 = GetLocation(GetWaypointByTag("wp_meyhew4"));
    //create Sememmon and Shield Guardians in Stronghold - Bhaal Temple
    CreateObject(OBJECT_TYPE_CREATURE,"sememmon",lSememmon);
    CreateObject(OBJECT_TYPE_CREATURE,"db_robot",lGuard1);
    CreateObject(OBJECT_TYPE_CREATURE,"db_robot",lGuard2);
    //set an int so that Drelia's conv fires correctly
    //the harpers are alive and know the identity of teygan
    //SetLocalInt(GetModule(),"harpers_teygan",3);
    //transport the pc
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lPC));
    //despawn the fake harpers and teygan
    object oTeygan = GetNearestObjectByTag("Teygan",oPC,1);
    object oFakeH1 = GetNearestObjectByTag("db_fakeharp1",oPC,1);
    object oFakeH2 = GetNearestObjectByTag("db_fakeharp2",oPC,1);
    DelayCommand(0.5,DestroyObject(oTeygan));
    DelayCommand(0.5,DestroyObject(oFakeH1));
    DelayCommand(0.5,DestroyObject(oFakeH2));
    //set an int to say that PC has chosen Teygan route
    SetLocalInt(GetModule(),"good_evil",2);
    //despawn any real harpers at the stronghold
    object oDrelia = GetNearestObjectByTag("db_drelia",oPC,1);
    object oBrenda = GetNearestObjectByTag("db_brenda",oPC,1);
    object oMeyhew = GetNearestObjectByTag("db_meyhew",oPC,1);
    DelayCommand(0.5,DestroyObject(oDrelia));
    DelayCommand(0.5,DestroyObject(oBrenda));
    DelayCommand(0.5,DestroyObject(oMeyhew));
    //unlock the temple doors
    object oDoor1 = GetObjectByTag("AR1300_AR1301_EXIT1");
    object oDoor2 = GetObjectByTag("AR1300_AR1301_EXIT2");
    SetLocked(oDoor1,FALSE);
    SetLocked(oDoor2,FALSE);
}
