// Returns true if you HAVE ever spoken to the Guvner Guards

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_guvg_met"))
        return TRUE;

    return FALSE;
}
