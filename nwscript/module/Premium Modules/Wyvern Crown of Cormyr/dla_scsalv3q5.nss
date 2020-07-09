//January 2006
// B W-Husey
// nPiracy = 5 (Salvatori Dead)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nPiracy") == 5))
        return FALSE;

    return TRUE;
}
