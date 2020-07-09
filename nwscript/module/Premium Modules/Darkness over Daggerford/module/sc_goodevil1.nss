int StartingConditional()
{
    if(GetLocalInt(GetModule(),"good_evil")==1)
    return TRUE;
    return FALSE;
}
