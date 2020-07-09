int StartingConditional()
{
    //the player has met Hevesar but not agreed to help
    if(GetLocalInt(GetModule(), "hevesar_plot")==1)
    return TRUE;
    return FALSE;
}
