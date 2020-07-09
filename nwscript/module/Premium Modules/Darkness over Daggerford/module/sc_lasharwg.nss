int StartingConditional()
{
    //true if the player has killed vejoni but not yet met WG
    if(GetLocalInt(GetModule(), "vejoni_dead") ==1 &&
    GetLocalInt(GetModule(), "whiteglove_met") !=1)
    return TRUE;
    return FALSE;
}
