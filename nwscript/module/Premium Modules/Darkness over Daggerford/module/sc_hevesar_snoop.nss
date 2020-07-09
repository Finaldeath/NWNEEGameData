int StartingConditional()
{
    //true if the player has tried to enter the stronghold
    if(GetLocalInt(GetModule(), "stronghold_snoop") == 1)
    return TRUE;
    return FALSE;
}
