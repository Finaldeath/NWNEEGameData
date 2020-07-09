int StartingConditional()
{
    //true if the holdfast rave is not active
    if(GetLocalInt(GetModule(),"holdfast_party_active")!=1)
    return TRUE;
    return FALSE;
}
