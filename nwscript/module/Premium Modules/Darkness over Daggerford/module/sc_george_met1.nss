int StartingConditional()
{
    //true if the player has spoken with george once already.
    if(GetLocalInt(GetModule(), "george_met") ==1)
    return TRUE;
    return FALSE;
}
