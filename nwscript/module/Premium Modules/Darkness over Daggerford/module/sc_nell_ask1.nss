int StartingConditional()
{
    if(GetLocalInt(GetModule(),"nell_ask")==1)
    return TRUE;
    return FALSE;
}
