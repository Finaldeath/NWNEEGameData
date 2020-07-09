int StartingConditional()
{
    if(GetLocalInt(GetModule(), "gaslo_met") ==1)
    return TRUE;
    return FALSE;
}
