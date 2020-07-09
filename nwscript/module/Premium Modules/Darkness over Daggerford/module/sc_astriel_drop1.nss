int StartingConditional()
{
    //drop off cave quest active and not solved
    if(GetLocalInt(GetModule(), "hevesar_plot")== 5 &&
       GetLocalInt(GetModule(), "dropoffquest")== 1)
    return TRUE;
    return FALSE;
}
