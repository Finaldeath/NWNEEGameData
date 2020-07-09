// the golem in "the purple portals" area is broken so it should not turn to face the player
// when clicked on

void main()
{
    object oPC = GetFirstPC();
    object oSelf = OBJECT_SELF;
    if (GetCommandable(oSelf))
    {
        BeginConversation();
        ClearAllActions();
        SetFacing(DIRECTION_NORTH);
        AssignCommand(oPC, ActionExamine(oSelf));
    }
}
