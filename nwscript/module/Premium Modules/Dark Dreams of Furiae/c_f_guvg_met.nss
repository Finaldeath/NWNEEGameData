// Returns true if you have NOT ever spoken to the Guvner Guards

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_guvg_met"))
        return FALSE;

    return TRUE;
}
