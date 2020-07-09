int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_quill_in_jail") || GetLocalInt(GetModule(), "ddf_luce_truth"))
        return FALSE;

    return TRUE;
}
