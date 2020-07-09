//January 2006
// B W-Husey
// nPiracy = 7 or 8 (Castle sunk with or without ship inside)
// Hawklin2 dialogue

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nPiracy") < 7)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nPiracy") > 8)
        return FALSE;

    return TRUE;
}
