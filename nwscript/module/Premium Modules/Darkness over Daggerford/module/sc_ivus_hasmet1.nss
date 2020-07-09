int StartingConditional()
{
    if(GetLocalInt(GetModule(),"db_ivus_met")==1)
    return TRUE;
    return FALSE;
}
