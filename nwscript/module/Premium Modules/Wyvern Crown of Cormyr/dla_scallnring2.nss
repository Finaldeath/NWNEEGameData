//Tests to see if Jonas's belongings were found at Polter's Fort.
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nQRing") == 2))
        return FALSE;

    return TRUE;
}
