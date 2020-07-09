int StartingConditional()
{
    //simple check to see if the player has met hevesar
    if(GetLocalInt(GetModule(), "hevesar_met")==1)
    return TRUE;
    return FALSE;
}
