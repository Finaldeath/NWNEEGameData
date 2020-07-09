int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_spoke"))
        return FALSE;

    return TRUE;
}
