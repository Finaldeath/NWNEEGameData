// Returns true if you have NOT spoken to quill in jail

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_quill_005_done"))
        return FALSE;

    return TRUE;
}
