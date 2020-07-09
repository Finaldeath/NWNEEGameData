int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_tedd_met") == TRUE)
        return FALSE;

    return TRUE;
}
