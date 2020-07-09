// Returns true if the player has NOT gotten Terana's name

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_tera_name"))
        return FALSE;

    return TRUE;
}
