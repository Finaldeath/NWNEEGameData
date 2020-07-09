int StartingConditional()
{
    if(GetLocalInt(GetModule(), "StrongholdQuest_fighter") ==1)
    return TRUE;
    return FALSE;
}
