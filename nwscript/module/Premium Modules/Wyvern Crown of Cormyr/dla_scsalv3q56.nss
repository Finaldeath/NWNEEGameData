//January 2006
// B W-Husey
// nPiracy = 5 or 6 (killed or struck a deal with Salvatori)

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nPiracy") < 5)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nPiracy") > 6)
        return FALSE;

    return TRUE;
}
