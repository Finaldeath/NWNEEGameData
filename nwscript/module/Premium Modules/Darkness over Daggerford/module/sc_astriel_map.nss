int StartingConditional()
{
    //conv option does not appear after astriel sends player to the trollbark
    if(!GetLocalInt(GetModule(), "astriel_has_revealed") == 1)
    return TRUE;
    return FALSE;
}
