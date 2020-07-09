int StartingConditional()
{
    //lashar has told the player to see White Glove
    if(GetLocalInt(GetModule(), "lashar_white") ==1)
    return TRUE;
    return FALSE;
}
