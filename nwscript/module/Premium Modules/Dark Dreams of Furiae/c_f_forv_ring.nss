// Returns true if you have NOT asked Forvor to examine your Ring of Sending

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_ring"))
        return FALSE;

    return TRUE;
}
