int StartingConditional()
{
    if(GetLocalInt(GetObjectByTag("pm_marinerguard"), "has_met_pc") != 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
