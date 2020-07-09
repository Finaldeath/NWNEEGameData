int StartingConditional()
{
    //kitchens quest active and not solved
    if(GetLocalInt(GetModule(), "hevesar_plot")== 3 &&
       !GetLocalInt(GetModule(), "kitchenquest")== 1)
    return TRUE;
    return FALSE;
}
