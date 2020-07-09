// are the main daggerford gates closed?

int StartingConditional()
{
    if(!(GetLocalInt(GetModule(), "pm_Daggerford_open") == 0))
        return FALSE;

    return TRUE;
}
