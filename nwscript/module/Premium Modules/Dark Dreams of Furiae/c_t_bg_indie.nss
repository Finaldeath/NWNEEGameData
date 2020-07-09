// Returns true if the user IS independent

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_background_flag") == 3)
        return TRUE;

    return FALSE;
}
