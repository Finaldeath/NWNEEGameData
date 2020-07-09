// display a placeable's description (onConvo event)

void main()
{
    object oPC = GetFirstPC();
    object oSelf = OBJECT_SELF;
    AssignCommand(oPC, ActionExamine(oSelf));
}
