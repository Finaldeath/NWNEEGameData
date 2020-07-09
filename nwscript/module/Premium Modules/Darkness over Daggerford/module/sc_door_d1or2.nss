//returns whether the doorman has informed the PC about the dress code but they
//are not currently complying
int StartingConditional()
{
    if (GetLocalInt(GetModule(), "doorman")==1||
    GetLocalInt(GetModule(), "doorman")==2)
    return TRUE;
    return FALSE;
}
