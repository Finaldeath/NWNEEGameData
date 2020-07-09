// returns true if griswald is alive

int StartingConditional()
{
    object oGriswald = GetObjectByTag("ks_griswald");

    if (GetLocalInt(GetModule(), "nFandocGriswaldDead") == 0)
    {
        return(TRUE);
    }
    if (!GetIsDead(oGriswald))
    {
        return(TRUE);
    }
    return(FALSE);
}
