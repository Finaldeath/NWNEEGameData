// returns true if griswald is dead

int StartingConditional()
{
    object oGriswald = GetObjectByTag("ks_griswald");
    if (!GetIsObjectValid(oGriswald))
    {
        return(TRUE);
    }
    if (GetIsDead(oGriswald))
    {
        return(TRUE);
    }
    if (GetLocalInt(GetModule(), "nFandocGriswaldDead") != 0)
    {
        return(TRUE);
    }
    return(FALSE);
}
