// Returns true if the player is NOT independent

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_background_flag") == 3)
        return FALSE;

    return TRUE;
}
