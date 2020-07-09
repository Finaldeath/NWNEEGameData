// Returns true if you HAVE asked Forvor to examine your Ring of Sending

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_ring"))
        return TRUE;

    return FALSE;
}
