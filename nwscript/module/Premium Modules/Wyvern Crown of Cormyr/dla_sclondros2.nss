//B W-Husey
// September 2005
// Londro Sidequest variable =2, quest has been taken.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") == 2)
        return TRUE;

    return FALSE;
}
