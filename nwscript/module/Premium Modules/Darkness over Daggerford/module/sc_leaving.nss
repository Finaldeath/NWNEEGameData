//generic script for despawning npcs
int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF,"i_am_leaving")==1)
    return TRUE;
    return FALSE;
}
