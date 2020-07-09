//January 2006
// B W-Husey
// PC knows his father's grave is defaced and not yet confronted culprit
// Used in various dialogues.
int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "nJennyDone") == 0)//not spoken to Jenny yet
        return FALSE;
    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 5)
        return TRUE;
    if(GetLocalInt(GetPCSpeaker(), "nGrave") == 6)
        return TRUE;

    return FALSE;
}
