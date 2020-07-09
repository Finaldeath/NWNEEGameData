int StartingConditional()
{
    if(GetLocalInt(GetModule(),"db_nell_hasmet")==1)
    return TRUE;
    return FALSE;
}
