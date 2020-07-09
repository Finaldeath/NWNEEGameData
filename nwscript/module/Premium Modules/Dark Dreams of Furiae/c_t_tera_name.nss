// Returns true if the player HAS gotten Terana's name

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_tera_name"))
        return TRUE;

    return FALSE;
}
