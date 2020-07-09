// Returns true if the user HAS asked Forvor for information

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_asked"))
        return TRUE;

    return FALSE;
}
