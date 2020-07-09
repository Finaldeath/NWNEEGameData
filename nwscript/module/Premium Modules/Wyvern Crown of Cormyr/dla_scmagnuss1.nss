// October 2005
// B W-Husey
//nPoltergeist is = 1, i.e. the PC does not yet have the Holy Water required for the quest, but knows of it.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nPoltergeist") != 1)
        return FALSE;

    return TRUE;
}
