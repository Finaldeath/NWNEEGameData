int StartingConditional()
{
    //true if the player has read or taken fzoul's note
    //in the trollbark lair
    if(GetLocalInt(GetModule(), "astriel_fzoulnote") ==1)
    return TRUE;
    return FALSE;
}
