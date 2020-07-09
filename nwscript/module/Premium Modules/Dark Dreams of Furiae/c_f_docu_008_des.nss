int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_docu_008_destroyed") == TRUE) return FALSE;

    return TRUE;
}
