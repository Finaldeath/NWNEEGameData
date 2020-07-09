int StartingConditional()
{
    //hevesar's critical path plots are not complete
    if(GetLocalInt(GetModule(), "hevesar_plot") <6)
    return TRUE;
    return FALSE;
}

