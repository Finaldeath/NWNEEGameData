// returns true if griswald is dead

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "nFandocGriswaldDead") != 0)
    {
        return(TRUE);
    }
    return(FALSE);
}
