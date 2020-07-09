int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_guvner_gain_entrance"))
        return TRUE;

    return FALSE;
}
