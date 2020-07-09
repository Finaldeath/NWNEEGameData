// PC has taken and at least partially resolved abduction quest.
int StartingConditional()
{

    // Inspect local variables
    int nVar = GetLocalInt(GetPCSpeaker(), "nAbduct");

    if(nVar < 6 && nVar > 1)
        return TRUE;
        return FALSE;
}
