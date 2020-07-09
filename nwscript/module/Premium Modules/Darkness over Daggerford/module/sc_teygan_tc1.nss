//true if player is working on the teygan caravan quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"teygan_caravans")==1)
    return TRUE;
    return FALSE;
}
