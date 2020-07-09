//player has solved drop off cave quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"dropoffquest")==1)
    return TRUE;
    return FALSE;
}
