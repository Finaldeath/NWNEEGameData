//create the Harpers in the Bhaal temple.
void main()
{
    object oPC = GetPCSpeaker();
    location lPC = GetLocation(GetWaypointByTag("wp_pc_stronghold1"));
    location lDrelia = GetLocation(GetWaypointByTag("wp_drelia4"));
    location lBrenda = GetLocation(GetWaypointByTag("wp_brenda4"));
    location lMeyhew = GetLocation(GetWaypointByTag("wp_meyhew4"));
    //create the harpers in Bhaal Temple - Stronghold
    CreateObject(OBJECT_TYPE_CREATURE,"db_drelia",lDrelia);
    CreateObject(OBJECT_TYPE_CREATURE,"db_brenda",lBrenda);
    CreateObject(OBJECT_TYPE_CREATURE,"db_meyhew",lMeyhew);
    ActionPauseConversation();
    //transport the pc
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lPC));
    //the player has chosen the harper 'good' path
    SetLocalInt(GetModule(),"good_evil",1);
    SetLocalInt(GetModule(),"harpers_teygan",4);//for drelias conv tree
    //despawn the harpers from the inn
    object oDrelia = GetNearestObjectByTag("db_drelia");
    object oBrenda = GetNearestObjectByTag("db_brenda");
    object oMeyhew = GetNearestObjectByTag("db_meyhew");
    DelayCommand(1.5,DestroyObject(oDrelia));
    DelayCommand(0.5,DestroyObject(oBrenda));
    DelayCommand(0.5,DestroyObject(oMeyhew));
    DelayCommand(1.0,ActionResumeConversation());
    //unlock the temple doors
    object oDoor1 = GetObjectByTag("AR1300_AR1301_EXIT1");
    object oDoor2 = GetObjectByTag("AR1300_AR1301_EXIT2");
    SetLocked(oDoor1,FALSE);
    SetLocked(oDoor2,FALSE);
}
