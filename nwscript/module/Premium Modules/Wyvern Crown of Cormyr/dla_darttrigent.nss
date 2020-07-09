// dla_darttrigent.nss
// May 14 2006
// Robert Faber
// Sets local on commoners walking around to move out of the way
void main()
{
    object oEnter = GetEnteringObject();
    object oPC = GetFirstPC();
    object oOpponent = GetLocalObject(oPC,"oMyDartOpponent");
    location lMove = GetLocation(GetWaypointByTag("WP_dartmove"));

    //June 5, 2006:  Don't do this with henchmen or companions.
    if(GetIsPC(oEnter) || GetIsObjectValid(GetMaster(oEnter)))
    {
        return;
    }
    SetLocalInt(oEnter,"bDartsInTheWay",TRUE);
    if(GetLocalInt(oPC,"nPlayingDarts") && oEnter!=oOpponent)
    {
        AssignCommand(oEnter,ActionMoveToLocation(lMove));
    }
}
