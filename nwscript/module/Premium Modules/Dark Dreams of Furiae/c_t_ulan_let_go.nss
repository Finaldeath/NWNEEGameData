int StartingConditional()
{
    // Make sure we dealth with Ulan
    int iDealt = GetLocalInt(GetModule(), "ddf_deal_with_ulan");
    if (!iDealt)
    {
        return FALSE;
    }

    int iDead = GetLocalInt(GetModule(), "ddf_ulan_dead");
    int iKO = GetLocalInt(GetModule(), "ddf_ulan_knocked_out");

    if (!iDead && !iKO)
    {
        return TRUE;
    }

    return FALSE;
}
