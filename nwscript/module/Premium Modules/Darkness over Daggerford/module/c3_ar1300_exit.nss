// can't go south from liam's hold

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        AssignCommand(oPC, ActionStartConversation(oPC, "ks_ar1300_south", FALSE, FALSE));
    }
}
