// use this script on a door or area transition to only allow players
// .. this prevents monsters from following players through doors
// .. use this script on the "OnAreaTransitionClick" event of the door

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetIsPC(oClicker))
    {
        AssignCommand(oClicker, JumpToObject(oTarget));
    }
    else
    {
        AssignCommand(oClicker, ClearAllActions());
        AssignCommand(oClicker, ActionMoveAwayFromObject(OBJECT_SELF, FALSE, 10.0));
    }
}
