int StartingConditional()
{
    //astriel has told the pc to head to the tollbark base
    if(GetLocalInt(GetModule(), "astriel_has_revealed") ==1)
    return TRUE;
    return FALSE;
}
