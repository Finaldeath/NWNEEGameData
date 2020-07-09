int StartingConditional()
{
    //the hevesar plot line is still active
    if(GetLocalInt(GetModule(), "hevesar_plot") <6)
    return TRUE;
    return FALSE;
}
