void main()
{
    object oUser = GetLastUsedBy();
    if(!GetLocalInt(oUser,"nDummyContestActive"))
    {
        return;
    }
    object oTarget = OBJECT_SELF;
    AssignCommand(oUser, DoPlaceableObjectAction(oTarget, PLACEABLE_ACTION_BASH));
}
