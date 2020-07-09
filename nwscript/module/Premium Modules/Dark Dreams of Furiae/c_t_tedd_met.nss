int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_tedd_met") == TRUE || GetLocalInt(GetModule(), "ddf_tedd_smar") == TRUE)
        return TRUE;

    return FALSE;
}
