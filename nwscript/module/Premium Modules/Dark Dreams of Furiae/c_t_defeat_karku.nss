int StartingConditional()
{
    int iResult = GetLocalInt(GetModule(), "ddf_karkualii_defeated");
    if(iResult > 0) return TRUE;
    return FALSE;
}
