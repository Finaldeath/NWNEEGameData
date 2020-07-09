//January 2006
// B W-Husey
// nPiracy = 6 (Salvatori Dead)

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nPiracy") == 6))
        return FALSE;

    return TRUE;
}
