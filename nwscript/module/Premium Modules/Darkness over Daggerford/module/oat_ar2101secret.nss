
void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    location lLoc = GetLocation(GetWaypointByTag("wp_create_hidden"));
    if(GetLocalInt(GetModule(),"drop_off_exit")<1)
    {
        SetLocalInt(GetModule(),"drop_off_exit",1);
        CreateObject(OBJECT_TYPE_PLACEABLE,"db_secretexit01",lLoc);
        AssignCommand(oClicker,JumpToObject(oTarget));
    }
    else
    {
        AssignCommand(oClicker,JumpToObject(oTarget));
    }
}
