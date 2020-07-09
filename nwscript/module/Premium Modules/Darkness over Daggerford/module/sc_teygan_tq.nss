//true if player is working on the teygan's quests
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"teygan_quests") >0)
    return TRUE;
    return FALSE;
}
