// display a placeable's description (onClick event)

void main()
{
    object oPC = GetPlaceableLastClickedBy();
    if (GetIsPC(oPC))
    {
        object oSelf = OBJECT_SELF;
        AssignCommand(oPC, ActionExamine(oSelf));
    }
}
