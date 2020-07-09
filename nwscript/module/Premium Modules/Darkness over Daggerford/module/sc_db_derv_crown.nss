int StartingConditional()
{
    if(GetLocalInt(GetModule(), "nIH_HelmRestored") == 1&&
    !GetLocalInt(GetModule(), "derval_crown")==1)
    return TRUE;
    return FALSE;
}
