int StartingConditional()
{
    //shadows in fields quest active and not solved
    if(GetLocalInt(GetModule(), "hevesar_plot")== 4 &&
       !GetLocalInt(GetModule(), "fieldsquest")== 1)
    return TRUE;
    return FALSE;
}
