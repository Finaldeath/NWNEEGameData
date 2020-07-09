// the slaves won't talk to the player when their master is around

int StartingConditional()
{
    object oMaster = GetNearestObjectByTag("ks_zhentslaver");
    if (GetIsObjectValid(oMaster) && !GetIsDead(oMaster))
    {
        return(TRUE);
    }
    return(FALSE);
}
