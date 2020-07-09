int StartingConditional()
{
    //player has visited the drop off cave ahead of the relevant hevesar quest
    if(GetLocalInt(GetModule(), "drop_off_empty") ==1 &&
       GetLocalInt(GetModule(), "hevesar_plot") <5)
    return TRUE;
    return FALSE;
}
