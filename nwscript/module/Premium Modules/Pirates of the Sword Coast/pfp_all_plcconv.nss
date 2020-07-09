void main()
{
    object oNearest = GetNearestObject(OBJECT_TYPE_CREATURE);
    object oSelf = OBJECT_SELF;

    if (GetIsPossessedFamiliar(oNearest) == TRUE)
    {
        string sMessage = "You'd best not touch anything until your master arrives.";
        FloatingTextStringOnCreature(sMessage, oNearest);
    }
    else if ((GetIsPC(oNearest) == TRUE) && (GetDistanceBetween(oNearest, oSelf) < 5.0f))
    {
        AssignCommand(oNearest, ClearAllActions(TRUE));
        DelayCommand(0.2, ActionStartConversation(oNearest));
    }
}
