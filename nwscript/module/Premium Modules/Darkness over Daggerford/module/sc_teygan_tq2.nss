//true if player is working on the teygan caravans quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"teygan_quests")==2)
    return TRUE;
    return FALSE;
}
