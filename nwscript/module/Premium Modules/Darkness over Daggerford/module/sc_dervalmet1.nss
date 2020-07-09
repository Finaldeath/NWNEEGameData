//returns true if pc has met derval already
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"derval_met")==1)
    return TRUE;
    return FALSE;
}
