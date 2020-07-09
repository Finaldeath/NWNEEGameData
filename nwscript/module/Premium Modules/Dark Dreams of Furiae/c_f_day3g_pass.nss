int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_day3g_pass"))
        return FALSE;

    return TRUE;
}
