int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_choice") == 2)
    {
        return TRUE;
    }

    return FALSE;
}
