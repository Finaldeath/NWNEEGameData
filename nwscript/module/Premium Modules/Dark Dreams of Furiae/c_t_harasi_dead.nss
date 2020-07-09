int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_harasi_dead") == TRUE) return TRUE;

    return FALSE;
}
