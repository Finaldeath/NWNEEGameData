int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_debug_mode") == 1) return TRUE;
    return FALSE;
}
