int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_met"))
        return TRUE;

    return FALSE;
}
