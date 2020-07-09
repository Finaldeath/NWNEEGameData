void main()
{
    ActionPauseConversation();

    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");

    // sub process for large numbers
    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU7");
    SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
    SetLocalObject(oMicroCPU, "oImport", oImport);
    SetLocalInt(oMicroCPU, "nImport", 1);
    DelayCommand(0.01, ExecuteScript("exe_id1_micimp01", oMicroCPU));
}
