int StartingConditional()
{
    if((GetLocalInt(GetModule(), "iJonasDead") == 1) &&
       (GetLocalInt(GetModule(), "iJuniorDead") == 1) &&
       (GetLocalInt(GetModule(), "ac_werewolf") > 2))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
