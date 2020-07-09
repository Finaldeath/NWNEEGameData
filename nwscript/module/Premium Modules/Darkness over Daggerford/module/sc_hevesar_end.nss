int StartingConditional()
{
    if( (GetLocalInt(GetModule(),"fieldsquest")==2)&&
        (GetLocalInt(GetModule(),"kitchenquest")==2)&&
        (GetLocalInt(GetModule(),"dropoffquest")==2))
    return TRUE;
    return FALSE;
}
