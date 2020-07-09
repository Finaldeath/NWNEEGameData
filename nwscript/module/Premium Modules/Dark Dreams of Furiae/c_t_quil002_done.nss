int StartingConditional()
{
    if (GetLocalInt(GetModule(), "dlg_quill_002_done"))
        return TRUE;

    return FALSE;
}
