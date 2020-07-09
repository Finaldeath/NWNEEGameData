// Returns true if the player is NOT a revolutionary

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_background_flag") == 2)
        return FALSE;

    return TRUE;
}
