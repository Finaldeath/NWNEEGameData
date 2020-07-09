// Returns true if the player IS a cop

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_background_flag") == 1)
        return TRUE;

    return FALSE;
}
