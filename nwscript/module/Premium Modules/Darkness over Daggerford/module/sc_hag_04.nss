// is the shaman dead?
// .. he should be spawned by this time (the floor trigger will do it)

int StartingConditional()
{
    object oShaman = GetObjectByTag("ks_lizshaman");
    if (!GetIsObjectValid(oShaman))
    {
        return(TRUE);
    }
    return(GetIsDead(oShaman));
}
