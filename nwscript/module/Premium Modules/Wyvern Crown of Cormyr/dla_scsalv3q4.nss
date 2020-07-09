//January 2006
// B W-Husey
// nPiracy = 4 (Pirate ship on fire)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nPiracy") == 4))
        return FALSE;

    return TRUE;
}
