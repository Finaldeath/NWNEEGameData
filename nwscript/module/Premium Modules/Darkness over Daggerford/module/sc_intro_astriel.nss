//Amara has met the pc during the intro
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"amara_intro_metpc")==1)
    return TRUE;
    return FALSE;
}
