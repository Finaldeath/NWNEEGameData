int StartingConditional()
{
    //the shadows in the fields plot is active
    if(GetLocalInt(GetModule(), "hevesar_plot")==4)
    return TRUE;
    return FALSE;
}
