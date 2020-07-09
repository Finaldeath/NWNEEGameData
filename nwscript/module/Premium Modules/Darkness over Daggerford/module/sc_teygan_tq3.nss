//true if player is working on the teygan adventurers quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"teygan_quests")==3)
    return TRUE;
    return FALSE;
}
