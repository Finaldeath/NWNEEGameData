int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_choice") == 3)
    {
        return TRUE;
    }

    return FALSE;
}
