int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_teddy_dead") == TRUE)
    {
        return TRUE;
    }

    return FALSE;
}
