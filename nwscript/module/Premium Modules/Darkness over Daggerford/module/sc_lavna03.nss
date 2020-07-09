int StartingConditional()
{
    //the animal rustling plot is active
    if(GetLocalInt(GetModule(), "hevesar_plot")==3 &&
       GetLocalInt(GetModule(), "kitchenquest") == 0)
    return TRUE;
    return FALSE;
}
