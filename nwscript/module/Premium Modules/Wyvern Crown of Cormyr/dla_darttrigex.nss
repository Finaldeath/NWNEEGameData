// dla_darttrigex.nss
// May 14 2006
// Robert Faber
// removes local on commoners walking around to move out of the way
void main()
{
    object oExit = GetExitingObject();
    if(GetIsPC(oExit))
    {
        return;
    }
    DeleteLocalInt(oExit,"bDartsInTheWay");
}
