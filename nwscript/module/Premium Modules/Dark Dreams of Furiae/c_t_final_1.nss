int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_choice") == 1)
    {
        return TRUE;
    }

    return FALSE;
}
