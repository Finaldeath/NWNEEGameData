int StartingConditional()
{
    if(GetLocalInt(GetModule(),"jerick_talk")==1)
    return TRUE;//pc has met and talked to Jerick
    return FALSE;
}
