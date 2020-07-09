int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_luicil_died") == TRUE) return TRUE;
    return FALSE;
}
