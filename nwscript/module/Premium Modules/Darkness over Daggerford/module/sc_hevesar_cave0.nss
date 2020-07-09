//player has not solved drop off cave quest
int StartingConditional()
{
    if(!GetLocalInt(GetModule(),"dropoffquest")>0)
    return TRUE;
    return FALSE;
}
