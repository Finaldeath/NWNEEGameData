int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_choice") == 4)
    {
        return TRUE;
    }

    return FALSE;
}
