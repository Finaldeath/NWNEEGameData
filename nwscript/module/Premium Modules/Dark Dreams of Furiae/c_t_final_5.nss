int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_choice") == 5)
    {
        return TRUE;
    }

    return FALSE;
}
