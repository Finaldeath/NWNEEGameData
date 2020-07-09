int StartingConditional()
{
    if(GetLocalInt(GetModule(), "StrongholdQuest_mage") ==1)
    return TRUE;
    return FALSE;
}
