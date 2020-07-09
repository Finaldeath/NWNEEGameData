// Returns true if you have NOT ever spoken to Divala

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_diva_met"))
        return FALSE;

    return TRUE;
}
