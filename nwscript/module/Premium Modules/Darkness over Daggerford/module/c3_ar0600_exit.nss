void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        AssignCommand(oPC, ActionStartConversation(oPC, "ks_ar0600_north", FALSE, FALSE));
    }
}
