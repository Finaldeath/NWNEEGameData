int StartingConditional()
{
    //true if player has already met white glove
    if(GetLocalInt(GetModule(), "whiteglove_met") ==1)
    return TRUE;
    return FALSE;
}
