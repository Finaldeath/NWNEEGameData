int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_spoke"))
        return TRUE;

    return FALSE;
}
