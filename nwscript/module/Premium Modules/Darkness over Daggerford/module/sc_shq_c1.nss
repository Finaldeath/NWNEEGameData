int StartingConditional()
{
    if(GetLocalInt(GetModule(), "StrongholdQuest_cleric") ==1)
    return TRUE;
    return FALSE;
}
