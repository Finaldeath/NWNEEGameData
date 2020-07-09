int StartingConditional()
{
    //hevesar's critical path plots are complete or player has already told JL that his dady is safe
    if(GetLocalInt(GetModule(), "hevesar_plot") ==6||
    GetLocalInt(GetModule(), "jericks_lad_happy") ==1)
    return TRUE;
    return FALSE;
}
