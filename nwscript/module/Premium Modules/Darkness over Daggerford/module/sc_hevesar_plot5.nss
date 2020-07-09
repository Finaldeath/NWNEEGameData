int StartingConditional()
{
    //the missing farmers plot is active
    if(GetLocalInt(GetModule(), "hevesar_plot")==5)
    return TRUE;
    return FALSE;
}
