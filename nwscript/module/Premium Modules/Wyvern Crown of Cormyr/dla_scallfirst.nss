// June 2003
// B W-Husey
// Generic first time talker script: uses tag of speaker to make unique variable.
// Can be used on any and every character. Stops first time conversation firing if nFirstXXX > 0 (see at_first)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nFirst"+GetTag(OBJECT_SELF)) == 0))
        return FALSE;

    return TRUE;
}
