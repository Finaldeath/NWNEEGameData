void main()
{
    object oDoor = GetBlockingDoor();
    int nInt = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE);
    int nStr = GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH);

    if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN) &&  nInt >= 3)
    {
        DoDoorAction(oDoor, DOOR_ACTION_OPEN);
    }

    else if(GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH) && nStr >= 16)
    {
        DoDoorAction(oDoor, DOOR_ACTION_BASH);
    }
}
