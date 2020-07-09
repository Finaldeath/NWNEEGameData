// January 2006
// B W-Husey
// Piracy quest in states 4 to 8, some action taken but not completed.
// Found on hawklin2 dialogue
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nPiracy") < 9))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nPiracy") > 3))
        return FALSE;

    return TRUE;
}
