int StartingConditional()
{
    //simple check to see if the player has met hevesar in Liam's Hold
    if(GetLocalInt(GetModule(), "iMetHevesarLH")==1)
    return TRUE;
    return FALSE;
}
