int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_teddy_dead") == FALSE)
    {
        return TRUE;
    }

    return FALSE;
}
