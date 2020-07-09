// Returns true if the player has NOT asked Forvor for any information

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_asked"))
        return FALSE;

    return TRUE;
}
