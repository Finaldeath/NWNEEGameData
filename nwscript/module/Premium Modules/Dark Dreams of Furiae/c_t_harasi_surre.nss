int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_harasi_surrendered") == TRUE) return TRUE;
    return FALSE;
}
