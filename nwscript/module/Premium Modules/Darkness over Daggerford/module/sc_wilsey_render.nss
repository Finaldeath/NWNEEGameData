int StartingConditional()
{
    if(GetLocalInt(GetModule(),"render")==1)
    return TRUE;
    return FALSE;
}
