//the harpers accompany the player to Teygan's cave
void main()
{
    object oPC = GetPCSpeaker();
    location lPC = GetLocation(GetWaypointByTag("wp_pc_teygangone"));
    location lDrelia = GetLocation(GetWaypointByTag("wp_drelia3"));
    location lBrenda = GetLocation(GetWaypointByTag("wp_brenda3"));
    location lMeyhew = GetLocation(GetWaypointByTag("wp_meyhew3"));
    //create the harpers in Teygan's cave
    CreateObject(OBJECT_TYPE_CREATURE,"db_drelia",lDrelia);
    CreateObject(OBJECT_TYPE_CREATURE,"db_brenda",lBrenda);
    CreateObject(OBJECT_TYPE_CREATURE,"db_meyhew",lMeyhew);
    //set an int so that Drelia's conv fires correctly
    //harpers alive, and going to teygan's cave with the player
    SetLocalInt(GetModule(),"harpers_teygan",1);
    SetLocalInt(GetModule(), "iDestroyHarpers", 1);
    //transport the pc
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lPC));
    //despawn the harpers from the inn
    /*object oDrelia = GetNearestObjectByTag("db_drelia");
    object oBrenda = GetNearestObjectByTag("db_brenda");
    object oMeyhew = GetNearestObjectByTag("db_meyhew");
    DelayCommand(0.5,DestroyObject(oDrelia));
    DelayCommand(0.5,DestroyObject(oBrenda));
    DelayCommand(0.5,DestroyObject(oMeyhew));  */
}
