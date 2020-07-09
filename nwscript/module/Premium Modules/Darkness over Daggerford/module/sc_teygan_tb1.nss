//true if player is working on the teygan bandit quest
int StartingConditional()
{
    // the bandits are all dead
    if(GetLocalInt(GetModule(), "teygan_bandits") == 1)
    {
        return TRUE;
    }

    // this check added for robustness
    if (GetLocalInt(GetModule(), "nSpawnedTeyganBandits") == 1)
    {
        int i = 0;
        object oBandit = GetObjectByTag("_ar1100_bandit", i);
        while (GetIsObjectValid(oBandit))
        {
            if (!GetIsDead(oBandit))
            {
                // at least one bandit is still alive
                return(FALSE);
            }
            oBandit = GetObjectByTag("_ar1100_bandit", ++i);
        }
        return(TRUE);
    }

    // the player is still working
    return FALSE;
}
