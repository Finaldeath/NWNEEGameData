int StartingConditional()
{
    if(GetLocalInt(GetModule(), "vejoni_dead") == 2)
        return FALSE;
    if(!GetLocalInt(GetModule(),"vejoni_named")==1)
    return TRUE;
    return FALSE;
}
