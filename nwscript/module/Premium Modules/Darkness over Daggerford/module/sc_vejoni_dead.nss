int StartingConditional()
{
    if(GetLocalInt(GetModule(),"vejoni_dead")==1)
    return TRUE;
    return FALSE;
}
