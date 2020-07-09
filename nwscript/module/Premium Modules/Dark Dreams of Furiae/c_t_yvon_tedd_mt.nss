int StartingConditional()
{
    int iMet = GetLocalInt(GetModule(), "ddf_yvon_tedd_met");

    if (iMet == TRUE)
    {
        return TRUE;
    }

    return FALSE;
}
