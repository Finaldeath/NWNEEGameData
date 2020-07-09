void main()
{
    object oPC = GetEnteringObject();
    object oAstar = GetNearestObjectByTag("Astar", oPC);

    if (!GetIsPC(oPC))
        return;

    int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

    if (DoOnce==TRUE)
        return;

    SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

    AssignCommand(oPC, ClearAllActions(TRUE));

    SetLocalInt(oPC, "hench_interject", 1);

    AssignCommand(oAstar, ClearAllActions(TRUE));
    AssignCommand(oAstar, ActionStartConversation(oPC, "tm_hench_inter"));
}
