int StartingConditional()
{
    //player has not yet activated the hevesar quests fully
    if(GetLocalInt(GetModule(), "hevesar_plot") <3)
    return TRUE;
    return FALSE;
}
