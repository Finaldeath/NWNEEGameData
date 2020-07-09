// Returns true if Luicil should go through their once-daily dialogue

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_luic_met")
        && !GetLocalInt(GetModule(), "ddf_luic_spoke"))
        return TRUE;

    return FALSE;
}
