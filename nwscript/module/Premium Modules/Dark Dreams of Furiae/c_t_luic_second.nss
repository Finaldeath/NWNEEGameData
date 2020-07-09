// Returns true if you've spoken to Forvor today, but haven't spoken to Luicil yet

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_forv_spoke")
        && !GetLocalInt(GetModule(), "ddf_luic_met"))
        return TRUE;

    return FALSE;
}
