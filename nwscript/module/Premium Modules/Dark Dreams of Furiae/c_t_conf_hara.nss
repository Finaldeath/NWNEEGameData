int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_harasi_surrendered") == TRUE) return FALSE;
    if(GetLocalInt(GetModule(), "ddf_confront_harasi") == TRUE) return TRUE;
    return FALSE;
}
