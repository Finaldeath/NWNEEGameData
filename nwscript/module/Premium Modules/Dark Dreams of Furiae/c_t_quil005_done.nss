// Returns true if you HAVE spoken to quill in jail

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_quill_005_done"))
        return TRUE;

    return FALSE;
}
