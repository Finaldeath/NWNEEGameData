void main()
{
    object oPC = GetEnteringObject();
    object oEremuth = GetNearestObjectByTag("Eremuth", oPC);

    if (!GetIsPC(oPC))
        return;

    int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

    if (DoOnce==TRUE)
        return;

    SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

    AssignCommand(oPC, ClearAllActions(TRUE));

    SetLocalInt(oPC, "hench_interject", 2);

    AssignCommand(oEremuth, ClearAllActions(TRUE));
    AssignCommand(oEremuth, ActionStartConversation(oPC, "tm_hench_inter"));
}
