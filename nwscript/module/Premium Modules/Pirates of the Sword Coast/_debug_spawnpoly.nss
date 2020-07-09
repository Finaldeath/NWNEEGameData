void main()
{
    object oPC = GetFirstPC();
    object oModule = GetModule();
    object oPoly = CreateObject(OBJECT_TYPE_CREATURE, "a1_poly", GetLocation(oPC), TRUE);

    AssignCommand(oPoly, ClearAllActions(TRUE));
    AssignCommand(oPoly, JumpToObject(oPC));
    //DelayCommand(0.5f, AssignCommand(oPoly, ActionStartConversation(oPC)));
    SetLocalInt(oModule, "POLY_FOLLOW_ON", TRUE);
    SetLocalObject(oModule, "POLY_FOLLOW", oPC);

}
