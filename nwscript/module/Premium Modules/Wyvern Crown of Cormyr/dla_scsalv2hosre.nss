//PC was rewarded a horse/got 3+ kills
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nBHorse") == 1))
        return FALSE;

    return TRUE;
}
