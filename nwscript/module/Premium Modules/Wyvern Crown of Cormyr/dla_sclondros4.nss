//B W-Husey
// September 2005
// Londro Sidequest variable = 4, convinced Matron (verbal).

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") == 4)
        return TRUE;

    return FALSE;
}
