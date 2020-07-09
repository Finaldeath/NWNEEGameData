// Returns true if you have NOT spoken to Teddy in the Sea Market on day 1

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_tedd_smar") == TRUE)
        return FALSE;

    return TRUE;
}
