//Generic variable used to switch to the 'no talk' branch.
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nNoTalk") == 1))
        return FALSE;

    return TRUE;
}
