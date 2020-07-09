//true if player is not briefed by teygan
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"teygan_quests") <1)
    return TRUE;
    return FALSE;
}
