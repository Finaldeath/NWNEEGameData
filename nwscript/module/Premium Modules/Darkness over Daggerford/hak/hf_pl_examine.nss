// display a placeable's description

void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        object oSelf = OBJECT_SELF;
        AssignCommand(oPC, ActionExamine(oSelf));
    }
}
