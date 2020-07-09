int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_met"))
        return FALSE;

    return TRUE;
}
