// Returns true if the player is NOT a cop

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_background_flag") == 1)
        return FALSE;

    return TRUE;
}
