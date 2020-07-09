int StartingConditional()
{
    //the pc has not yet solved the drop off cave plot
    if(GetLocalInt(GetModule(), "hevesar_plot") <5)
    return TRUE;
    return FALSE;
}
