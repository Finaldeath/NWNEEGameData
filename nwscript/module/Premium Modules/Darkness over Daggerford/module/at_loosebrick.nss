void main()
{
    object oPC=GetPCSpeaker();
    object oStatue=GetObjectByTag("statue_door");
    location lPass=GetLocation(GetWaypointByTag("create_pass1308"));
    location lBroken=GetLocation(GetWaypointByTag("create_broken1308"));
    location lRubble=GetLocation(GetWaypointByTag("rubble_1308"));
    SetLocalInt(GetModule(),"1308secret",1);
    CreateObject(OBJECT_TYPE_PLACEABLE,"secret_pass13081",lPass);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_statue2",lBroken);
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_rubble",lRubble);
    PlaySound("as_cv_brickscrp2");
    DestroyObject(oStatue,0.1);
}
