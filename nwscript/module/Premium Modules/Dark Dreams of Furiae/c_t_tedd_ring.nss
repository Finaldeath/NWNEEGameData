int StartingConditional()
{
    int iHasRing = GetLocalInt(GetModule(), "ddf_tedd_has_ring");

    if (iHasRing == TRUE)
    {
        return TRUE;
    }

    return FALSE;
}
