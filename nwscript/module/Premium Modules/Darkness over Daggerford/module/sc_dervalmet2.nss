//returns true if pc has met derval already
//and accepted illefarn mission
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"derval_met")==2)
    return TRUE;
    return FALSE;
}
