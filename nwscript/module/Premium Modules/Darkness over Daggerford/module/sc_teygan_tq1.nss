//true if player is working on the teygan bandit quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"teygan_quests")==1)
    return TRUE;
    return FALSE;
}
