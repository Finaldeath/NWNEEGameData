int StartingConditional()
{
    //the player has met Hevesar and agreed to help
    if(GetLocalInt(GetModule(), "hevesar_plot")==2)
    return TRUE;
    return FALSE;
}
