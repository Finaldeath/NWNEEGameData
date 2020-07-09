void main()
{
    object oMe = OBJECT_SELF;
    object oPC = GetLocalObject(oMe,"oForceTalk1");
    object oDrag = GetLocalObject(oMe,"oForceTalk2");
    AssignCommand(oPC,ClearAllActions(TRUE));
    AssignCommand(oPC,ActionStartConversation(oDrag,"wyvernvapor",FALSE,FALSE));
    if(IsInConversation(oPC))
    {
        DestroyObject(oMe, 0.5);
    }
    else
    {
        AssignCommand(oPC,ClearAllActions(TRUE));
        AssignCommand(oPC,ActionStartConversation(oDrag,"wyvernvapor",FALSE,FALSE));
    }
}
