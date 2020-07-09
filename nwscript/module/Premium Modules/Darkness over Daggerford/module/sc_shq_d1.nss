int StartingConditional()
{
    if(GetLocalInt(GetModule(), "StrongholdQuest_druid") ==1)
    return TRUE;
    return FALSE;
}
